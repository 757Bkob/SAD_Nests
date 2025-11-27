--[[
----------------------------- HELPER FUNCTIONS ------------------------------
function Get_difficulty_offset()
    local difficulty_offset = 2
    local difficulty = GetGameDifficulty()

    if difficulty == 'Easy' then
        difficulty_offset = 1
    elseif difficulty == 'Medium' then
        difficulty_offset = 2
    elseif difficulty == 'Hard' then
        difficulty_offset = 3
    elseif difficulty == 'VeryHard' then
        difficulty_offset = 4
    elseif difficulty == 'Insane' then
        difficulty_offset = 5
    elseif difficulty == 'PXImpossible' then
        difficulty_offset = 6
    else
        difficulty_offset = 7
    end
    return difficulty_offset
end

function Get_nest_by_region()
	DebugPrint("Getting nest class id by region\n")
    if Region.id == 'Desertum' then
        return 'ShriekerNest'
    elseif Region.id == 'Sobrius' then
        return "ShriekerNest"
    elseif Region.id == 'Saltu' then
        return 'ScissorhandsNest'
	else
		return 'ShriekerNest'
    end
end

function Is_DLC_Present()
	DebugPrint("Checking if DLC loaded\n")
	return TradingShips['SmallCargoShip']
end

function Get_center_of_survivors()
    local surv = GetValidSurvivorsOnMap()
    local sum_x = 0
    local sum_y = 0
    local count = 0
    local x = 0
    local y = 0
    for _,v in ipairs(surv) do
        x,y,_ = v:GetVisualPosXYZ()
        sum_x = sum_x + x
        sum_y = sum_y + y
        count = count + 1
    end
    local center = point(DivRound(sum_x,count),DivRound(sum_y,count))
    return center
end

function NA_Mod_Set(id)
	id = id or CurrentModId
	if CurrentModId ~= id or not CurrentModOptions then return end
	--ilu_set_map_vars() --
	local options = CurrentModOptions
	local nest_notif = options.nests_awaken_notifications
	local nest_level = 1
	--(nest_notif)
	if nest_notif == 'Full Popup' then
		nest_level = 2
	elseif nest_notif == 'Notifications Only' then
		nest_level = 1
	elseif nest_notif == 'Do not Alert me (<style TextNegative>Warning Dangerous</style>)' then
		nest_level = 0
	end
	if not MapVarValues.Nest_Notifications then
		MapVar("Nest_Notifications",nest_level)
	else
		MapVarValues["Nest_Notifications"]=nest_level
	end
end

--]]

--[[
---------------------------------ENHANCED NESTS---------------------------------
local hour_duration = const.HourDuration
local day_duration = const.DayDuration
local hours_per_day = day_duration / hour_duration

function SpawnNestInsideMap(marker, seed, nest_type, danger_lvl)
	DebugPrint("Spawning a nest\n")
	if marker and terrain.IsWater(marker) then
		return
	end
	-- danger level does nothing right now, not part of MVP
    danger_lvl = danger_lvl or 1
    seed = seed or InteractionRand(nil, "DailySpawn")
    local tags = {}
    nest_type = nest_type or Get_nest_by_region()
    if not nest_type then
        return
    elseif nest_type == 'ShriekerNest' then
        tags = { shrieker_fall = true }
    elseif nest_type == 'ScissorhandsNest' then
        tags = { scissorhands_nest = true }
    else
		--("Using backup, whatever nest type is the tag!")
		--(nest_type)
        tags[nest_type] = true -- future proof for PX, the nest_type input will be the needed tag
    end
	--(tags)
	SuspendPassEdits("SpawndNest")
	seed = seed or InteractionRand(nil, "DailySpawn")
	local nest
	--(seed)
	--()
	local err, objs, pos, prefab, name, inv_bbox = marker:PlacePrefab(seed, {
		tags_all = tags,
	})
	if not err then
		local nest_marker = FindFirstIsKindOf(objs, "TerritorialNestMarker")
		if nest_marker then
			nest = nest_marker:SpawnNest(true)
		else
			assert(false, "Prefab without a Scissorhands nest marker: " .. name)
		end
	else
		assert(false, "Prefab error: " .. err)
	end
	ResumePassEdits("SpawndNest")
	return nest
end

function PlacePrefabLogic:GetPrefabLoc(seed, params)
	seed = seed or InteractionRand(nil, "PlacePrefab")
	local name, pos, angle, prefab, idx
	--("Params")
	--(params)
	local prefabs = self:GetPrefabs(params)
	--("Initial get of #prefabs")
	--(#prefabs)
	local r = 4
	local fresh_prefabs
	while #prefabs == 0 and r > 0 do
		--("RETRYING BECAUSE I FAILED TO FIND")
		prefabs = self:GetPrefabs(params)
		local fresh_prefabs = PlacePrefabLogic:GetPrefabs(params)
		--("non-self prefab get count")
		--(#fresh_prefabs)
		--("self get of #prefabs")
		--(#prefabs)
		r = r - 1
		if #fresh_prefabs > #prefabs then
			prefabs = fresh_prefabs
		end
	end
	local retry
	while true do
		local idx
		if #prefabs > 1 then
			prefab, idx, seed = table.weighted_rand(prefabs, "weight", seed)
		else
			prefab = prefabs[1]
		end
		----(prefab)
		assert(prefab)
		if not prefab then
			return
		end
		pos = params and params.pos
		if not pos then
			pos = self:GetVisualPos()
			if not self.FixAtCenter then
				local reserved_radius
				if params and params.avoid_reserved_locations and self.reserved_locations then
					reserved_radius = (prefab.min_radius + prefab.max_radius) * const.TypeTileSize / 2
				end
				local radius = prefab.max_radius * const.TypeTileSize
				local free_dist = self.MaxPrefabRadius - radius
				if free_dist > 0 then
					local center = pos
					pos = false
					local retries = params and params.avoid_reserved_retries or 16
					for i=1,retries do
						local ra, rr
						ra, seed = BraidRandom(seed, 360*60)
						rr, seed = BraidRandom(seed, free_dist)
						local pos_i = RotateRadius(rr, ra, center)
						if not reserved_radius or self:CheckReservedLocations(pos_i, reserved_radius) then
							pos = pos_i
							break
						end
					end
				elseif reserved_radius and not self:CheckReservedLocations(pos, reserved_radius) then
					pos = false
				end
			end
		end
		if pos then
			name = PrefabMarkers[prefab]
			angle = params and params.angle
			if not angle then
				angle = self:GetAngle()
				local rand_angle = self.RandAngle
				if rand_angle > 0 then
					local desired_angle = params and params.desired_angle
					if desired_angle then
						local angle_diff = AngleDiff(desired_angle, angle)
						if abs(angle_diff) <= rand_angle then
							angle = desired_angle
						else
							local min_angle, max_angle = angle - rand_angle, angle + rand_angle
							if abs(AngleDiff(desired_angle, min_angle)) < abs(AngleDiff(desired_angle, max_angle)) then
								angle = min_angle
							else
								angle = max_angle
							end
						end
					else
						local da
						da, seed = BraidRandom(seed, -rand_angle, rand_angle)
						angle = angle + da
					end
				end
			end
			return name, pos, angle, prefab, seed
		end
		if #prefabs == 1 then
			return
		end
		table.remove_rotate(prefabs, idx)
	end
end

RecursiveCallMethods.RegisterTarget = "call"

DefineClass.EnhancedTerritorialNest = {

    properties = {
        { category = "Nest", id = "state",                name = "State of nest", editor = "choice", template = true, items = { "asleep", "sleepy", "awake", "allied"}, default = 'asleep', modifiable = true, help = "state of the nest"},
        { category = "Nest", id = "attack_time",          name = "Nest Attack Time", editor = "number", default = max_int, modifiable = true, help = "When a nest will attack next if not asleep."},
        { category = "Nest", id = "attacks_done",         name = "Nest Attack Count", editor = "number", default = 0, modifiable = true, help = "Number of attacks this nest has sent total"},
        { category = "Nest", id = "attacks_to_evo",       name = "attacks needed to force evolution", editor = "number", default = 4, modifiable = true, help = "How much EP is needed to evolve the nest denizens"},
        { category = "Nest", id = "proximity",            name = "Nests proximity to players stuff", editor = "number", default = 1, modifiable = true, help = "Higher numbers indicate close distance to the players presence, and effects attack/evo/consumption rates"},
        { category = "Nest", id = "ui_attack_percent",    name = "How close the attack time is to occuring", editor = "number", scale = "%", default = 0, modifiable = true, help = ""},
        { category = "Nest", id = "ui_evo",               name = "How close this nest is too evolving it's herd", editor = "number", scale = "%", default = 0, modifiable = true, help = ""},
		{ category = "Nest", id = "base_strength",        name = "Base % str of an attack this will send", editor = "number", scale = "%", default = 30, modifiable = true, help = ""},
		{ category = "Nest", id = "consume_time",        name = "When nest will eat the next node", editor = "number", default = 0, modifiable = true, help = "This is routinely updated based on each individual nest"},
    },
    state = 'asleep',
	attack_time = max_int,
	attacks_done = 0,
	attacks_to_evo = 4,
	base_strength = 30,
	consume_time = max_int,
    proximity = 1,
    ui_attack_percent = 0,
    ui_evo = 0,
}

function EnhancedTerritorialNest:Init()
	self.attack_time = max_int
	self.consume_time = max_int
    CreateGameTimeThread(function(this_nest)
        Sleep(day_duration)
        self:UpdateNextAttackTime()
		self:get_proximity()
    end,self)
end

function EnhancedTerritorialNest:get_next_consume_time()
	local wait_for = AsyncRand(hour_duration * 24,hour_duration * 36)
	self.consume_time = GameTime() + wait_for
end

--This technically just increases the nest members, because the base game uses the nests herd to set the controlled territory
function EnhancedTerritorialNest:expand()
	DebugPrint("Nest Expanding it's territory!\n")
    local expand_by = 6
    local nodes = 0
    local max_growths = 5
    local grows = 0
    while nodes < 30 and grows < max_growths do
        --(nodes)
        --("expanded the distance ",grows,' times')
        nodes = MapCount(self,(self.territorial_range+(grows*expand_by))*guim,function(thing)
            if not IsKindOf(thing,'NestSpore') then return true end end)
        grows = grows + 1
        --("At this increased radius, there are ",nodes,' valid nodes to consume')
    end
    --("There was enough nodes nearby to warrant an increase of",grows*expand_by,' meter radius')
    self.elders_max_count = self.elders_max_count + grows
    self.hatchlings_max_count = self.hatchlings_max_count + grows
    self.adults_max_count = self.adults_max_count + grows
end

function EnhancedTerritorialNest:give_ep_to_struct(ep)
    if not ep then return end
	DebugPrint("Nest storing EP in support structures\n")
    local spore_count = MapGet(self,self.territorial_range,function(thing)
    if IsKindOf(thing,'NestSpore') then return true end end)
    local spore = spore_count[1]
    local spore_res = Resources[spore.MineResource]
    local spore_res_prog = spore_res.progress
	spore_count = #spore_count
    local progress_each = DivRound(ep,spore_count)
    local units_to_give = Max(1,DivRound(progress_each,spore_res_prog))
    --("Giving each of the ",spore_count,' nearby nest nodes ', units_to_give,' ',spore_res.id)
    MapForEach(self,self,self.territorial_range,function(thing)
        if IsKindOf(thing,'ShriekerSporeDeposit') or IsKindOf(thing,'ScissorhandSporeDeposit') or IsKindOf('ConsortiumSporeDeposit') or IsKindOf('ConsortiumSporeDeposit') then
            thing.MineAmount = thing.MineAmount + (units_to_give * const.ResourceScale)
        end
    end,units_to_give)
end

function EnhancedTerritorialNest:consume_closest_node()
	DebugPrint("Nest consuming nearest node\n")
	self.consume_time = max_int
    local closest_res = MapFindNearest(self,self,self.territorial_range,"EntityClass",function(thing)
    if (IsKindOf(thing,'MineableRock') or IsKindOf(thing,'Plant')) and not (IsKindOf(thing,'NestSpore')) then return true end end)
	-- local closest_res = MapFindNearest(closest_reses)
    if not closest_res then
        self:expand()
		return --we expand instead of consuming
    end
    local res
    local amount
    if IsKindOf(closest_res,'Plant') then
        local res_array = closest_res:GetCutResources() or closest_res:GetHarvestResources()
        res = res_array[1]['resource']
        amount = res_array[1]['amount']
    else
        res = closest_res.MineResource
        amount = closest_res.MineAmount
    end
    local node_res_units = DivRound(amount,const.ResourceScale)
    local ep_scale = 1000
    local progress = DivRound(Resources[res].progress*node_res_units,10)
    --("Nest is eating a ",closest_res.class)
    --('Node has ',node_res_units, ' of ',res, ' in it! which is ',progress,' EP')
    local EP_to_give = DivRound(progress,4) -- flat 1/4 of EP is stored, the rest are "used" to grow / evolve
    --("Giving this much EP collectively to the nest nodes: ",EP_to_give)
    DoneObject(closest_res)
    self:give_ep_to_struct(EP_to_give)
	local attack_cd = Game:GetCooldowns()['Attack']
	self.attack_time = self.attack_time - DivRound(attack_cd,100)
	self:get_next_consume_time()
end

function EnhancedTerritorialNest:GetStoryBitPopupImage()
    local nest = get_nest_type()
    if nest == 'ShriekerNest' then
        return 'Mod/TGkJ3Tu/Shrieker_Nest.PNG'
    elseif nest == 'ScissorhandsNest' then
        return 'Mod/TGkJ3Tu/Scissor_Nest.PNG'
    end
end

function EnhancedTerritorialNest:get_proximity()
	DebugPrint("Proximity check triggered, it should not... yet\n")
    local closest_building = MapFindNearest(self,true,"Building")
    local closest_human = MapFindNearest(self,true,"Building")
	closest_human = GetDist(self, closest_human)
	local close
	if closest_building then
		closest_building = GetDist(self, closest_building)
		if closest_building > closest_human then
			close = closest_building
		else
			close = closest_human or max_int
		end
	end
	DebugPrint("closest_human ")
	DebugPrint(closest_human)
	DebugPrint("\n")
	DebugPrint("closest_building ")
	DebugPrint(closest_building)
	DebugPrint("\n")
    local rate = 300 * guim --300 meters per threshold
    local prox = DivRound(close,rate)
	prox = 6 - Clamp(prox,1,5) -- closest nests have a prox of 5
	self.proximity = prox
	return prox
end

function EnhancedTerritorialNest:Getui_evo()
	DebugPrint("Getting the UI % how close to an evo the nest is\n")
    local option_1 = DivRound(self.attacks_done * 100,self.attacks_to_evo)
    local option_2 = check_count_and_upgrade(self.elder_class,{},100)
    if option_2 ~= self.elder_class then
        return 100 -- will show 100% if the EP is already high enough to trigger a "passive" evo
    else
        return Max(1,option_1)
    end
end

function EnhancedTerritorialNest:IsAsleep()
    return self.state == 'asleep'
end

function EnhancedTerritorialNest:IsAwake()
    return self.state == 'awake'
end

function EnhancedTerritorialNest:IsSleepy()
    return self.state == 'sleepy'
end

function EnhancedTerritorialNest:Getui_attack_percent()
	DebugPrint("Getting the UI % of how close an attack from the nest is\n")
	local time_till_attack = self.attack_time - GameTime()
	local num = Game:GetCooldowns()['Attack']-time_till_attack
	local percent=DivRound(num*100,Game:GetCooldowns()['Attack'])
	return Max(1,percent)
end

function EnhancedTerritorialNest:change_nest_herd(force_evo)
	DebugPrint("Nest calculating if it needs to upgrade\n")
	DebugPrint("Was this a forced evo?\n")
	DebugPrint(force_evo)
	DebugPrint('\n')
    local elder, adult, baby = self.elder_class, self.adult_class, self.hatchling_class
    local evo, _, _ = check_count_and_upgrade(elder,{},100)
    if evo == elder and not force_evo then return
    else
		local notif_level = MapVarValues['Nest_Notifications'] or 1
		if notif_level == 2 then
			ForceActivateStoryBit('nests_evolving',self,true)
		elseif notif_level == 1 then
			AddGameNotification("nests_evolving", nil, nil, {self})
		end
        self.hatchling_class = adult
        self.adult_class = elder
        self.elder_class = evo
        -- remove any newly-invalid creatures from nest_creatures
        local removed = false
        for _, unit in ipairs(self.nest_members) do
		    local class = unit.class
		    if not class == self.elder_class and not class == self.adult_class and not class == self.hatchling_class then
                self:RemoveNestMember(unit)
                -- This will force spawn a new set of higher tier nests. 
                -- If Nests are left unnattended they can get quite large groups defending it
		    end
        end
        if removed then
            self:UpdateNextSpawnTime()
        end
	end
    if force_evo then
        self.attacks_done = 0
        self.attacks_to_evo = self.attacks_to_evo + 1
    end
end

function EnhancedTerritorialNest:RegisterTarget(unit, time)
    local tags = unit['UnitTags']
    if not tags then return end 
    if self.state == 'asleep' and tags['Human'] then
		DebugPrint("Nest registering a human attacker!\n")
        self:SwitchState('sleepy')
        --ForceActivateStoryBit('asleep_too_sleepy'
    end
end

function EnhancedTerritorialNest:set_new_max_hp()
	DebugPrint("Nest raising max HP\n")
    local base_hp = 100000
    local diff = Get_difficulty_offset()
    local max_possible_hp = base_hp * 100 * diff
    if self.state == 'awake' then
        self.MaxHealth = max_possible_hp
        self.health_regen = 5
    elseif self.state == 'sleepy' then
        self.MaxHealth = DivRound(max_possible_hp,2)
        self.health_regen = 1
    elseif self.state == 'asleep' then
        self.health_regen = 0
        self.MaxHealth = base_hp
    end
end


function EnhancedTerritorialNest:SwitchState(new_state)
	DebugPrint("Nest switching it's internal state!\n")
    new_state = new_state or nil
	local notif_level = MapVarValues['Nest_Notifications'] or 1
    if not new_state or new_state == self.state then
        return
	end
    if new_state == 'sleepy' and self.state == 'asleep' then
		if notif_level == 2 then
			ForceActivateStoryBit('asleep_too_sleepy',self,true)
		elseif notif_level == 1 then
			AddGameNotification("waking_up", nil, nil, {self})
		end
	elseif new_state == "asleep" and not (self.state == "awake") then
		if notif_level == 2 then
			-- woken up
			ForceActivateStoryBit('back_to_sleep',self,true)
		elseif notif_level == 1 then
			AddGameNotification("back_to_sleep", nil, nil, {self})
		end
    end
    self.state = new_state
    self:UpdateNextAttackTime()
    self:set_new_max_hp()
end

function EnhancedTerritorialNest:calculate_attack_strength()
	DebugPrint("Nest calculating it's attack score\n")
	local base_strength = self.base_strength or 30
    local nests = MapCount(true,"TerritorialNest",function(other_nest,this_nest)
		if IsKindOf(other_nest,this_nest) and not (other_nest.state == 'asleep') then
			return true
		end
	end,self) * 10
	local diff_increase
	if Get_difficulty_offset() > 5 then
		diff_increase = 10
	else
		diff_increase = 0
	end
    local subsequent_attacks = self.attacks_done * 10
	local per = Max(200,base_strength + nests + subsequent_attacks + diff_increase)
	DebugPrint(per)
	DebugPrint("\n")
    return per
end

function EnhancedTerritorialNest:attack(fake_flag)
	DebugPrint("Nest is attacking!\n")
	if self.state == 'allied' then return end -- stub for PXR
    self:UpdateNextAttackTime()
    self:change_nest_herd() -- In case player has enough EP
    local spawn_def
	local find_spawn
	if fake_flag then
        spawn_def = SpawnDefs['nest_overflow']
		find_spawn = function(self, spawn_class, target)
			local def = spawn_class and g_Classes[self.nest.elder_class]
			local pfclass = def.pfclass
			local radius = self.nest.territorial_range
			local target_retry = 7
			for i=1,target_retry do
				local rand = InteractionRandCreate("SpawnFindTarget")
				local pos_nearish_nest = terrain.FindPassable(self.nest, pfclass, radius)
				if pos_nearish_nest then
					return pos_nearish_nest
				end
				DebugPrint("Nest via a passive attack failed spawnloc. radius now: ")
				DebugPrint(spawn_radius)
				DebugPrint(" meter radius\n")
				DebugPrint("pfclass was: ")
				DebugPrint(pfclass)
				DebugPrint("\n")
			end
			::continue::
			dbg(self:DbgMarkFailedSpawn(self.nest,7))
		end
	else
		spawn_def = SpawnDefs['nest_attack']
		find_spawn = function(self, spawn_class, target)
			local def = spawn_class and g_Classes[self.nest.elder_class]
			local pfclass = def.pfclass
			local spawn_radius = self.nest.territorial_range
			local target_radius = 30*guim
			local target_retry = 7
			local rand = InteractionRandCreate("SpawnFindTarget")
			local pos_nearish_nest
			local pos
			local survivors
			survivors = GetValidSurvivorsOnMap()
			if #survivors == 0 then return end
			local target_pos
			for i=1,target_retry do
				target_pos = survivors[AsyncRand(#survivors)]
				--("Retry attempt: "..i)
				local r = rand()
				local rand_retries = 4096
				local spot_closest_to_target =  terrain.FindPassable(target_pos, pfclass, target_radius)
				--  pos = ConnectivityRandomTile(r, spot_closest_to_target, target_pos, max_int, 0, pfclass, rand_retries)
				local possible_spawnpoint = terrain.FindPassable(self.nest, pfclass, spawn_radius)
				--local pos_nearish_nest = ConnectivityRandomTile(r, pos_of_nest, target, radius, 3*guim, pfclass, rand_retries)
				local target = self:ResolveTarget() --rerolling target in case nest cannot reach this person
				local closests_passable_point_near_target = terrain.FindPassable(target, pfclass, max_int)
				if ConnectivityCheck(possible_spawnpoint,spot_closest_to_target,pfclass) then
					return possible_spawnpoint
				end
				DebugPrint("Nest via real attack failed spawnloc. radius now: ")
				DebugPrint(spawn_radius)
				DebugPrint(" meter radius\n")
				DebugPrint("pfclass was: ")
				DebugPrint(pfclass)
				DebugPrint("\n")
				spawn_radius = spawn_radius * 2
				::continue::
				dbg(self:DbgMarkFailedSpawn(self.nest,7))
			end
		end
    end
    local instance = {}
    -- Not calling fill instance, because we are already in hard-code territory
    -- Consider the below the fill instance
    instance.nest = self
    instance.FindSpawnLoc = find_spawn
    instance.SpawnClass = self.elder_class
    spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	-- This spawndef explicitly only spawns 1 unit, so we are just giving 100% of that count
    spawn_def:ActivateSpawn(t,{},100)
    self.attacks_done = self.attacks_done + 1
    if self.attacks_to_evo == self.attacks_done then
        self:change_nest_herd(true)
    end
end


function EnhancedTerritorialNest:UpdateNextAttackTime()
	DebugPrint("Nest updating when to attack next\n")
    local diff = Get_difficulty_offset() - 3
    local attack_cd = Game:GetCooldowns()['Attack']
    if self.state == 'asleep' then attack_cd = attack_cd * 2 end
    --- calculate in percentage of attack_cd how often nests can 
    local diff_offset_min = 90
    local diff_offset_max = 110
    if diff < 0 then
        diff_offset_max = 100
        -- Means the save is on a med/easy mode and should never be faster 
    else
        diff_offset_min = diff_offset_min - abs(diff * 5) -- max diff attacks can trigger 30% faster
        diff_offset_max = diff_offset_min + abs(diff) -- max diff attacks can trigger 114% slower
    end
    local fastest_attack_allowed = DivRound((diff_offset_min * attack_cd),100)
    local slowest_attack_allowed = DivRound((diff_offset_max * attack_cd),100)
    self.attack_time =  GameTime() + AsyncRand(fastest_attack_allowed,slowest_attack_allowed)
	DebugPrint("Next attack time:\n")
	DebugPrint(self.attack_time)
	DebugPrint("\nGame Time:\n")
	DebugPrint(GameTime())
	DebugPrint("\n")
end


function EnhancedTerritorialNest:OnObjUpdate(time, update_interval)
	local health = self.Health
	if health <= 0 then return end
    if self.attack_time < GameTime() then
		DebugPrint("Nest thinks it's time to attack\n")
        if self.state == 'awake' then -- trigger all the same nests to attack
		DebugPrint("Triggering all nests of this type to attack!\n")
            MapForEach(true,'TerritorialNest',function(special_nest,this_nest)
                -- This will include itself
                if this_nest.class == special_nest.class then
                    special_nest:attack()
                end
            end,self)
            ForceActivateStoryBit('mass_nest_attack',self,true)
        elseif self.state == 'sleepy' then
            self:attack()
            ForceActivateStoryBit('single_nest_attack',self,true)
        elseif self.state == 'asleep' then
            self:attack(true) -- true means to use the nest_overflow spawndef
        end
    end
	if self.consume_time < GameTime() then
		DebugPrint("Nest GameThread triggering!\n")
        self:consume_closest_node()
	end
end

function UnitNesting:OnObjUpdate()
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	local effect = self.NestEffect or ""
	if effect == "" then
		return
	end
	local nest_nearby = self:IsCloser(nest, nest.territorial_range) or false
	if nest_nearby == self.nest_nearby then
		return
	end
	self:give_nest_effect()
end

-- override of base game function to give nest effect in case things go wrong
function TerritorialNest:AddNestMember(member)
	table.insert(self.nest_members, member)
	-- mark guardian members as such (they stay close to the nest and protect it if attacked)
	self:TrySetNestGuardian(member)
	member:give_nest_effect()
end

function UnitNesting:give_nest_effect()
	if not self.nest then return end
	local nest = self.nest
	local give = self:IsCloser(nest, nest.territorial_range)
	if give then
		if IsKindOf(self,"Robot") then
			self:AddRobotCondition('FamiliarGroundRobo','mod')
		else
			self:AddHealthCondition(self.NestEffect or "", "nest")
		end
	elseif IsKindOf(self,"Robot") then
		self:RemoveRobotCondition('FamiliarGroundRobo','mod')
	else
		self:RemoveHealthConditions(self.NestEffect or "", "nest")

	end
end

--override of base game because base game function cannot spawn `Robot` units properly
function TerritorialNest:SpawnAround(class, range, instant, burrowed)
	local def = class and g_Classes[class]
	if not def then return end
	if burrowed and not def.CanBurrowInNest then return end
	if IsKindOf(def,'Robot') then
        local spawn_def = SpawnDefs['single_spawn_around_loc']
		local instance = {}
		instance.location = self
		instance.radius = range
		instance.PostSpawn = function(self,obj,target,context)
			obj:SetNest(self.location)
			obj:SetInvader(true)
		end
		instance.SpawnClass = class
		spawn_def = spawn_def:CreateInstance(instance)
		local t = spawn_def:ResolveTarget()
		print(spawn_def:ResolveSpawnClass())
		spawn_def:ActivateSpawn(t,{},self:calculate_attack_strength())
		return
	end
	local pfclass = def.pfclass
	local pos = terrain.FindPassableTile(self, const.tfpPassClass, pfclass)
	local x, y = GetRandomPlayablePos(pos, range, guim, self:RandSeed("SpawnNestMember"), pfclass, def.radius)
	if not x then return end
	local obj = def:new()
	obj:SetNest(self)
	obj:SetPosAngle(x, y, const.InvalidZ, self:GetAngle() + self:Random(360*60, "SpawnNestMember"))
	if not instant then
		obj.init_with_command = "CmdSpawn"
	end
	return obj
end

AppendClass.TerritorialNest = {
    __parents = { "EnhancedTerritorialNest" },
}

-- meta class grouping all spore buildings for easier searching
DefineClass.NestSpore = {
	properties = {}
}

AppendClass.ShriekerSporeDeposit = {
	__parents = { "NestSpore" }
}

AppendClass.ScissorhandSporeDeposit = {
	__parents = { "NestSpore" }
}

AppendClass.ConsortiumSporeDeposit = {
	__parents = { "NestSpore" }
}
--]]


--[[
AGGRESSION
function Aggression_log_faction(faction)
	DebugPrint("Logging an aggression event\n")
	local to_return = false
	local threshold = MapVarValues['faction_aggression_threshold']
	if not threshold then
		threshold = 5 - Get_difficulty_offset()
		threshold = Max(threshold,0)
		MapVar('faction_aggression_threshold',threshold)
	end
	local count = MapVarValues[faction] or 0
	if not count then
		count = 0
		MapVar(faction,0)
	end
	count = count + 1
	if count >= threshold then
		to_return = true
		MapVarValues[faction] = 0
	else
		MapVarValues[faction] = count
	end
	DebugPrint("Did this event trigger an aggression up?\n")
	DebugPrint(to_return)
	DebugPrint("\n")
	return to_return
end


local species_to_new_storybit_table = {}
species_to_new_storybit_table['ShriekerNest'] = 'new_nest_shrieker'
species_to_new_storybit_table['ScissorhandsNest'] = 'new_nest_scissorhand'
species_to_new_storybit_table['ConsortiumNest'] = 'new_nest_consortium'

function Add_To_Nest_Table(species,storybitname)
	species_to_new_storybit_table[species] = storybitname
end

local res_nest_mapping = {}
res_nest_mapping[#res_nest_mapping+1] = {res='Silicon',nest="ConsortiumNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='Synthetics',nest="ConsortiumNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='Ore',nest="ScissorhandsNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='RawMeat',nest="ScissorhandsNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='CarbonNanotubes',nest="ShriekerNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='RawMeatInsect',nest="ShriekerNest"}

function Add_to_res_nest_mapping(res,nest)
	res_nest_mapping[res] = {nest}
end
--]]

--function Resource_aggression_check(wierd_res_table)
--	if not wierd_res_table then return end
--	DebugPrint("A recipe completed\n")
--	local chance
--	for _,v_table in ipairs(res_nest_mapping) do
--		chance = wierd_res_table[v_table['res']]
--		if chance then
--			DebugPrint("A resource was consumed a species cares about!\n")
--			--("I FOUND A RESOURCE A SPECIES CARES ABOUT!")
--			Aggression_up(v_table['nest'])
--			if AsyncRand(100) > DivRound(chance,1000) then
--				DebugPrint("And it was noticed\n")
--				-- If recipe uses 40 units of the resource, 40% chance to be detected
--				Aggression_up(v_table['nest'])
--			else
--				DebugPrint("But it went unnoticed\n")
--			end
--		end
--	end
--end
--[[
function Aggression_up(species)
	DebugPrint("Aggression up called\n")
	-- 1 Find our how many nests of the type on map
	-- 2 Find out % of said nests are not asleep
	--- 2a If 0 nests on map, need (difficulty offset - 8) 
	-- 3 If % < 600%, wake up 1 nest
	-- 4 If % > 60%, spawn new nest
	species = species or Get_nest_by_region()
	--(species)
	if not Aggression_log_faction(species) then return end
	local count_total = MapCount("map",species)
	local count_awake = MapCount("map",species,function(this_nest)
		if this_nest.state == 'sleepy' then
			return true
		end
	end)
	--("There are "..count_total.." nests of "..species.." type, of which "..count_awake.." are awake already.")
	if count_total == 0 or DivRound(count_awake*100,count_total) > 60 then
		--("Need to create a new nest")
		ForceActivateStoryBit(species_to_new_storybit_table[species])
	else
		--("I need to wake a nest up instead!")
		local rand_nest = MapGetFirst("map",species,function(this_nest)
			if this_nest.state == 'asleep' then
				return true
			end
		end)
		if rand_nest then
			--("We found one and we are waking it up!")
			rand_nest:SwitchState('sleepy')
		end
	end
end


function Aggression_down(species)
	DebugPrint("Aggression down called\n")
	-- Will deactivate a nest if possible, eventually will lower attack chance/faction
	species = species or Get_nest_by_region()
	local nest
	nest = MapGetFirst("map",species,function(this_nest)
        	if this_nest.state == 'sleepy' then
            	return true
        	end
		end)
	if nest then
		nest:SwitchState("asleep")
	end
end

--]]


--[[ NESTSS


local disaster_sb = {}
disaster_sb['ShriekerNest'] = "begin_nest_disaster_shrieker"
disaster_sb['ScissorhandsNest'] = "begin_nest_disaster_scissor"
disaster_sb['ConsortiumNest'] = "begin_nest_disaster_robot"

function Add_to_disaster_sb(nest,sb)
	disaster_sb[nest]=sb
end

function All_skills_up(colonist)
	colonist = colonist or GetValidSurvivorsOnMap()[1]
	--("Colonist: ",colonist.id)
	local do_not_up = {}
	for id in pairs(Skills) do
		--('1: ',id)
		--("Looing at skill: ",id)
		--('inclination: ',colonist:GetSkillInclination(id).id)
		--('skill level: ',colonist:GetSkillLevel(id))
		if colonist:GetSkillInclination(id).id ~= 'indifferent' and colonist:GetSkillLevel(id) < 10 then
			--("Colonist is not indifferent and below level 10")
			colonist:SetSkillLevel(id,colonist:GetSkillLevel(id)+1,'silent')
		end
	end
end

------------------------------ DISASTER ---------------------------------
function End_Disaster(nest_id, force_sleep)
	DebugPrint("Ending the Nest Disaster\n")
    -- To enable me to place multiple types of nests in a single map
    nest_id = nest_id or Get_nest_by_region()
	local end_state
	force_sleep = force_sleep or false
	if force_sleep or Get_difficulty_offset <= 4 then
		end_state = 'asleep'
	else
		end_state = 'sleepy'
	end
	MapForEach(true,nest_id,function(nest,state)
		special_nest:SwitchState(state)
	end,end_state)
end

function Start_Nest_Disaster()
	DebugPrint("Starting Nest disaster\n")
    if MapVarValues['nest_disaster'] then return end
    MapVar('nest_disaster',GameTime()+hours_per_day)
	local nest_class = MapVarValues['nest_disaster_species'] or MapVar(nest_disaster_species,Get_nest_by_region())
	DebugPrint("The species is:\n")
	DebugPrint(nest_class)
	DebugPrint("\n")
	local story_bit = disaster_sb[nest_class]
	if story_bit then
		ForceActivateStoryBit(story_bit)
	else
		return
	end
	local nest_storybit_spawner = species_to_new_storybit_table[nest_class]
	CreateGameTimeThread(function(nest,story_create)
		local old_nest = 0
		local nests = 0
		local spawned = 0
		local failed_to_spawn = false

        --Only spawn up to 10 nests, break if we failed to spawn more, if 15+ nests on map stop spawning
		while spawned <= 10 and nests < 15 and not failed_to_spawn do
			DebugPrint("Spawning a nest disaster phase 1\n")
			Sleep(hours_per_day) -- pause for 24 hours
			ForceActivateStoryBit(story_create)
			Sleep(hour_duration) -- pause for an hour to see if a new nest has indeed spawned
			nests = MapCount(true,nest)
			if nests == old_nest then
				failed_to_spawn = true
			else
				spawned = spawned + 1
			end
			old_nest = nests -- Make sure we have our new number remembered
        end
        if GameTime() < MapVarValues['nest_disaster'] then
            -- Forced disaster to wait at least a day before second phase begins
            sleep(MapVarValues['nest_disaster'] - GameTime())
        end

        local diff = GetGameDifficulty()
		local denom = 2
		if diff <= 3 then
			denom = 4
		end
		DebugPrint("Triggering second phase!\n")
		MapVar("nests_needed",MulDiv(nests,denom))
        ForceActivateStoryBit("nest_disaster_phase_2")
	end,nest_class,nest_storybit_spawner)
end



--]]


--[[ CONSORTIUM

DefineClass.ConsortiumNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "PXPowerFacility",
	editor_text_color = RGB(255,128,128),
	NestClass = "ConsortiumNest",
	--editor_color = RGB(255,0,0),
}

DefineClass.ConsortiumSporeDeposit = {
	__parents = { "MineableRock" },
	
	MineResource = "ScrapMetal",
	MineAmount = 300 * const.ResourceScale,
	
	display_name = T(874568713, "Consortium Droid Support"),
	description = T(86745321245, "A standard building included in all Consortium Resource-Extraction-Prefab-Operation bundles."),
	description_unknown = T(257771208911, "<em>Unknown Consortium building. Requires up close studying to determine what this structure does.</em>"),
	
	TimeToMine = 4 * const.HourDuration,
	FieldResearchTech = "FieldConsortiumSpore",
}

DefineClass.ConsortiumNest = {
	__parents = { "TerritorialNest" },
	
	entity = "PXPowerFacility",
	
	daily_plant_damage = const.Shriekers.NestDailyPlantDamage,
	guard_range = const.Shriekers.NestGuardRange,
	guardians_count = const.Scissorhands.NestGuardiansCount,
	adults_max_count = const.Shriekers.NestMaxAdultsPerNest,
	hatchlings_max_count = const.Shriekers.NestMaxHatchlingsPerNest,
	elders_max_count = const.Scissorhands.NestMaxEldersPerNest,
	min_spawn_interval = const.Shriekers.NestMinSpawnInterval,
	max_spawn_interval = const.Shriekers.NestMaxSpawnInterval,
	initial_range = const.Shriekers.NestInitialTerritorialRange,
	terrain_range_border = const.Shriekers.NestTerrainRangeAddition,
	grow_interval = const.Shriekers.NestGrowInterval,
	range_increase = const.Shriekers.NestRangeIncrease,
	max_range = const.Shriekers.NestMaxTerritorialRange,
	min_attacks_count = const.Shriekers.NestMinMembersForAttack,
	engagement_time = const.Shriekers.NestEngagementTime,
	
	adult_class = "HeavyHostileRobot_LVL1" ,
	hatchling_class = "LightHostileRobot_LVL1",
	elder_class = "Crawl_APC_LVL1",
	CombatGroup = "Robots",
	
	terrain_change = true,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Automaton Base"),
	Description = T(904421747272, "An automated control center, managing a group of harvest droids and it's defenders."),
}
-- Overriding to preserve the base class of the robots in adult/elder class
-- We do not stutterstep down, instead the assaults and crawlers will just get stronger
function ConsortiumNest:change_nest_herd(force_evo)
	DebugPrint("Special Consortium Nest herd change function\n")
	-- Consortium nests will always have the same farmhand robot to simulate them consuming nearby resources
    local elder, adult, hatch = self.elder_class, self.adult_class, self.hatchling_class
	local new_elder = get_next(elder)
	local new_adult = get_next(adult)
	local new_hatch = get_next(hatch)
	local upgraded_flag = false
	local _
	local __
	if not force_evo then
		new_elder, _, __ = check_count_and_upgrade(elder,{},100)
		if new_elder ~= elder then 
			self.elder_class = new_elder
			upgraded_flag = true
		end
		new_adult, _, __ = check_count_and_upgrade(adult,{},100)
		if new_adult ~= adult then
			self.adult_class = new_adult
			upgraded_flag = true
		end
		new_hatch, _, __ = check_count_and_upgrade(hatch,{},100)
		if new_hatch ~= hatch then
			self.hatchling_class = new_hatch
			upgraded_flag = true
		end
	end
	if not MapVarValues.nest_upgraded and (force_evo or upgraded_flag) then --first time is essentially a flag
		ForceActivateStoryBit("Nests_evolving")
		MapVar("nest_upgraded",true)
	end
	-- remove any newly-invalid creatures from nest_creatures
	local removed = false
	for _, unit in ipairs(self.nest_members) do
		local class = unit.class
		if not class == self.elder_class and not class == self.adult_class and not class == self.hatchling_class then
			self:RemoveNestMember(unit)
			-- This will force spawn a new set of higher tier nests. 
			-- If Nests are left unnattended they can get quite large groups defending it
		end
	end
	if removed then
		self:UpdateNextSpawnTime()
	end
    if force_evo then
        self.attacks_done = 0
        self.attacks_to_evo = self.attacks_to_evo + 1
    end
end


--]]