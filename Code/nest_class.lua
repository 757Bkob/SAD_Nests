local hour_duration = const.HourDuration
local day_duration = const.DayDuration
local hours_per_day = day_duration / hour_duration

RecursiveCallMethods.UpdateNextSpawnTime = "call"
RecursiveCallMethods.RegisterTarget = "call"



function nest_map_upsert(var,val)
	if MapVarValues[var]==nil then
		MapVar(var,val)
	else
		MapVarValues[var]=val
	end
end

function get_difficulty_offset()
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


DefineClass.EnhancedTerritorialNest = {

    properties = {
        { category = "Nest", id = "state",                name = "State of nest", editor = "choice", template = true, items = { "inactive", "sleepy", "awake" }, default = 'inactive', modifiable = true, help = "state of the nest"},
        { category = "Nest", id = "attack_time",          name = "Nest Attack Time", editor = "int", default = 0, modifiable = true, help = "When a nest will attack next if not inactive."},
    },

    state = 'inactive',
}

function EnhancedTerritorialNest:GetStoryBitPopupImage()
    ModLog(true,"Getting the storybit popup image for a nest")
    if self.class == 'ShriekerNest' then
        return 'Mod/TGkJ3Tu/Shrieker_Nest.PNG'
    elseif self.class == 'ScissorhandsNest' then
        return 'Mod/TGkJ3Tu/Shrieker_Nest.PNG'
    end
end

function EnhancedTerritorialNest:change_nest_herd(force_evo)
    local elder, adult, baby = self.elder_class, self.adult_class, self.hatchling_class
    local evo, _, _ = check_count_and_upgrade(baby,{},100)
    ModLog(true,T{567345237,"change_nest_herd called"})
    if evo == baby and not force_evo then return
    else
        ModLog(true,T{567345238,"The player has enough EP (Or this nest was forced evolved), proceeding with evolution!"})
        baby = adult
        adult = evo
        -- lookup_table is in the ILU prereq mod
        local next = get_next(baby)--getNext(baby,baby) or nil
        if next then -- babies 1st evo
            ModLog(true,T{567345239,"Evolving the hatchling from this class <A> to <B>",A=self.hatchling_class, B = next})
            self.hatchling_class = next
            next = get_next(next)--getNext(next,next) or nil-- babies second evo or no change
            if next then
                ModLog(true,T{567345240,"Evolving the adult from this class <A> to <B>",A=self.adult_class, B = next})
                self.adult_class = next
                next = get_next(next) --getNext(next,next) or nil -- babies third evo or no change
                if next then
                    ModLog(true,T{567345241,"Evolving the adult from this class <A> to <B>",A=self.elder_class, B = next})
                    self.elder_class = next
                end
            end
        end
        if self.adult_class ~= adult then
            next = getNext(elder,elder)
        end
        -- remove any newly-invalid creatures from nest_creatures
        local removed = false
        for _, unit in ipairs(self.nest_members) do
		    local class = unit.class
		    if not class == self.elder_class and not class == self.adult_class and not class == self.hatchling_class then
                ModLog(true,T{567345242,"Removing a <A> from a nesting group because it's not a valid nesting class anymore",A=class})
			    self:RemoveNestMember(unit)
                removed = true
                -- This will force spawn a new set of higher tier nests. 
                -- If Nests are left unnattended they can get quite large groups defending it
		    end
        end
	end
    return elder, adult, baby
end

function start_nest_disaster()
    if MapVarValues['nest_disaster'] == 'started' then return end
    px_map_upsert('nest_disaster','started')

    if Region.id == 'Saltu' then
        ForceActivateStoryBit("not_supported_map")
        return
    end
    -- Daily spawn of a nest, until we fail to spawn one, we spawn over 10 of them, or we are at capped nests
	CreateGameTimeThread(function()
		local nests = MapCount(true,"TerritorialNest")
        local max_nests = MapCount(true,'TerritorialNestMarker')
		local old_nest = nests
		local spawned = 0
		local failed_to_spawn = false
        ModLog(true,T{567345243,'Will I even trigger the while loop?'})
        ModLog(true,nests < max_nests and spawned <= 10 and not failed_to_spawn)
		--Only run during disaster, and only spawn up to 10 nests, and break if we cannot spawn more
		while nests < max_nests and spawned <= 10 and not failed_to_spawn do
			Sleep(hours_per_day) -- pause for 24 hours
            if Region.id == 'Sobrius' then
    			ForceActivateStoryBit("new_nest_shrieker")
            end
			Sleep(hour_duration) -- pause for an hour to see if a new nest has indeed spawned
			nests = MapCount(true,"TerritorialNest")
			if nests == old_nest then
				failed_to_spawn = true
			else
				spawned = spawned + 1
			end
            ModLog(true,T{567345244,"I have spawned <no> nests so far",no = spawned})
		end
        local diff = GetGameDifficulty()
        if diff == 'Easy' or diff == 'Medium' or diff == 'Hard' or diff == 'Very Hard' then
            ModLog(true,T{567345245,"Activating next phase!"})
            ForceActivateStoryBit("nest_coordination")
        else
            ModLog(true,T{567345246,"Activating the harder version of the next phase!"})
            ForceActivateStoryBit("nest_coordination_insane")
        end
	end)
end

function EnhancedTerritorialNest:RegisterTarget(unit, time)
    if self.state == 'inactive' and unit['UnitTags']['Human'] then
        ModLog(true,T{567345247,"Nest registered an attacker that was human!"})
        self:SwitchState('sleepy')
        ForceActivateStoryBit('inactive_too_sleepy',self,true)
    end
end

function EnhancedTerritorialNest:set_new_max_hp()
    local base_hp = 100000
    local diff = get_difficulty_offset()
    local max_possible_hp = base_hp * 100 * diff
    if self.state == 'awake' then
        self.MaxHealth = max_possible_hp
        self.health_regen = 5
    elseif self.state == 'sleepy' then
        self.MaxHealth = MulDiv(max_possible_hp,2)
        self.health_regen = 1
    elseif self.state == 'inactive' then
        self.health_regen = 0
        self.MaxHealth = base_hp
    end
end

function EnhancedTerritorialNest:SwitchState(new_state)
    ModLog(true,T{567345254,"Switch nest state function"})
    new_state = new_state or nil
    if not new_state then
        return nil
    elseif self.state == 'inactive' and new_state == 'sleepy' then
        ForceActivateStoryBit('inactive_too_sleepy')
    end
    ModLog(true,T{567345255,"Actually switching nest state!"})
    self.state = new_state
    self:change_nest_herd()
    self:set_new_max_hp()
    return true
end

function EnhancedTerritorialNest:calculate_attack_strength()
    local nests = MapCount(true,"TerritorialNest")
    local diff_add = get_difficulty_offset() * 5
    local strength = DivRound(100,nests) + diff_add
    -- 1 nest left on hard difficulty == 130% strength attack
    -- 2 nests left on hard difficulty == 80% strength attack
    return strength
end

function EnhancedTerritorialNest:attack()
    self:UpdateNextSpawnTime()
    ModLog(true,T{567345256,"A nest is attacking!"})
    local spawn_def = SpawnDefs['nest_attack']
    ModLog(true,T{567345261,"Created the sapwndef"})
    local instance = {}
    -- Not calling fill instance, because we are already in hard-code territory
    -- Consider the below the fill instance
    instance.nest = self
    instance.FindSpawnLoc = function(self, spawn_class, target)
        ModLog(true,T{567345257,"Trying to find a nest to enemy path beside this nest:"})--,nest = self.nest.class})
        local def = spawn_class and g_Classes[self.nest.hatchling_class]
        local pfclass = def.pfclass
        local radius = self.nest.territorial_range
        local target_retry = 5
        local rand = InteractionRandCreate("SpawnFindTarget")
        for i=1,target_retry do
            local r = rand()
            local rand_retries = 4096
            local pos_of_nest = terrain.FindPassable(self.nest, pfclass, radius)
            local pos_nearish_nest = ConnectivityRandomTile(r, pos_of_nest, pos_of_nest, radius, 3*guim, pfclass, rand_retries)
            local targets_point = self:ResolveTarget() --rerolling target in case nest cannot reach this person
            local closests_passable_point_near_target = terrain.FindPassable(targets_point, pfclass, max_int)
            if ConnectivityCheck(pos_nearish_nest,closests_passable_point_near_target,pfclass) then
                return pos_nearish_nest
            end
        end
		::continue::
        dbg(self:DbgMarkFailedSpawn(pos_nearish_nest, i))
    end
    instance.SpawnClass = self.hatchling_class
    ModLog(true,T{567345258,"Instance created and ready"})
    spawn_def = spawn_def:CreateInstance(instance)
    ModLog(true,T{567345259,'Activating SpawnDef instance!'})
    spawn_def:ActivateSpawn(false,{},self:calculate_attack_strength())
end


function EnhancedTerritorialNest:UpdateNextAttackTime()
    local diff = get_difficulty_offset() - 3
    -- randomness in attacks
    local attack_cd = Game:GetCooldowns()['Attack']
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
    return AsyncRand(slowest_attack_allowed,fastest_attack_allowed)
end

function EnhancedTerritorialNest:UpdateNextSpawnTime()
	-- Done already by child function calls 
    -- self.next_spawn_time = GameTime() + self:RandRange(self.min_spawn_interval, self.max_spawn_interval, "ShriekerSpawnTime")
    if self.state ~= 'inactive' then
        ModLog(true,"Nest is not asleep, updating when it will attack")
        self:change_nest_herd()
        self:UpdateNextAttackTime()
    end
end

function EnhancedTerritorialNest:OnObjUpdate(time, update_interval)
	local health = self.Health
    -- no growing EP if dead or inactive
	if health <= 0 or self.state == 'inactive' then return end
    if self.state ~= 'inactive' then
        if self.attack_time < GameTime() then
            if self.state == 'awake' then -- trigger all the same nests to attack
                MapForEach(true,'TerritorialNest',function(special_nest,this_nest)
                    if this_nest.class == special_nest.class and special_nest ~= this_nest then
                        special_nest:attack()
                    end
                end,self)
                ForceActivateStoryBit('mass_nest_attack',self,true)
            else
                self:attack()
                ForceActivateStoryBit('single_nest_attack',self,true)
            end
        end
    end
end

AppendClass.TerritorialNest = {
    __parents = { "EnhancedTerritorialNest" },
}

function TFormat.nests_needed(context_obj)
	local nests = MapCount(true,"TerritorialNest")
	local denom = 2
	if GetGameDifficulty() == 'Easy' or GetGameDifficulty() == 'Medium' or GetGameDifficulty() == 'Hard' then
		denom = 4
	else
		denom = 2
	end
	return T{121110100812,"<no>",no=nests/denom}
end

local function nest_full()
    local nests_possible = MapCount(true,"TerritorialNest")
	local denom = 2
	if GetGameDifficulty() == 'Easy' or GetGameDifficulty() == 'Medium' or GetGameDifficulty() == 'Hard' then
		denom = 4
	else
		denom = 2
	end
    nest_map_upsert('nests_needed',DivRound(nests_possible,denom))
    nest_map_upsert('nests_killed',0)
end

function TFormat.nests_left(context_obj)
	local nests_killed = MapVarValues['nests_killed'] or 0
    local nests_needed = MapVarValues['nests_needed'] or nil
    if not nests_needed then
        nest_full()
        nests_needed = MapVarValues['nests_needed']
    end
	return T{121110100822,"<no>",no= nests_needed-nests_killed}
end



OnMsg.LoadGame = nest_full
OnMsg.GameStarted = nest_full