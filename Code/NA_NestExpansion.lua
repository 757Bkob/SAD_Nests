local hour_duration = const.HourDuration
local day_duration = const.DayDuration
local hours_per_day = day_duration / hour_duration


function Juno_Cancer(force)
	local nests = {}
	if force then
		nests = MapGet(true, 'TerritorialNest', function(nest)
			if nest.class ~= 'JunoNest' then return true end
		end)
	else
		nests = MapGet(true, 'TerritorialNest', function(nest)
			if GameTime() - const.Scale.years > nest.spawned_on and nest.class ~= 'JunoNest' then
				return true
			end
		end)
	end
	if #nests > 0 then
		local roll = AsyncRand(#nests)
		local to_convert = nests[roll]
		return Convert_nest_into(to_convert, 'nesting_juno')
	end
end

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
			assert(false, "Prefab without a nest marker: " .. name)
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
					for i = 1, retries do
						local ra, rr
						ra, seed = BraidRandom(seed, 360 * 60)
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
		{ category = "Nest", id = "state",             name = "State of nest",                                 editor = "choice", template = true,   items = { "asleep", "sleepy", "awake", "allied" }, default = 'asleep',                                                                                                       modifiable = true, help = "state of the nest" },
		{ category = "Nest", id = "attack_time",       name = "Nest Attack Time",                              editor = "number", default = max_int, modifiable = true,                                 help = "When a nest will attack next if not asleep." },
		{ category = "Nest", id = "attack_delay",      name = "Nest Attack Delay",                             editor = "number", default = max_int, modifiable = true,                                 help = "Exact time a nest picks to attack after it's last attack (Used in some internal calcualtions/UI percentage bars)" },
		{ category = "Nest", id = "attacks_done",      name = "Nest Attack Count",                             editor = "number", default = 0,       modifiable = true,                                 help = "Number of attacks this nest has sent total" },
		{ category = "Nest", id = "attacks_to_evo",    name = "attacks needed to force evolution",             editor = "number", default = 4,       modifiable = true,                                 help = "How much EP is needed to evolve the nest denizens" },
		{ category = "Nest", id = "proximity",         name = "Nests proximity to players stuff",              editor = "number", default = 1,       modifiable = true,                                 help = "Higher numbers indicate close distance to the players presence, and effects attack/evo/consumption rates" },
		{ category = "Nest", id = "ui_attack_percent", name = "How close the attack time is to occuring",      editor = "number", scale = "%",       default = 0,                                       modifiable = true,                                                                                                        help = "" },
		{ category = "Nest", id = "ui_evo",            name = "How close this nest is too evolving it's herd", editor = "number", scale = "%",       default = 0,                                       modifiable = true,                                                                                                        help = "" },
		{ category = "Nest", id = "base_strength",     name = "Base % str of an attack this will send",        editor = "number", scale = "%",       default = 30,                                      modifiable = true,                                                                                                        help = "" },
		{ category = "Nest", id = "consume_time",      name = "When nest will eat the next node",              editor = "number", default = 0,       modifiable = true,                                 help = "This is routinely updated based on each individual nest" },
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
	sleep_check = 0,
	awoken_at = 0,
	attacked_by_player = false,
	other_species_attacks = {},
}

function EnhancedTerritorialNest:Align_cgroup_members()
	for _, v in ipairs(self.nest_members) do
		v.CombatGroup = self.CombatGroup
	end
end

function NestDelayedInit(nest)
	nest:UpdateNextAttackTime()
	nest:get_proximity()
	--nest:force_inert_if_capped()
	nest.quadrant = Get_quadrant_from_obj(nest, true)
	nest.spawned_on = GameTime()
end

--~Presets.UnitSpeciesGroup.Default[Presets.NestingSpeciesPreset.Default[get_species_from_nest(SelectedObj.class)].unit_species]
function EnhancedTerritorialNest:Init()
	self.attack_time = max_int
	self.consume_time = max_int
	self.nest_species = get_species_from_nest(self.class)
	local full_nest_details = Presets.NestingSpeciesPreset.Default[self.nest_species]
	local full_species_details = Presets.UnitSpeciesGroup.Default[full_nest_details.unit_species]
	local desired_cgroup = full_species_details.primary_combat_group
	if self.CombatGroup ~= desired_cgroup and not table.find(full_species_details.allied_combat_groups, self.CombatGroup) then
		self.CombatGroup = desired_cgroup
		self:Align_cgroup_members()
	end
	-- wait a day then reset the above
	CreateGameTimeThread(function(this_nest)
		Sleep(day_duration)
		NestDelayedInit(this_nest)
	end, self)
end

function EnhancedTerritorialNest:get_next_consume_time()
	local wait_for = AsyncRand(hour_duration * 24, hour_duration * 36)
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
		nodes = MapCount(self, (self.territorial_range + (grows * expand_by)) * guim, function(thing)
			if not IsKindOf(thing, 'NestSpore') then return true end
		end)
		grows = grows + 1
		--("At this increased radius, there are ",nodes,' valid nodes to consume')
	end
	--("There was enough nodes nearby to warrant an increase of",grows*expand_by,' meter radius')
	self.elders_max_count = self.elders_max_count + grows
	self.hatchlings_max_count = self.hatchlings_max_count + grows
	self.adults_max_count = self.adults_max_count + grows
end

function Convert_nest_into(nest_to_convert, other_species, delete_old_members)
	if not Presets.NestingSpeciesPreset.Default[other_species] then return end
	local species = Presets.NestingSpeciesPreset.Default[other_species]
	local o_species_tags = species.PrefabTags
	local my_current = Presets.NestingSpeciesPreset.Default[nest_to_convert.nest_species]
	local spore_building_def = my_current.spore_buildings
	local spores = MapGet(nest_to_convert, nest_to_convert.max_range, spore_building_def)
	if delete_old_members then
		for _, member in ipairs(nest_to_convert.nest_members) do
			member:SetNest(false)
			DoneObject(member)
		end
	end
	for _, spore in ipairs(spores or empty_tanl) do
		DoneObject(spore)
	end
	local def = g_Classes['FallingDebrisMarker']
	local old_marker = MapFindNearest(nest_to_convert, true, 'TerritorialNestMarker')
	DoneObject(nest_to_convert)
	local pos = old_marker:GetPos()
	local new_marker = def:new()
	new_marker:SetPosAngle(pos)
	DoneObject(old_marker)

	SuspendPassEdits("SpawndNest")
	local seed = InteractionRand(nil, "DailySpawn")
	local nest
	--(seed)
	--()
	local err, objs, pos, prefab, name, inv_bbox = new_marker:PlacePrefab(seed, {
		tags_all = o_species_tags,
	})
	if not err then
		local nest_marker = FindFirstIsKindOf(objs, "TerritorialNestMarker")
		if nest_marker then
			nest = nest_marker:SpawnNest(true)
		else
			assert(false, "Prefab without a nest marker: " .. name)
		end
	else
		assert(false, "Prefab error: " .. err)
	end
	ResumePassEdits("SpawndNest")
	AddGameNotification("JunoNestSpawned", nil, nil, { nest })
	return nest
	--SpawnNestInsideMap(new_marker,nil,species.nest_class, 1)
end

function EnhancedTerritorialNest:give_ep_to_struct(ep)
	if not ep then return end
	Bkob_Log_NA("Nest storing EP in support structures\n")
	local spore_building_def = g_Classes[Presets.NestingSpeciesPreset.Default[self.nest_species].spore_buildings]
	-- spore_buildings defaults to false, so g_Classes[false] can be nil here.
	if not spore_building_def then return end
	Bkob_Log_NA(spore_building_def.class)
	Bkob_Log_NA(self.territorial_range)
	local spores_near = MapGet(self, self.territorial_range, spore_building_def.class)
	-- Bail rather than error: consume_closest_node set consume_time = max_int before calling us, so an
	-- error here is procall-caught but never recovered and the nest never consumes again.
	if not spores_near or #spores_near == 0 then return end
	Bkob_Log_NA("There are this many spore buildings near me: ", #spores_near)
	local progress_each = DivRound(ep, #spores_near)
	local spore_res = Resources[spore_building_def.MineResource] --Resources[spores_near[1]]
	local spore_res_prog = spore_res.progress
	local units_to_give = Max(1, DivRound(progress_each, spore_res_prog))
	Bkob_Log_NA("Nest giving each nearby spore building this much resource units: ", units_to_give)
	for _, spore in ipairs(spores_near) do
		spore.MineAmount = spore.MineAmount + (units_to_give * const.ResourceScale)
	end
end

function EnhancedTerritorialNest:consume_closest_node()
	DebugPrint("Nest consuming nearest node\n")
	self.consume_time = max_int
	local closest_res = MapFindNearest(self, self, self.territorial_range, "EntityClass", function(thing)
		if (IsKindOf(thing, 'MineableRock') or IsKindOf(thing, 'Plant')) and not (IsKindOf(thing, 'NestSpore')) then return true end
	end)
	Bkob_Log_NA(closest_res)
	if not closest_res then
		self:expand()
		return --we expand instead of consuming
	end
	local res
	local amount
	if IsKindOf(closest_res, 'Plant') then
		local res_array = closest_res:GetCutResources() or closest_res:GetHarvestResources()
		res = res_array[1]['resource']
		amount = res_array[1]['amount']
	else
		res = closest_res.MineResource
		amount = closest_res.MineAmount
	end
	local node_res_units = DivRound(amount, const.ResourceScale)
	local ep_scale = 1000
	local progress = DivRound(Resources[res].progress * node_res_units, 10)
	Bkob_Log_NA("Nest is eating a ", closest_res.class)
	Bkob_Log_NA('Node has ', node_res_units, ' of ', res, ' in it! which is ', progress, ' EP')
	local EP_to_give = DivRound(progress, 4) -- flat 1/4 of EP is stored, the rest are "used" to grow / evolve
	Bkob_Log_NA("Giving this much EP collectively to the nest nodes: ", EP_to_give)
	DoneObject(closest_res)
	self:give_ep_to_struct(EP_to_give)
	local attack_cd = self.attack_delay
	self.attack_time = self.attack_time - DivRound(attack_cd, 100)
	self:get_next_consume_time()
end

function EnhancedTerritorialNest:GetStoryBitPopupImage()
	if self.class == 'ShriekerNest' then
		return 'Mod/TGkJ3Tu/Shrieker_Nest.PNG'
	elseif self.class == 'ScissorhandsNest' then
		return 'Mod/TGkJ3Tu/Scissor_Nest.PNG'
	elseif self.class == 'ConsortiumNest' then
		return 'ConsortiumNestVariant.PNG'
	else
		return 'Mod/TGkJ3Tu/Shrieker_Nest.PNG'
	end
end

-- Closest does 2 things
-- Make sure it is the closest nest to the player from a "general" direction
-- And if not, make sure there is a nest in between this nest and the player.
-- nest:Dist2D(me) < MulDivRound(3 * distance_to_beat,1,2) is my current way to detect if a nest is "in between" the player and this nest

function EnhancedTerritorialNest:get_proximity()
	-- Get_center_of_survivors averages the living party and falls back to the map
	-- centre when no survivor is valid on-map (e.g. the whole party is out on an
	-- expedition). A bare AveragePoint2D(GetValidSurvivorsOnMap()) would crash on
	-- that empty list; this mirrors the mod's other survivor-centre call sites.
	local center = Get_center_of_survivors()
	local dist_to_center = self:GetDist2D(center)
	local rate = 150 * guim  -- 150 meters per thresholdz
	local prox = DivRound(dist_to_center, rate)
	prox = Max(1, Min(5, prox)) -- closest nests have a prox of 1
	self.proximity = prox
	return prox
end

function EnhancedTerritorialNest:Getui_evo()
	DebugPrint("Getting the UI % how close to an evo the nest is\n")
	local option_1 = DivRound(self.attacks_done * 100, self.attacks_to_evo)
	local option_2 = check_count_and_upgrade(self.elder_class, {}, 100)
	if option_2 ~= self.elder_class then
		return 100 -- will show 100% if the EP is already high enough to trigger a "passive" evo
	else
		return Max(1, option_1)
	end
end

function EnhancedTerritorialNest:Getui_attack_strength()
	--local max_possible = per_species_nest_max*10
	if self.state == 'asleep' then
		return 10
	else
		return self:calculate_attack_strength('player')
	end
end

function EnhancedTerritorialNest:Getui_attack_cap()
	local player_attack = self:calculate_attack_strength('player')
	local current_cap = self:get_attack_cap()
	return DivRound(player_attack * 100, current_cap)
end

function EnhancedTerritorialNest:Getui_attack_percent()
	DebugPrint("Getting the UI % of how close an attack from the nest is\n")
	local time_till_attack = self.attack_time - GameTime()
	local num = self.attack_delay - time_till_attack
	local percent = DivRound(num * 100, self.attack_delay)
	return Max(1, percent)
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
	Bkob_Log("Forced Evo: ", force_evo)
	local elder = self.elder_class
	local upgraded_flag = false
	local evo, _, __
	if force_evo then
		evo = Find_evolution(g_Classes[elder])
	else
		local AdditionalClassList = {}
		AdditionalClassList[#AdditionalClassList + 1] = { self.adult_class, 150 }
		AdditionalClassList[#AdditionalClassList + 1] = { self.hatchling_class, 50 }
		evo, _, __ = check_count_and_upgrade(elder, AdditionalClassList, 100)
	end
	if evo == elder and self.adult_class == self.hatchling_class and self.adult_class == self.elder_class then
		return upgraded_flag
	end
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

-- Moved this aggression to global var to allow runtime/save aggression changes
function EnhancedTerritorialNest:can_be_aggressive(who)
	if not Nest_Species_Savegame_Stats then
		NA_create_runtime()
	end
	if Nest_Species_Savegame_Stats[self.nest_species]['aggressive'] then
		return true
	elseif who == 'player' and self.attacked_by_player then
		return true
	elseif Nest_Species_Savegame_Stats[self.nest_species]['attacked_by_others'].who then
		return true
	else
		return false
	end
end

function EnhancedTerritorialNest:RegisterTarget(unit, time)
	if not Nest_Species_Savegame_Stats then
		NA_create_runtime()
	end
	local wake_up_flag = false
	if unit.player then
		self.attacked_by_player = true
		Nest_Species_Savegame_Stats[self.nest_species]['attacked_by_player'] = false
		wake_up_flag = true
	elseif unit.nest then
		Nest_Species_Savegame_Stats[self.nest_species]['attacked_by_others'][unit.nest.nest_species] = true
		wake_up_flag = true
	end
	if wake_up_flag and self.state ~= 'awake' and unit.nest.state ~= 'asleep' then
		DebugPrint("Nest registering an attacker!\n")
		self:SwitchState('sleepy')
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
		self.MaxHealth = DivRound(max_possible_hp, 2)
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
		self.sleep_check = GameTime() + const.Scale.months
		if notif_level == 2 then
			ForceActivateStoryBit('asleep_too_sleepy', self, true)
		elseif notif_level == 1 then
			AddGameNotification("waking_up", nil, nil, { self })
		end
	elseif new_state == "asleep" and not (self.state == "awake") then
		if notif_level == 2 then
			-- woken up
			ForceActivateStoryBit('back_to_sleep', self, true)
		elseif notif_level == 1 then
			AddGameNotification("back_to_sleep", nil, nil, { self })
		end
	end
	self.state = new_state
	self:UpdateNextAttackTime()
	self:set_new_max_hp()
end

function EnhancedTerritorialNest:get_attack_cap()
	local base = 50
	local awake_same_nests = MapCount(true, "TerritorialNest", function(other_nest, this_nest)
		if IsKindOf(other_nest, this_nest) and not (other_nest.state == 'asleep') and other_nest ~= this_nest then
			return true
		end
	end, self)
	local nest_based_cap = awake_same_nests * 10
	local year = const.Scale.years
	local time_based_cap = MulDivTrunc(1, GameTime(), year) * 50 + 50
	if base > time_based_cap and base > nest_based_cap then
		return base
	elseif time_based_cap > nest_based_cap then
		return time_based_cap
	else
		return nest_based_cap
	end
	return base
end

function EnhancedTerritorialNest:calculate_interspecies_war_strength(who)
	DebugPrint("Calculating interspecies war strength\n")
	local nest_EP = 0
	for _, defender in ipairs(who.nest_members) do
		nest_EP = nest_EP + g_Classes[defender.class].EventProgressValue
	end
	local rand = 75 + AsyncRand(75)
	return nest_EP + rand
end

function EnhancedTerritorialNest:calculate_attack_strength(who)
	DebugPrint("Nest calculating it's attack score\n")
	if who == 'player' then
		local max_attack_strength_allowed = self:get_attack_cap()
		local base_strength = self.base_strength or 20
		local diff_increase
		if Get_difficulty_offset() > 5 then
			diff_increase = 10
		else
			diff_increase = 0
		end
		local species = get_species_from_nest(self.class)
		local banked = 0
		local species_banked_aggr = species .. '_banked_aggr'
		if not Nest_Species_Savegame_Stats then
			NA_create_runtime()
		end
		if Nest_Species_Savegame_Stats[species] and Nest_Species_Savegame_Stats[self.nest_species][species_banked_aggr] then
			banked = Nest_Species_Savegame_Stats[self.nest_species][species_banked_aggr]
		else
			DebugPrint("Nesting species does not have an entry in map vars for their banked aggro! Alert mod author!")
			Nest_Species_Savegame_Stats[self.nest_species] = {}
			Nest_Species_Savegame_Stats[self.nest_species][species_banked_aggr] = 0
		end
		local subsequent_attacks = self.attacks_done * 10
		local prox_loss = self.proximity * 10
		local unfiltered_strength = base_strength + banked + subsequent_attacks + diff_increase - prox_loss
		-- Make sure we don't go below base or above cap
		local filtered_strength = Max(base_strength, Min(max_attack_strength_allowed, unfiltered_strength))
		DebugPrint("Desired attack strength: ")
		DebugPrint(unfiltered_strength)
		DebugPrint("\nActual attack strength:")
		DebugPrint(filtered_strength)
		DebugPrint("\n")
		return filtered_strength
	elseif IsKindOf(who, 'EnhancedTerritorialNest') and self.nest_species ~= get_species_from_nest(who.class) then
		return self:calculate_interspecies_war_strength(who)
	else
		return 10
	end
end

function nest_find_spawn_fake(spawndef_instance, spawn_class, target)
	local def = spawn_class and g_Classes[spawn_class]
	local pfclass = def.pfclass
	local range = spawndef_instance.nest.max_range
	local target_retry = 7
	local x, y
	local pos = terrain.FindPassableTile(spawndef_instance.nest, const.tfpPassClass, pfclass)
	local playbox = GetPlayBox()
	local nest_entity_radius = spawndef_instance.nest:GetRadius()
	for i = 1, target_retry do
		x, y = GetRandomPlayablePos(spawndef_instance.nest, range, guim, AsyncRand(), pfclass, def.radius)
		local temp_pos = point(x, y)
		local playbox_check = playbox:Dist2(temp_pos) > 1
		local under_nest = IsCloser2D(pos, temp_pos, nest_entity_radius)
		if playbox_check or under_nest then
			x = nil
			target_retry = target_retry - 1
			range = range * 2
		else
			local possible_pos = point(x, y)
			return possible_pos
		end
	end
	::continue::
	dbg(spawndef_instance:DbgMarkFailedSpawn(spawndef_instance.nest, 7))
end

function nest_find_attack_spawn(spawndef_instance, spawn_class, target)
	--print("Finding spawn point near a nest!")
	local playbox = GetPlayBox()
	if not target then
		--print("Didn't get a target to spawn near!")
		target = spawndef_instance:ResolveTarget()
	end
	local def = spawn_class and g_Classes[spawn_class]
	local pfclass = def.pfclass
	local pos = terrain.FindPassableTile(spawndef_instance.nest, const.tfpPassClass, pfclass)
	if not pos then print("no pos found!") end
	local nest_entity_radius = spawndef_instance.nest:GetRadius()
	local x, y
	local retry = 10
	local range = spawndef_instance.nest.max_range
	local target_radius = 30 * guim
	while not x and retry > 0 do
		local spot_closest_to_target = terrain.FindPassable(target, pfclass, target_radius)
		if not spot_closest_to_target then
			target_radius = target_radius * 2
		else
			x, y = GetRandomPlayablePos(pos, range, guim, AsyncRand(), pfclass, def.radius)
			local temp_pos = point(x, y)
			local playbox_check = playbox:Dist2(temp_pos) > 1
			local under_nest = IsCloser2D(pos, temp_pos, nest_entity_radius)
			if playbox_check or under_nest then
				x = nil
				retry = retry - 1
				range = range * 2
			else
				local possible_pos = point(x, y)
				if ConnectivityCheck(possible_pos, spot_closest_to_target, pfclass) then
					--print("Found a point!")
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

local post_spawn_animal = function(self, obj, target, context)
	obj.CombatHostile = true
	Msg("SpawnedAnimalThreat", obj)
	give_nest_speed_effect(obj, self.nest.proximity)
end

local post_spawn_robot = function(self, obj, target, context)
	obj:SetInvader(true)
	Msg("SpawnedAnimalThreat", obj)
	give_nest_speed_effect(obj, self.nest.proximity)
end

function give_nest_speed_effect(ob, prox)
	local robot_flag = false
	local times = prox or 1
	if IsKindOf(ob, 'Robot') then
		robot_flag = true
	end
	while times > 0 do
		if robot_flag then
			ob:AddRobotCondition('nest_attack_speed_robot', 'mod')
		else
			ob:AddHealthCondition('nest_attack_speed', 'mod')
		end
		times = times - 1
	end
end

--[[
quadrants = {1={},2={}}
......
quadrants[1] = {
	shriekers={
			last_scout=y2d1,
			map_objs={
				1=scissorhand_nest_2,
				2=scissorhand_nest_3,
				3=consortium_nest_100
			},
			other_species={
			-- Used to determine what other species are attackable inside of this quadrant
				scissorhands={
					1=scissorhands_nest_2,
					2=scissorhands_nest_3
				},
				consortium={
					1=consortium_nest_100
				}
			}
	},
	scissorhands={repeat.....
	}
}
--]]

function EnhancedTerritorialNest:IsQuadrantScouted(quad_no)
	local my_species_quad_logs = Nest_scouting_quadrants[quad_no][self.nest_species]
	if my_species_quad_logs.last_scout == 0 or my_species_quad_logs.last_scout + const.Scale.years > GameTime() then
		return false
	else
		return true
	end
end

function EnhancedTerritorialNest:OnDie(reason)
	if reason == "combat" or reason == "bleeding" then
		local attacker = self.attack_received_by
		if IsValid(attacker) and attacker.player then
			MapForEach(self, range, "TerritorialNest", function(nest, me)
				if nest.nest_species == me.nest_species then
					self:nest_support_closest(nest)
				end
			end, self)
		end
	end
end

function EnhancedTerritorialNest:MarkScouted(other_species, time)
	rawset(self, other_species, time)
end

function ReportScoutingResults(quad_no, species, objects_to_report, player_found, nest)
	Reset_quadrant(quad_no, species)
	if nest.quadrant_scouting then
		nest.quadrant_scouting = false
	end
	local scout_quad_logs = Nest_scouting_quadrants[quad_no][species]
	if player_found then
		scout_quad_logs['player_presence'] = true
		DebugPrint("Player presence detected in this quadrant!\n")
		if nest:IsAsleep() then
			nest:SwitchState('sleepy')
		end
	end
	scout_quad_logs.last_scout = GameTime()
	scout_quad_logs['map_objs'] = objects_to_report
	for _, obj in ipairs(objects_to_report) do
		if IsKindOf(obj, "TerritorialNest") and obj.nest_species ~= species then
			local that_species = obj.nest_species
			if scout_quad_logs[that_species] then
				scout_quad_logs[that_species][#scout_quad_logs[that_species] + 1] = obj
			else
				scout_quad_logs[that_species] = {}
				scout_quad_logs[that_species][1] = obj
			end
			nest:MarkScouted(that_species, GameTime())
		end
		scout_quad_logs['map_objs'][#scout_quad_logs['map_objs'] + 1] = nest
	end
end

-- TODO instead of cheat learning about the quadrant, send out a nesting unit to scout
function EnhancedTerritorialNest:Scout_Specific_Quad(quad_no,map_hacks)
	DebugPrint("Nest is releasing a scouting unit!!\n")
	local spawn_def = SpawnDefs['Nest_scout_passive']
	if map_hacks then
		print('Using the map hack version!')
		spawn_def = SpawnDefs['Nest_scout_passive_map_hacks']
	end
	--used by invader to know what quadrant is to be scouted
	-- And to track if the scout ever returned
	if self.quadrant_scouting then
		DebugPrint("Whelp, looks like my last scout is MIA...")
	end
	self.quadrant_scouting = quad_no
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.adult_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t, {}, 100)
end

function MegaScout(nest)
	for i = 1, 25 do
		nest:Scout_Specific_Quad(i)
	end
end

function EnhancedTerritorialNest:scout_nearest_quad()
	DebugPrint("\nScouting closest usncouted quad!\n")
	if not self.quadrant then
		self.quadrant = Get_quadrant_from_obj(self, true)
	end
	if not self.nest_species then
		self.nest_species = get_species_from_nest(self.class)
	end
	if not Nest_scouting_quadrants[1] then
		CreateMapGrid()
	end
	local to_scout
	local shouldnt_scout = {}
	if not Nest_scouting_quadrants[self.quadrant] then
		CreateMapGrid()
	end
	local my_species_quad_logs = Nest_scouting_quadrants[self.quadrant][self.nest_species]
	if not my_species_quad_logs then
		CreateMapGrid()
		my_species_quad_logs = Nest_scouting_quadrants[self.quadrant][self.nest_species]
	end
	if my_species_quad_logs.last_scout == 0 then
		to_scout = self.quadrant
	elseif my_species_quad_logs.last_scout + const.Scale.years < GameTime() then
		to_scout = self.quadrant
		goto continue
	end
	shouldnt_scout[#shouldnt_scout + 1] = self.quadrant
	for i = 1, 5 do -- this limits the max scouting range to ~4 quadrants away
		--ignoring diagonals because..... its hard
		for _, no in ipairs(shouldnt_scout) do
			for _, q in ipairs(Get_adjacent_quads(no)) do
				if not table.find(shouldnt_scout, q) then
					if Nest_scouting_quadrants[q][self.nest_species].last_scout == 0 then
						to_scout = q
						goto continue
					elseif Nest_scouting_quadrants[q][self.nest_species].last_scout + const.Scale.years > GameTime() then
						shouldnt_scout[#shouldnt_scout + 1] = q
					else
						--print("Whelp, guess Im going to scout quadrant",q,"now!\n")
						to_scout = q
						goto continue
					end
				end
			end
		end
	end
	::continue::
	if not to_scout then
		DebugPrint("No quadrants within a length of 5 need to be scouted! Omega eating instead!\n")
		return
	else
		DebugPrint("I am scouting this quadrant:", to_scout, '\n')
	end
	self:Scout_Specific_Quad(to_scout)
end

function EnhancedTerritorialNest:nest_attack_player()
	DebugPrint("Nest is attacking the player directly!\n")
	local spawn_def = SpawnDefs['nest_attack']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.elder_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.adult_class, 150 }
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	local atk_str = self:calculate_attack_strength('player')
	spawn_def:ActivateSpawn(t, {}, atk_str)
end

function EnhancedTerritorialNest:nest_attack_non_player(enemy_nest)
	DebugPrint("Nest is attacking a non player target near it!\n")
	local spawn_def = SpawnDefs['nest_attack']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.elder_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.adult_class, 150 }
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	print("ACTIVATING SPAWN!")
	spawn_def:ActivateSpawn(t, {}, self:calculate_attack_strength(enemy_nest))
end

function EnhancedTerritorialNest:nest_support_closest(ally_nest)
	DebugPrint("Nest is sending support to the closest nest!\n")
	local spawn_def = SpawnDefs['Support_same_species_passive']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.adult_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	-- Support the specific in-sector ally chosen by GetSupportTarget: target IT so the reinforcement
	-- spawns near the ally (and does not march across the player's base). Fall back to the SpawnDef's
	-- own target resolution when called without an explicit ally.
	local t = ally_nest or spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t, {}, 100)
end

function EnhancedTerritorialNest:overflow_spawn()
	DebugPrint("Nest is overflowing with too much EP and is sending out a strong attack!\n")
	local spawn_def = SpawnDefs['nest_overflow']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.elder_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.adult_class, 150 }
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t, {}, self:calculate_attack_strength())
end

function EnhancedTerritorialNest:GetUnscoutedQuadrantsWithin(range)
	range = range or 5
	local unscouted = {}
	local processed_quads = {}
	local distance = 1
	unscouted[distance] = {}
	--print("I am in quadrant", self.quadrant,'\n')
	if self:IsQuadrantScouted(self.quadrant) then
		local distance_entry = unscouted[distance]
		distance_entry[#distance_entry + 1] = self.quadrant
	end
	processed_quads[#processed_quads + 1] = self.quadrant
	local temp_processed = {}
	for i = 1, range do
		distance = distance + 1
		-- to make sure that if we do returned_obj[distance] contains ALL quadrants that distance or less
		unscouted[distance] = table.copy(unscouted[distance - 1])
		--print("Now checking quadrants at distance ",distance-1,'\n')
		local distance_entry = unscouted[distance]
		for _, qu in ipairs(processed_quads) do
			local adjacent = Get_adjacent_quads(qu)
			--print("Looking through these: ", adjacent,'\n')
			for _, qua in ipairs(adjacent) do
				if not table.find(processed_quads, qua) and not table.find(temp_processed, qua) then
					temp_processed[#temp_processed + 1] = qua
					local scouted = self:IsQuadrantScouted(qua)
					if not scouted then
						distance_entry[#distance_entry + 1] = qua
					end
				end
			end
		end
		--print("Net new quadrants processed at ", #temp_processed," quadrants at distance ",distance-1,'\n')
		--print("This many quadrants need scouting at this distance: ",#distance_entry,'\n')
		for _, v in ipairs(temp_processed) do
			processed_quads[#processed_quads + 1] = v
		end
		temp_processed = {}
	end
	return unscouted
end

function EnhancedTerritorialNest:IsPlayerKnown()
	local my_species = get_species_from_nest(self.class)
	for _, quad in ipairs(Nest_scouting_quadrants) do
		if quad[my_species].player_presence then
			return true
		end
	end
	return false
end

function EnhancedTerritorialNest:IsCloserToPlayer(other_nest)
	local compare_point = Get_center_of_survivors()
	local my_distance = self:GetDist2D(compare_point)
	local other_distance = other_nest:GetDist2D(compare_point)
	return my_distance < other_distance
end

-- A nest attacks the player only when it is the most-forward of its species; a nest behind a same-species ally sends
-- support to that ally instead. "Behind" = the ally is closer to the survivor centre AND within an angular sector of
-- this nest's own bearing from that centre. The angular gate is what stops support being sent to a nest ~180 degrees
-- opposite (on the far side of the player), which is what would march units through the player's base. Returns the ally
-- nest to support, or false if this nest is the front line.
function EnhancedTerritorialNest:GetSupportTarget()
	local center = Get_center_of_survivors()
	local my_dist = self:GetDist2D(center)
	local my_bearing = CalcOrientation(center, self:GetPos())
	local sector = 60 * 60 -- +-60 degrees (HG angles are in 1/60-degree units) -> a 120-degree forward arc
	local best, best_dist
	MapForEach("map", self.class, function(nest, me)
		if nest == me then return end
		local n_dist = nest:GetDist2D(center)
		if n_dist >= my_dist then return end                                                     -- only nests ahead of me (closer to the survivors)
		if abs(AngleDiff(my_bearing, CalcOrientation(center, nest:GetPos()))) > sector then return end -- same sector only
		if not best or n_dist < best_dist then
			best, best_dist = nest, n_dist
		end
	end, self)
	return best or false
end

function EnhancedTerritorialNest:GetNearbyEnemiesNonPlayer(range)
	local valid_targets = MapGet(self, range, "TerritorialNest", function(nest, me)
		if IsKindOf(nest, "EnhancedTerritorialNest") and get_species_from_nest(nest.class) ~= me.nest_species
			and nest[me.nest_species] and nest[me.nest_species] + const.Scale.years < GameTime() then
			return true
		end
	end, self)
	local closest = {}
	for _, target in ipairs(valid_targets) do
		if table.find(closest, target.nest_species) then
			closest[target.nest_species] = target
		else
			closest[target.nest_species] = {}
			closest[target.nest_species][1] = target
		end
	end
	range = range or 5
	local enemy_selection = {}
	local processed_quads = {}
	local my_quad = Nest_scouting_quadrants[self.quadrant][self.nest_species]
	for _, species in pairs(my_quad.other_species) do
		table.insert_unique(enemy_selection, species)
	end
	processed_quads[#processed_quads + 1] = self.quadrant
	local temp_processed = {}
	for i = 1, range do
		for _, no in ipairs(processed_quads) do
			for _, q in ipairs(Get_adjacent_quads(no)) do
				local this_quad = Nest_scouting_quadrants[q][self.nest_species]
				if not table.find(processed_quads, q) and not table.find(temp_processed, q) then
					temp_processed[#temp_processed + 1] = q
					for _, species in pairs(this_quad.other_species) do
						table.insert_unique(enemy_selection, species)
					end
				end
			end
		end
		for _, v in ipairs(temp_processed) do
			processed_quads[#processed_quads + 1] = v
		end
		temp_processed = {}
	end
	return enemy_selection
end

function EnhancedTerritorialNest:ClosestSleepyNest(range)
	range = range or max_int
	local closest_sleepy = MapFindMin(self, range, "TerritorialNest", function(nest, me, range)
		if nest.nest_species == me.nest_species and nest.state == 'asleep' and me:GetDist2D(nest) < range then
			return me:GetDist2D(nest)
		end
	end, self, range)
	if closest_sleepy then
		return closest_sleepy
	else
		return false
	end
end

function EnhancedTerritorialNest:support_arrived(allied_unit)
	--print("A unit supporting me has arrived!")
	if self.state == 'asleep' then
		--print("This is going to try and wake me up!")
		if not self.wake_up_alarms then
			self.wake_up_alarms = 0
		end
		self.wake_up_alarms = self.wake_up_alarms + 1
		local awake = MapCount(true, "TerritorialNest", function(nest, me)
			if nest.nest_species == me.nest_species and not (nest.state == 'asleep') then
				return true
			end
		end, self)
		-- make it so that each nest needs more units to wake it up
		local threshold = 1
		if Faction_aggression_threshold > threshold then
			threshold = Faction_aggression_threshold
		end
		-- This means the first nest only needs a single wake up event
		local threshold = threshold * awake
		if self.wake_up_alarms > threshold then
			--print("It did wake me up!")
			self:SwitchState('awake')
		else
			--print("It did not wake me up, I need this many more: ",threshold - self.wake_up_alarms,'\n')
		end
		goto continue
	end
	local hatchling_tier = EE_get_tier(self.hatchling_class)
	local adult_tier = EE_get_tier(self.adult_class)
	local elder_tier = EE_get_tier(self.elder_class)
	local my_best = Max(hatchling_tier, adult_tier, elder_tier)
	for _, defender in ipairs(self.nest_members) do
		local d_tier = EE_get_tier(defender.class)
		if d_tier > my_best then
			my_best = d_tier
		end
	end
	--print("Checking if this unit is stronger than my best! My best is: ",my_best,'\n')
	local compare
	if allied_unit.class then
		compare = allied_unit.class
	else
		compare = allied_unit.id
	end
	--print("This unit is a tier: ",EE_get_tier(compare),' tier unit\n')
	if EE_get_tier(compare) > my_best then
		--print("It is!")
		self.attacks_done = self.attacks_done + 1
		if self.attacks_done > self.attacks_to_evo then
			--print("And it triggered an evolution!")
			self:change_nest_herd(true)
		end
		goto continue
	else
		--print("It was not")
	end
	--print("Storing this units EP cost in the nearby structrues and reducing attack time!")
	local EP_of_unit = g_Classes[allied_unit.class].EventProgressValue or 0
	self:give_ep_to_struct(EP_of_unit)
	local attack_cd = self.attack_delay
	-- each unit will reduce the attack cd by 5%
	self.attack_time = self.attack_time - (5 * DivRound(attack_cd, 100))
	::continue::
end

function EnhancedTerritorialNest:mega_consume()
	DebugPrint("Nest is consuming a lot of biomass to speed up it's next attack and evolution!\n")
	local multiplier = Get_difficulty_offset()
	for i = 1, 3 * multiplier do
		self:consume_closest_node()
	end
end

function EnhancedTerritorialNest:alert_neighbor(allied_sleepy_nest)
	DebugPrint("Nest is sending support to the closest nest!\n")
	local spawn_def = SpawnDefs['Nest_wakeup_alarm']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.SpawnClass = self.adult_class
	instance.AdditionalClassList = {}
	instance.AdditionalClassList[#instance.AdditionalClassList + 1] = { self.hatchling_class, 50 }
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t, {}, 100)
end

function EnhancedTerritorialNest:growth_event()
	DebugPrint("Nest has grown enough to do something!\n")
	self:UpdateNextAttackTime()
	self:change_nest_herd()
	local spawn_def
	local spawn_def_selection = {}
	if self.state == 'sleepy' then
		spawn_def_selection[#spawn_def_selection + 1] = { weight = 100, fun = self.overflow_spawn }
		spawn_def_selection[#spawn_def_selection + 1] = { weight = 15, fun = self.scout_nearest_quad }
		spawn_def = table.weighted_rand(spawn_def_selection, "weight")
		spawn_def.fun(self)
		return
	end
	-- ensure quadrant + scouting grid exist before reading them (growth_event lacked the guard
	-- that scout_nearest_quad has; on a fresh map the grid is uninitialised -> nil-index crash)
	if not self.quadrant then
		self.quadrant = Get_quadrant_from_obj(self, true)
	end
	if not self.nest_species then
		self.nest_species = get_species_from_nest(self.class)
	end
	if not Nest_scouting_quadrants[self.quadrant] then
		CreateMapGrid()
	end
	local unscouted = self:GetUnscoutedQuadrantsWithin()
	local my_quad_scouted = #unscouted[1] > 0
	local unscouted_nearby = unscouted[3]
	if not my_quad_scouted then
		spawn_def_selection[#spawn_def_selection + 1] = {
			weight = 200,
			fun = self.Scout_Specific_Quad,
			input = self
				.quadrant
		}
	elseif #unscouted_nearby > 0 then
		local to_scout = table.weighted_rand(unscouted_nearby, function(entry) return 100 end)
		spawn_def_selection[#spawn_def_selection + 1] = {
			weight = (100 * #unscouted_nearby),
			fun = self
				.Scout_Specific_Quad,
			input = to_scout
		}
	elseif #unscouted[#unscouted] > 0 then
		local to_scout = table.weighted_rand(unscouted[#unscouted], function(entry) return 100 end)
		spawn_def_selection[#spawn_def_selection + 1] = { weight = 15, fun = self.Scout_Specific_Quad, input = to_scout }
	end
	local attack_range = MulDivRound(NA_X_length + NA_Y_length, 3, 2)
	local nearby_enemies = self:GetNearbyEnemiesNonPlayer(attack_range)
	if #nearby_enemies > 0 then
		for _, enemy in ipairs(nearby_enemies) do
			local weight = 100
			if enemy.state == 'asleep' then
				weight = weight * 2
			end
			spawn_def_selection[#spawn_def_selection + 1] = {
				weight = weight,
				fun = self.nest_attack_non_player,
				input =
					enemy
			}
		end
	end
	-- note this means if a nest is awaken by another species, it will still be aggressive towards the player
	if self:IsPlayerKnown() and not self:IsAsleep() and self:can_be_aggressive() then
		-- Attack the player only if this nest is the front line of its species; if a same-species ally is ahead of us
		-- toward the survivors AND in roughly our own direction, support it instead. The angular gate stops support
		-- being sent to a ~180-degree-opposite nest (which would cross the player's base).
		local support_target = self:GetSupportTarget()
		if support_target then
			spawn_def_selection[#spawn_def_selection + 1] = {
				weight = 150,
				fun = self.nest_support_closest,
				input =
					support_target
			}
		else
			spawn_def_selection[#spawn_def_selection + 1] = { weight = 300, fun = self.nest_attack_player }
		end
	else
		local scouting
		if #unscouted[#unscouted] > 0 then
			scouting = table.weighted_rand(unscouted[#unscouted], function(entry) return 100 end)
		else
			-- we force scout the quadrant with the oldest scouted time as a major major backup
			for i = 1, #Nest_scouting_quadrants do
				if Nest_scouting_quadrants[i][self.nest_species].last_scout then
					scouting = i
					break
				end
				scouting = unscouted[1][1]
			end
		end
		-- if the player is not known, we ALWAYS want to scout and find them
		spawn_def_selection[#spawn_def_selection + 1] = { weight = 50, fun = self.Scout_Specific_Quad, input = scouting }
	end
	-- if there is a nest within ~3 quadrant lengths
	local wake_up_range = MulDivRound(NA_X_length + NA_Y_length, 3, 2)
	local sleepy = self:ClosestSleepyNest(wake_up_range)
	if sleepy then
		spawn_def_selection[#spawn_def_selection + 1] = { weight = 100, fun = self.alert_neighbor, input = sleepy }
	end
	-- always leave the options to just vomit enemies in the nearby area
	-- and consume a lot of nearby biomass
	spawn_def_selection[#spawn_def_selection + 1] = { weight = 10, fun = self.overflow_spawn }
	spawn_def_selection[#spawn_def_selection + 1] = { weight = 50, fun = self.mega_consume }
	spawn_def = table.weighted_rand(spawn_def_selection, "weight")
	if spawn_def.input then
		spawn_def.fun(self, spawn_def.input)
	else
		spawn_def.fun(self)
	end
end

function EnhancedTerritorialNest:UpdateNextAttackTime()
	DebugPrint("Nest updating when to attack next\n")
	local diff = Get_difficulty_offset() - 3
	self.attack_delay = MoonInstance.AttackCooldownMin +
		AsyncRand(MoonInstance.AttackCooldownMax - MoonInstance.AttackCooldownMin)
	if self.state == 'asleep' then self.attack_delay = self.attack_delay * 2 end
	self.attack_time = GameTime() + self.attack_delay --AsyncRand(fastest_attack_allowed,slowest_attack_allowed)
	DebugPrint("Next attack time:\n")
	DebugPrint(self.attack_time)
	DebugPrint("\nGame Time:\n")
	DebugPrint(GameTime())
	DebugPrint("\n")
end

function EnhancedTerritorialNest:TooTiredCheck()

end

function EnhancedTerritorialNest:OnObjUpdate(time, update_interval)
	local health = self.Health
	if health <= 0 then return end
	if self.attack_time < GameTime() and health > 0 and not self:IsDestroyed() then
		DebugPrint("Nest is activating!\n")
		self:growth_event()
		-- grow_event contains logic to determine what this event really "does"
	end
	if self.consume_time < GameTime() then
		self:consume_closest_node()
	end
	if self.state ~= 'asleep' and self.sleep_check ~= 0 and self.sleep_check < GameTime() then
		if self:TooTiredCheck() then
			self:SwitchState('asleep')
		else
			self.sleep_check = GameTime() + const.Scale.months
		end
	end
end

function TerritorialNest:Done()
	local members = self.nest_members
	for i = #members, 1, -1 do
		members[i]:SetNest(false)
	end
	DeleteThread(self.engagement_range_thread)
	self.engagement_range_thread = nil
	self:RemoveFromLabels(Game)
	self.attack_time = max_int
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

function UnitNesting:ReportScoutingResult()
	local quadrant = invader.target_quadrant
	local day = GameTime()
	local species = invader.location.nest_species
	local list_of_found = self.observed_objects
	nest_scouting_quadrants[quadrant][species]['last_scout'] = day
	-- Override the last scouting report
	nest_scouting_quadrants[quadrant][species]['map_objs'] = {}
	nest_scouting_quadrants[quadrant][species]['other_species'] = {}
	for _, b in ipairs(list_of_found) do
		local handle = b['handle'] or false
		if handle then
			nest_scouting_quadrants[quadrant][species]['map_objs'][#nest_scouting_quadrants[quadrant][species]['map_objs'] + 1] =
				handle
			local species = get_species_from_nest(b.class)
			if not nest_scouting_quadrants[quadrant][species]['other_species'][species] then
				nest_scouting_quadrants[quadrant][species]['other_species'][species] = {}
			end
			nest_scouting_quadrants[quadrant][species]['other_species'][species][#nest_scouting_quadrants[quadrant][species]['other_species'] + 1] =
				handle
		end
	end
end

-- override of base game function to give nest effect in case things go wrong
function TerritorialNest:AddNestMember(member)
	table.insert(self.nest_members, member)
	if member.CombatGroup ~= self.CombatGroup then
		member.CombatGroup = self.CombatGroup
	end
	-- mark guardian members as such (they stay close to the nest and protect it if attacked)
	self:TrySetNestGuardian(member)
	member:give_nest_effect()
end

function UnitNesting:give_nest_effect()
	if not self.nest then return end
	local nest = self.nest
	local give = self:IsCloser(nest, nest.territorial_range)
	if give then
		if IsKindOf(self, "Robot") then
			self:AddRobotCondition('FamiliarGroundRobo', 'mod')
		else
			self:AddHealthCondition(self.NestEffect or "", "nest")
		end
	elseif IsKindOf(self, "Robot") then
		self:RemoveRobotCondition('FamiliarGroundRobo', 'mod')
	else
		self:RemoveHealthConditions(self.NestEffect or "", "nest")
	end
end

function UnitNesting:UpdateAttachedUI()
	if (not self.nest and not self:CheckForNewBehaviors()) or NA_NestRoleZoom == 0 then return end
	RemoveAttachedUIToObject(self, 'NestRolePermanent')
	RemoveAttachedUIToObject(self, 'NestRoleClose')
	RemoveAttachedUIToObject(self, 'NestRoleFar')
	local template
	if NA_NestRoleZoom == 3 then
		template = 'NestRolePermanent'
	elseif NA_NestRoleZoom == 2 then
		template = 'NestRoleFar'
	elseif NA_NestRoleZoom == 1 then
		template = 'NestRoleClose'
	end
	if template then
		AddAttachedUIToObject(self, template, 'Task', self)
	end
end

function UnitNesting:GetUIRole()
	if not (self:CheckForNewBehaviors() or self.nest) or self:IsDead() then return end
	if self.hide_UI_on_empty and amount <= 0 then return "" end
	local name = ''
	if NA_NestRoleName then
		name = self:GetHUDName(self)
	end
	local scout = "Mod/TGkJ3Tu/PicsOritDidntHappen/unitnesting_scouting.png"
	local scout_found_player = "Mod/TGkJ3Tu/PicsOritDidntHappen/scout_found_player.png"
	local support = "Mod/TGkJ3Tu/PicsOritDidntHappen/unitnesting_support.png"
	local defender = "Mod/TGkJ3Tu/PicsOritDidntHappen/unitnesting_defender.png"
	local attacker = "Mod/TGkJ3Tu/PicsOritDidntHappen/unitnesting_attacker.png"
	local wallbreaker = "Mod/TGkJ3Tu/PicsOritDidntHappen/unitnesting_defender.png"
	if self.found_player then
		return T { "<image " .. scout_found_player .. " 1800><name>", name = name }
	elseif self.scouting then
		return T { "<image " .. scout .. " 1800><name>", name = name }
	elseif self.pathing_to then
		return T { "<image " .. support .. " 1800><name>", name = name }
	elseif self.nest then
		local image = defender
		return T { "<image " .. image .. " 1800><name>", name = name }
	end
end

local OG_ShouldShowHUDName = UnitAnimal.ShouldShowHUDName
function UnitAnimal:ShouldShowHUDName()
	local base = OG_ShouldShowHUDName(self)
	if self:CheckForNewBehaviors() or self.nest then return true else return base end
	--return GetAccountStorageOptionValue("ShowSurvivorNames") and self.custom_name ~= ""
end

function UnitNesting:SetNest(nest)
	nest = nest or false
	if nest == self.nest then return end
	local old_nest = self.nest
	if IsValid(old_nest) then
		old_nest:RemoveNestMember(self)
	end
	self.nest = nest or nil
	if IsValid(nest) then
		nest:AddNestMember(self)
		--self:AddHUDName()
	end
end

function is_inside_of(box, pos)
	if box:GetDist2D(pos) == 0 then
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
	local x, y
	local retry = 10
	-- overriding range given because that is usually just 10 meters...
	range = self.max_range
	while not x and retry > 0 do
		x, y = GetRandomPlayablePos(pos, range, guim, self:RandSeed("SpawnNestMember"), pfclass, def.radius)
		if x then
			local temp_pos = point(x, y)
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
	if IsKindOf(def, 'Robot') then
		local spawn_def = SpawnDefs['single_spawn_around_loc']
		local instance = {}
		instance.location = self
		instance.radius = range
		instance.PostSpawn = function(self, obj, target, context)
			obj:SetNest(self.location)
			obj:SetInvader(true)
		end
		instance.FindSpawnLoc = function(self, spawn_class, target, context)
			return point(x, y)
		end
		instance.SpawnClass = class
		spawn_def = spawn_def:CreateInstance(instance)
		local t = spawn_def:ResolveTarget()
		spawn_def:ActivateSpawn(t, {}, 100)
		return true
	else
		local obj
		obj = def:new()
		obj:SetNest(self)
		obj:SetPosAngle(x, y, const.InvalidZ, self:GetAngle() + self:Random(360 * 60, "SpawnNestMember"))
		if not instant then
			obj.init_with_command = "CmdSpawn"
		end
		return obj
	end
	-- in case we have changed what combat groups this nest is
	obj.CombatGroup = self.CombatGroup
	return false
end

function TerritorialNest:Spawn_robot_nestling(x, y, class)
	local spawn_def = SpawnDefs['Single_Robots']
	local instance = {}
	instance.location = self
	instance.nest = self
	instance.pos = point(x, y)
	instance.SpawnClass = class
	instance.FindSpawnLoc = function(self, spawn_class, target, context)
		return self.pos
	end
	--[[instance.PostSpawn = function(self,obj,target,context)
		obj:SetInvader(true)
		obj:SetNest(self.nest)
	end--]]
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t, {}, 100)
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

function count_effects_by_id(target, effect_id)
	local count = 0
	for _, effect in ipairs(target.status_effects or empty_table) do
		if effect.id == effect_id then
			count = count + 1
		end
	end
	return count
end

function decay_speed(target)
	local effect_id = 'nest_attack_speed'
	--[[if IsKindOf(target,'Robot') then
		effect_id = 'nest_attack_speed_robot'
		target:RemoveRobotConditions(effect_id, "ReplaceOldest")
	end--]]
	-- Get_center_of_survivors falls back to the map centre when no survivor is valid
	-- on-map; a bare AveragePoint2D(GetValidSurvivorsOnMap()) would crash on that empty
	-- list. Same guarded helper the mod's other survivor-centre sites use.
	local survivors = Get_center_of_survivors()
	local distance_to = target:GetDist2D(survivors)
	local prox = MulDivRound(distance_to, 1, 150 * guim)
	local count = count_effects_by_id(target, effect_id)
	while count > prox do
		if IsKindOf(target, 'Robot') then
			target:RemoveRobotConditions(effect_id, "ReplaceOldest")
			count = count_effects_by_id(target, effect_id)
		else
			target:RemoveHealthConditions(effect_id, "ReplaceOldest")
			count = count_effects_by_id(target, effect_id)
		end
	end
end

function add_delay_to_nests()
	MapForEach(true, "TerritorialNest", function(nest)
		if not nest.attack_delay or nest.attack_delay > MoonInstance.AttackCooldownMax then
			nest:UpdateNextAttackTime()
		end
	end)
end

function clean_up_robots()
	MapForEach(true, "Robot", function(robot)
		if not robot.Invader and not robot.command_center then
			DoneObject(robot)
		end
	end)
	MapForEach(true, "ConsortiumNest", function(nest)
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
	MapDelete("map", "HeavyHostileRobot_LVL1", function(robot, playbox)
		return is_inside_of(playbox, robot)
	end, GetPlayBox())
end

function SavegameFixups.EnhancedNestFixes()
	add_delay_to_nests()
	clean_up_robots()
	delete_robots()
end

function OnMsg.PostLoadGame()
	delete_robots()
end

function OnMsg.UpdateNestRoleVisuals()
	MapForEach('map', 'UnitNesting', function(nest_member)
		nest_member:UpdateAttachedUI()
	end)
end

--[[ Debugging ovverride
function CreateFloatingText(target, text, style, spot, stagger_spawn, params, game_time)
	print(text)
	return CreateCustomFloatingText(nil, target, text, style, spot, stagger_spawn, params, game_time)
end
--]]
