local hour_duration = const.HourDuration
local day_duration = const.DayDuration
local hours_per_day = day_duration / hour_duration

RecursiveCallMethods.RegisterTarget = "call"



DefineClass.EnhancedTerritorialNest = {

    properties = {
        { category = "Nest", id = "state",                name = "State of nest", editor = "choice", template = true, items = { "asleep", "sleepy", "awake" }, default = 'asleep', modifiable = true, help = "state of the nest"},
        { category = "Nest", id = "attack_time",          name = "Nest Attack Time", editor = "number", default = 0, modifiable = true, help = "When a nest will attack next if not asleep."},
        { category = "Nest", id = "attacks_done",         name = "Nest Attack Count", editor = "number", default = 0, modifiable = true, help = "Number of attacks this nest has sent total"},
        { category = "Nest", id = "attacks_to_evo",       name = "attacks needed to force evolution", editor = "number", default = 4, modifiable = true, help = "How much EP is needed to evolve the nest denizens"},
        { category = "Nest", id = "proximity",            name = "Nests proximity to players stuff", editor = "number", default = 1, modifiable = true, help = "Higher numbers indicate close distance to the players presence, and effects attack/evo/consumption rates"},
        { category = "Nest", id = "last_attack",          name = "last attack time", editor = "number", default = 0, modifiable = true, help = ""},
        { category = "Nest", id = "ui_attack_percent",    name = "How close the attack time is to occuring", editor = "number", scale = "%", default = 0, modifiable = true, help = ""},
        { category = "Nest", id = "ui_evo",               name = "How close this nest is too evolving it's herd", editor = "number", scale = "%", default = 0, modifiable = true, help = ""},
    },
    state = 'asleep',
	gas = 0,
    attack_time = max_int,
    attacks_done = 0,
    attacks_to_evo = 4,
    proximity = 1,
    last_attack = 0,
    ui_attack_percent = 0,
    ui_evo = 0,
}

function EnhancedTerritorialNest:Init()
    CreateGameTimeThread(function(this_nest)
        Sleep(day_duration)
        self:UpdateNextAttackTime()
    end,self)
    -- Create a thread that will have this nest consume or grow approx twice a day
    CreateGameTimeThread(function(this_nest)
        local prox_triggers = this_nest.proximity
        if this_nest:IsAsleep() then
            prox_triggers = 1
        end
        while this_nest.Health > 0 do
            Sleep(AsyncRand(hour_duration * 9,hour_duration * 14))
            for i=1,prox_triggers do
                this_nest:consume_closest_node()
            end
        end
	end,self)
end

--This technically just increases the nest members, because the base game uses the nests herd to set the controlled territory
function EnhancedTerritorialNest:expand()
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
	if EP_to_give > 10 then
		local percent_reduced = DivRound(EP_to_give,10)
		self.attack_time = self.attack_time - DivRound(attack_cd*percent_reduced,100)
		-- This makes the attacks "happen" faster
	end
	--[[
    local diff_impact = DivRound(3*Get_difficulty_offset(),2) -- diff influence is 2x to 11x reduction
	--(self.attack_time)
	--(5000 * progress * diff_impact)
	self.last_attack = self.last_attack - (5000 * progress * diff_impact)
    self.attack_time = self.attack_time - (5000 * progress * diff_impact) -- simulates how an attack will occur sooner because some resources where consumed
	--(self.attack_time)
	]]--
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
    local center = get_center_of_survivors()
    local distance = self:Dist(center)
	--(distance)
    local found = false
    local min = 300
    local prox = 4 
    while not found and proximity ~= 1 do
        if distance < min then
            self.proximity = prox
            found = true
        else
            prox  = prox + 1
            min = min + 300
        end
    end
    if prox == 1 then
        self.proximity = 1
    end
end

function EnhancedTerritorialNest:Getui_evo()
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
    -- gametime is 5
    -- attack cd is 4
    -- last attacked at 3
    -- extrapolate: will attack at 7 (Because 3 + cd )
    -- denom will be 4 units (attack cd)
    -- Numerator will be 2 (game time of 5 - last attack of 3)
    local time_since_last_atk = GameTime() - self.last_attack
    local percent = DivRound(time_since_last_atk*100,Game:GetCooldowns()['Attack'])
    return Max(1,percent)
end

function EnhancedTerritorialNest:change_nest_herd(force_evo)
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
        self:SwitchState('sleepy')
        --ForceActivateStoryBit('asleep_too_sleepy'
    end
end

function EnhancedTerritorialNest:set_new_max_hp()
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
    local nests = MapCount(true,"TerritorialNest")
    local diff_add = Get_difficulty_offset() * 5
    local subsequent_atk = self.attacks_done * 10 -- 10% increase per prior attack
    local prox_add = self.proximity * 10 -- closest nests will increase attack strength by 40%
    local strength = DivRound(100,nests) + diff_add + subsequent_atk
    -- 1 nest left on hard difficulty == 130% strength attack
    -- 2 nests left on hard difficulty == 80% strength attack
    return strength
end

function EnhancedTerritorialNest:attack(fake_flag)
    self:UpdateNextAttackTime()
    self:change_nest_herd() -- In case player has enough EP
    local spawn_def = SpawnDefs['nest_attack']
    if fake_flag then
        spawn_def = SpawnDefs['nest_overflow']
    end
    local instance = {}
    -- Not calling fill instance, because we are already in hard-code territory
    -- Consider the below the fill instance
    instance.nest = self
    instance.FindSpawnLoc = function(self, spawn_class, target)
        local def = spawn_class and g_Classes[self.nest.hatchling_class]
        local pfclass = def.pfclass
        local radius = self.nest.territorial_range
        local target_retry = 7
        local rand = InteractionRandCreate("SpawnFindTarget")
        for i=1,target_retry do
			--("Retry attempt: "..i)
            local r = rand()
            local rand_retries = 4096
            local pos_of_nest = terrain.FindPassable(self.nest, pfclass, radius)
            local pos_nearish_nest = ConnectivityRandomTile(r, pos_of_nest, pos_of_nest, radius, 3*guim, pfclass, rand_retries)
            local targets_point = self:ResolveTarget() --rerolling target in case nest cannot reach this person
            local closests_passable_point_near_target = terrain.FindPassable(targets_point, pfclass, max_int)
            if ConnectivityCheck(pos_nearish_nest,closests_passable_point_near_target,pfclass) then
                return pos_nearish_nest
            end
			radius = DivRound(radius * 2)
        end
		::continue::
        dbg(self:DbgMarkFailedSpawn(pos_nearish_nest))
    end
    instance.SpawnClass = self.elder_class
    spawn_def = spawn_def:CreateInstance(instance)
    spawn_def:ActivateSpawn(false,{},self:calculate_attack_strength())
    if self.attacks_done ~= -1 then
        self.attacks_done = self.attacks_done-1
        if self.attacks_done == 0 then
            self:SwitchState('asleep') -- It's tired now
        end
    end
    self.attacks_done = self.attacks_done + 1
    if self.attacks_to_evo == self.attacks_done then
        self:change_nest_herd(true)
    end
end


function EnhancedTerritorialNest:UpdateNextAttackTime()
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
    self.attack_time =  AsyncRand(fastest_attack_allowed,slowest_attack_allowed)
    self.last_attack = GameTime()
end


function EnhancedTerritorialNest:OnObjUpdate(time, update_interval)
	local health = self.Health
	if health <= 0 then return end
    if self.attack_time < GameTime() then
        if self.state == 'awake' then -- trigger all the same nests to attack
            MapForEach(true,'TerritorialNest',function(special_nest,this_nest)
                -- This will include itself
                if this_nest.class == special_nest.class then
                    special_nest:UpdateNextAttackTime()
                    special_nest:attack()
                end
            end,self)
            ForceActivateStoryBit('mass_nest_attack',self,true)
        elseif self.state == 'sleepy' then
            self:attack()
            ForceActivateStoryBit('single_nest_attack',self,true)
            self:UpdateNextAttackTime()
        elseif self.state == 'asleep' then
            self:attack(true) -- true means to use the nest_overflow spawndef
            self:UpdateNextAttackTime()
        end
    end
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