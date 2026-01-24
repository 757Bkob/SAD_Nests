local hour_duration = const.HourDuration
local day_duration = const.DayDuration
local hours_per_day = day_duration / hour_duration

--MapVar('Nest_Notifications', 1)

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
        { category = "Nest", id = "attack_delay",          name = "Nest Attack Delay", editor = "number", default = max_int, modifiable = true, help = "Exact time a nest picks to attack after it's last attack (Used in some internal calcualtions/UI percentage bars)"},
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
	attack_delay = max_int,
	attacks_done = 0,
	attacks_to_evo = 4,
	base_strength = 20,
	consume_time = max_int,
    proximity = 1,
    ui_attack_percent = 0,
    ui_evo = 0,
}

function EnhancedTerritorialNest:Init()
	self.attack_time = max_int
	self.consume_time = max_int
	-- wait a day then reset the above
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
--#
function EnhancedTerritorialNest:give_ep_to_struct(ep)
    if not ep then return end
	local my_species = find_nest_species(self.class)
	if not my_species then return end
	DebugPrint("Nest storing EP in support structures\n")
	local spores_near = MapGet(self,self.max_range,my_species.spore_buildings)
    local progress_each = DivRound(ep,#spores_near)

    local spore_res = Resources[spores_near[1]]
    local spore_res_prog = spore_res.progress
    local units_to_give = Max(1,DivRound(progress_each,spore_res_prog))
    Bkob_Log("Nest giving each nearby spore building this much resource units: ",units_to_give)
    for _,spore in ipairs(spores_near) do
            spore.MineAmount = spore.MineAmount + (units_to_give * const.ResourceScale)
    end
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
	local attack_cd = self.attack_delay
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
	local center = AveragePoint2D(GetValidSurvivorsOnMap())
	local dist_to_center = center:Dist2D(self)
    local rate = 150 * guim --300 meters per threshold
    local prox = DivRound(dist_to_center,rate)
	prox = Max(1,Min(5,prox)) -- closest nests have a prox of 1
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

function EnhancedTerritorialNest:Getui_attack_strength()
	--local max_possible = per_species_nest_max*10
	if self.state == 'asleep' then
		return 10
	else
		return self:calculate_attack_strength()
	end
end

function EnhancedTerritorialNest:Getui_attack_cap()
	local max_possible = per_species_nest_max*10
	local cap = self:get_attack_cap()
	return DivRound(cap*100,max_possible)
end

function EnhancedTerritorialNest:Getui_attack_percent()
	DebugPrint("Getting the UI % of how close an attack from the nest is\n")
	local time_till_attack = self.attack_time - GameTime()
	local num = self.attack_delay-time_till_attack
	local percent=DivRound(num*100,self.attack_delay)
	return Max(1,percent)
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

function EnhancedTerritorialNest:change_nest_herd(force_evo)
	Bkob_Log("Nest calculating if it needs to upgrade\n")
	Bkob_Log("Forced Evo: ",force_evo)
    local elder = self.elder_class
	local upgraded_flag = false
	local evo,_,__
	if force_evo then
		evo = Find_evolution(g_Classes[elder])
	else
		local AdditionalClassList = {}
		AdditionalClassList[#AdditionalClassList+1] = {self.adult_class,150}
		AdditionalClassList[#AdditionalClassList+1] = {self.hatchling_class,50}
	    evo, _, __ = check_count_and_upgrade(elder,AdditionalClassList,100)
	end
    if evo == elder then return upgraded_flag end
	-- base nests will just chain their units down
	upgraded_flag = true
	self.hatchling_class = self.adult_class
	self.adult_class = self.elder_class
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
    if upgraded_flag then
		-- just to make sure we know how close the player is now that they have more stuff
		self:get_proximity()
		NA_log_nest_evolved(self)
        self.attacks_done = 0
        self.attacks_to_evo = self.attacks_to_evo + 1
    end
	return upgraded_flag
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
	local notif_level = Nest_Notifications
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

function EnhancedTerritorialNest:get_attack_cap()
	local base = 50
    local awake_same_nests = MapCount(true,"TerritorialNest",function(other_nest,this_nest)
		if IsKindOf(other_nest,this_nest) and not (other_nest.state == 'asleep') and other_nest ~= this_nest then
			return true
		end
	end,self)
	local nest_based_cap = awake_same_nests * 10
	local year = const.Scale.years
	local time_based_cap = MulDivTrunc(1,GameTime(),year)*50+50
	if base > time_based_cap and base > nest_based_cap then
		return base
	elseif time_based_cap > nest_based_cap then
		return time_based_cap
	else
		return nest_based_cap
	end
	return
end

function EnhancedTerritorialNest:calculate_attack_strength(fake_flag)
	DebugPrint("Nest calculating it's attack score\n")
	if fake_flag then
		return 10
	end
	local max_attack_strength_allowed = self:get_attack_cap()
	local base_strength = self.base_strength or 20
	local diff_increase
	if Get_difficulty_offset() > 5 then
		diff_increase = 10
	else
		diff_increase = 0
	end
	local species_banked_aggr = self.class..'_banked_aggr'
	local banked = MapVarValues[species_banked_aggr] or 1
	if MapVarValues[species_banked_aggr] then
		MapVarValues[species_banked_aggr] = 1
	else
		MapVar(species_banked_aggr,1)
	end
    local subsequent_attacks = self.attacks_done * 10
	local prox_loss = self.proximity * 10
	local unfiltered_strength = base_strength + banked + subsequent_attacks + diff_increase - prox_loss
	-- Make sure we don't go below base or above cap
	local filtered_strength = Max(base_strength,Min(max_attack_strength_allowed,unfiltered_strength))
	DebugPrint("Desired attack strength: ")
	DebugPrint(unfiltered_strength)
	DebugPrint("\nActual attack strength:")
	DebugPrint(filtered_strength)
	DebugPrint("\n")
    return filtered_strength
end

function nest_find_spawn_fake(spawndef_instance, spawn_class, target)
	local def = spawn_class and g_Classes[spawn_class]
	local pfclass = def.pfclass
	local range = spawndef_instance.nest.max_range
	local target_retry = 7
	local x,y
	local pos = terrain.FindPassableTile(spawndef_instance.nest, const.tfpPassClass, pfclass)
	local playbox = GetPlayBox()
	local nest_entity_radius = spawndef_instance.nest:GetRadius()
	for i=1,target_retry do
		x, y = GetRandomPlayablePos(spawndef_instance.nest, range, guim, AsyncRand(), pfclass, def.radius)
		local temp_pos = point(x,y)
		local playbox_check = playbox:Dist2(temp_pos) > 1
		local under_nest = IsCloser2D(pos, temp_pos, nest_entity_radius)
		if playbox_check or under_nest then
			x = nil
			target_retry = target_retry - 1
			range = range * 2
		else
			local possible_pos = point(x,y)
			return possible_pos
		end
	end
	::continue::
	dbg(spawndef_instance:DbgMarkFailedSpawn(spawndef_instance.nest,7))
end

function nest_find_attack_spawn(spawndef_instance, spawn_class, target)
	local playbox = GetPlayBox()
	if not target then
		target = spawndef_instance:ResolveTarget()
	end
	local def = spawn_class and g_Classes[spawn_class]
	local pfclass = def.pfclass
	local pos = terrain.FindPassableTile(spawndef_instance.nest, const.tfpPassClass, pfclass)
	if not pos then print("no pos found!") end
	local nest_entity_radius = spawndef_instance.nest:GetRadius()
	local x,y
	local retry = 10
	local range = spawndef_instance.nest.max_range
	local target_radius = 30*guim
	while not x and retry > 0 do
		local spot_closest_to_target =  terrain.FindPassable(target, pfclass, target_radius)
		if not spot_closest_to_target then
			target_radius = target_radius * 2
			
		else
			x, y = GetRandomPlayablePos(pos, range, guim, AsyncRand(), pfclass, def.radius)
			local temp_pos = point(x,y)
			local playbox_check = playbox:Dist2(temp_pos) > 1
			local under_nest = IsCloser2D(pos, temp_pos, nest_entity_radius)
			if playbox_check or under_nest then
				x = nil
				retry = retry - 1
				range = range * 2
			else
				local possible_pos = point(x,y)
				if ConnectivityCheck(possible_pos,spot_closest_to_target,pfclass) then
					return possible_pos
				else
					retry = retry - 1
					range = range * 2
				end
			end
		end
	return nil
	end
end

local post_spawn_animal = function(self,obj,target,context)
		obj.CombatHostile = true
		Msg("SpawnedAnimalThreat", obj)
		give_nest_speed_effect(obj,self.nest.proximity)
	end

local post_spawn_robot = function(self,obj,target,context)
		obj:SetInvader(true)
		Msg("SpawnedAnimalThreat", obj)
		give_nest_speed_effect(obj,self.nest.proximity)
	end

function give_nest_speed_effect(ob,prox)
	local robot_flag = false
	local times = prox or 1
	if IsKindOf(ob,'Robot') then
		robot_flag = true
	end
	while times > 0 do
		if robot_flag then
			ob:AddRobotCondition('nest_attack_speed_robot','mod')
		else
			ob:AddHealthCondition('nest_attack_speed','mod')
		end
		times = times - 1
	end
end

function EnhancedTerritorialNest:attack(fake_flag)
	DebugPrint("Nest is attacking!\n")
	if self.state == 'allied' then return end -- stub for me
    self:UpdateNextAttackTime()
    self:change_nest_herd() -- In case player has enough EP
    local spawn_def
	local atk_str = self:calculate_attack_strength(fake_flag)
	local def = self.elder_class and g_Classes[self.elder_class]
	if not def then return end
	-- determine what spawndef to use, and how we ware finding the spawn point
	if fake_flag then
        spawn_def = SpawnDefs['nest_overflow']
	else
		spawn_def = SpawnDefs['nest_attack']
	end
    local instance = {}
    instance.nest = self
    instance.SpawnClass = self.elder_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList+1] = {self.adult_class,150}
	instance.AdditionalClassList[#instance.AdditionalClassList+1] = {self.hatchling_class,50}
    --instance.FindSpawnLoc = find_spawn
	--instance.PostSpawn = post_spawn
	--instance.CountMod = nest_count
    spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
    spawn_def:ActivateSpawn(t,{},atk_str)
    if not fake_flag then self.attacks_done = self.attacks_done + 1 end
    if self.attacks_to_evo == self.attacks_done then
        self:change_nest_herd(true)
    end
end

function EnhancedTerritorialNest:UpdateNextAttackTime()
	DebugPrint("Nest updating when to attack next\n")
    local diff = Get_difficulty_offset() - 3
	self.attack_delay = MoonInstance.AttackCooldownMin + AsyncRand(MoonInstance.AttackCooldownMax - MoonInstance.AttackCooldownMin)
    if self.state == 'asleep' then self.attack_delay = self.attack_delay * 2 end
    --[[ Using the min/max moon already gives variability
	
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
	--]]
    self.attack_time =  GameTime() + self.attack_delay --AsyncRand(fastest_attack_allowed,slowest_attack_allowed)
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

function is_inside_of(box,pos)
	if box:Dist2(pos) == 0 then
		return true
	else
		return false
	end
end

function TerritorialNest:SpawnAround(class, range, instant, burrowed)
	local def = class and g_Classes[class]
	if not def then return end
	if burrowed and not def.CanBurrowInNest then return end
	local playbox = GetPlayBox()
	local pfclass = def.pfclass
	local pos = terrain.FindPassableTile(self, const.tfpPassClass, pfclass)
	local nest_entity_radius = self:GetRadius()
	local x,y
	local retry = 10
	-- overriding range given because that is usually just 10 meters...
	range = self.max_range
	while not x and retry > 0 do
		x, y = GetRandomPlayablePos(pos, range, guim, self:RandSeed("SpawnNestMember"), pfclass, def.radius)
		if x then
			local temp_pos = point(x,y)
			local playbox_check = playbox:Dist2(temp_pos) > 1
			local under_nest = IsCloser2D(pos, temp_pos, nest_entity_radius)
			if playbox_check or under_nest then
				x = nil
				retry = retry - 1
			else
				retry = -1
			end
		end
	end
	if not x then return end
	if IsKindOf(def,'Robot') then
        local spawn_def = SpawnDefs['single_spawn_around_loc']
		local instance = {}
		instance.location = self
		instance.radius = range
		instance.PostSpawn = function(self,obj,target,context)
			obj:SetNest(self.location)
			obj:SetInvader(true)
		end
		instance.FindSpawnLoc = function(self, spawn_class, target,context)
			return point(x,y)
		end
		instance.SpawnClass = class
		spawn_def = spawn_def:CreateInstance(instance)
		local t = spawn_def:ResolveTarget()
		spawn_def:ActivateSpawn(t,{},100)
		return true
	else
		local obj
		obj = def:new()
		obj:SetNest(self)
		obj:SetPosAngle(x, y, const.InvalidZ, self:GetAngle() + self:Random(360*60, "SpawnNestMember"))
		if not instant then
			obj.init_with_command = "CmdSpawn"
		end
		return obj
	end
	return false
end

function TerritorialNest:Spawn_robot_nestling(x,y,class)
	local spawn_def = SpawnDefs['Single_Robots']
	local instance = {}
	instance.nest = self
	instance.pos = point(x,y)
	instance.SpawnClass = class
	instance.FindSpawnLoc = function(self, spawn_class, target,context)
		return self.pos
	end
	--[[instance.PostSpawn = function(self,obj,target,context)
		obj:SetInvader(true)
		obj:SetNest(self.nest)
	end--]]
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
    spawn_def:ActivateSpawn(t,{},100)
end

AppendClass.TerritorialNest = {
    __parents = { "EnhancedTerritorialNest" },
}

-- meta class grouping all spore buildings for easier searching
-- We do not append ConsortiumSporeDeposit because we define it in the other file with this as a parent already
DefineClass.NestSpore = {
	properties = {}
}

AppendClass.ShriekerSporeDeposit = {
	__parents = { "NestSpore" }
}

AppendClass.ScissorhandSporeDeposit = {
	__parents = { "NestSpore" }
}

local function count_effects_by_id(target,effect_id)
	local count = 0
	for _, effect in ipairs(target.status_effects or empty_table) do
		if effect.id == effect_id then
			count = count +1
		end
	end
	return count
end

function decay_speed(target)
	local effect_id = 'nest_attack_speed'
	if IsKindOf(target,'Robot') then
		effect_id = 'nest_attack_speed_robot'
		target:RemoveRobotConditions(effect_id, "ReplaceOldest")
	end
	local prox = DivRound(AveragePoint2D(GetValidSurvivorsOnMap()):Dist2D(target),150*guim)
	local count = count_effects_by_id(target,effect_id)
	while count > prox do
		if IsKindOf(target,'Robot') then
			target:RemoveRobotConditions(effect_id, "ReplaceOldest")
			count = count_effects_by_id(target,effect_id)
		else
			target:RemoveHealthConditions(effect_id, "ReplaceOldest")
			count = count_effects_by_id(target,effect_id)
		end
	end
end

function add_delay_to_nests()
	MapForEach(true,"TerritorialNest", function(nest)
		if not nest.attack_delay or nest.attack_delay > MoonInstance.AttackCooldownMax then
			nest:UpdateNextAttackTime()
		end
	end)
end

function clean_up_robots()
	MapForEach(true,"Robot", function(robot)
		if not robot.Invader and not robot.command_center then
			DoneObject(robot)
		end
	end)
	MapForEach(true,"ConsortiumNest", function(nest)
		local count = nest.adults_max_count + nest.elders_max_count + nest.hatchlings_max_count
		nest:UpdateTerritoryTerrain(true, count)
		for i = 1, count do
			if not nest:SpawnNestMember(true) then
				break
			end
		end
	end)
end

function delete_robots()
	MapDelete("map", "HeavyHostileRobot_LVL1", function(robot,playbox)
		return is_inside_of(playbox,robot)
	end,GetPlayBox())
end

function SavegameFixups.EnhancedNestFixes()
	add_delay_to_nests()
	clean_up_robots()
	delete_robots()
end

function OnMsg.PostLoadGame()
	delete_robots()
end