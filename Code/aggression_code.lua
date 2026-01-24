-- input a string or classdef, output the nesting species classdef (If we can find it)
function find_nest_species(input)
	local str_check = type(input) == 'string'
	local nest_spec_check, nest_entity_check
	if str_check then
		nest_spec_check = Presets.NestingSpeciesPreset.Default[input]
		nest_entity_check = g_Classes[input]
	else
		nest_spec_check = IsKindOf(input, "NestingSpecies")
		nest_entity_check = IsKindOf(input, "TerritorialNest")
	end
	if nest_entity_check then
		return get_species_from_nest(nest_entity_check.id)
	end
	if nest_spec_check then
		return nest_spec_check
	end
	return false
end

-- input a string or classdef, output the nesting species classdef (If we can find it)
function find_nest_class(input)
	local str_check = type(input) == 'string'
	local nest_spec_check, nest_entity_check
	if str_check then
		nest_spec_check = Presets.NestingSpeciesPreset.Default[input]
		nest_entity_check = g_Classes[input]
	else
		nest_spec_check = IsKindOf(input, "NestingSpecies")
		nest_entity_check = IsKindOf(input, "TerritorialNest")
	end
	if nest_entity_check then
		return nest_entity_check
	end
	if nest_spec_check then
		return g_Classes[nest_spec_check.nest_class]
	end
	return false
end

-- middle layer function so that on low difficulties the species take more to become aggresive
function Aggression_log_faction(input)
	local nesting_species = find_nest_species(input)
	if not nesting_species then return nil end
	DebugPrint("Logging an aggression event\n")
	print(IsKindOf(nesting_species, "NestingSpeciesPreset"))
	print(IsKindOf(nesting_species.id, "NestingSpeciesPreset"))
	local to_return = false
	local threshold = MapVarValues['faction_aggression_threshold'] or Max(0,6 - Get_difficulty_offset())
	local count = MapVarValues[nesting_species.id .. '_aggro_events'] or 0
	count = count + 1
	if count >= threshold then
		to_return = true
		MapVarValues[nesting_species.id .. '_aggro_events'] = 0
	else
		MapVarValues[nesting_species.id .. '_aggro_events'] = count
	end
	DebugPrint("Did this event trigger an aggression up?\n")
	DebugPrint(to_return)
	DebugPrint("\n")
	return to_return
end

-- Note to future me, the wierd_res_table is:
-- { res = amount, res2 = amount2, .... }
-- So we cannot loop through it, just check if any res that a nest species cares about is in the table
function Resource_aggression_check(wierd_res_table)
	local aggroed = {}
	if not wierd_res_table then return end
	print("input")
	print(wierd_res_table)
	DebugPrint("A recipe completed\n")
	-- res table already scaled because it is in the UI editor
	local res_table = get_nest_res_table()
	if #res_table == 0 then
		Build_species_pivot_table()
		res_table = get_nest_res_table()
	end
	local recipe_res = table.keys(wierd_res_table)
	print("recipe_res")
	print(recipe_res)
	--local scale = const.ResourceScale -- 1000 base
	for _,res in ipairs(recipe_res) do
		print("Checking res: "..res)
		if res_table[res] then
			print("it is a res that nests care about")
			-- already scaled because this is from the recipe
			local consumed = wierd_res_table[res]
			for _,v in ipairs(res_table[res]) do
				local roll = AsyncRand(100)
				local aggression_roll = roll > DivRound(consumed * 100, v.chance)
				if consumed >= v.chance or aggression_roll then
					print("Aggression triggered for species: "..v.species)
					Aggression_up(v.species)
					aggroed[#aggroed + 1] = v.species
				end
			end
		end
	end
	-- return which species got aggression up calls
	return aggroed
end

local function can_spawn_nest(input)
	local nest_species = find_nest_species(input)
	local nest_class_def = find_nest_class(input)
	if not nest_class_def then return nil end
	local nest_classname = nest_class_def.class
	print("Checking if can spawn nest for species: "..nest_species.id)
	print("Checking how many nests of this clas exist on map: "..nest_classname)
	local count_total = MapCount("map", nest_classname)
	-- Do nothing if too many nests exist
	if count_total >= MapVarValues['per_species_nest_max'] then
		return false
	end
	--local new_spawn_time = GameTime() + MoonInstance.AttackCooldownMin
	if not global_nest_spawn_cd then
		return true
	elseif global_nest_spawn_cd < GameTime() then
		return true
	end
	local species_spawn_var = species .. '_nest_spawn_cd'
	if not MapVarValues[species_spawn_var] then
		return true
	elseif MapVarValues[species_spawn_var] < GameTime() then
		return true
	end
	return false
end

local function can_give_evo(input)
	local nest_species = find_nest_species(input)
	if not nest_species then return nil end
	if MapCount(true, nest_species.nest_class) <= 0 then
		return false
	end
	local new_evo_time = GameTime() + DivRound(MoonInstance.AttackCooldownMin, 2)
	local species_evo_var = nest_species.id .. '_evo_cd'
	if not MapVarValues[species_evo_var] then
		MapVar(species_evo_var, new_evo_time)
		return true
	elseif MapVarValues[species_evo_var] < GameTime() then
		MapVarValues[species_evo_var] = new_evo_time
		return true
	end
	return false
end

function Aggression_up(input)
	local nest_species = find_nest_species(input)
	if not nest_species then
		nest_species = Get_nest_species_by_region()
	end
	DebugPrint("Aggression up called\n")
	print("Checking if species is valid")
	-- 1 Find our how many nests of the type on map
	-- 2 Find out % of said nests are not asleep
	--- 2a If 0 nests on map, need (difficulty offset - 8)
	-- 3 If % < 600%, wake up 1 nest
	-- 4 If % > 60%, spawn new nest
	--(species)
	print("Checking the aggression log!")
	local species_name = nest_species.id
	local species_nest_name = nest_species.nest_class
	if not Aggression_log_faction(species_name) then return end
	print("past the aggression check!")
	local count_total = MapCount("map", species_nest_name)
	local count_awake = MapCount("map", species_nest_name, function(this_nest)
		if this_nest.state == 'sleepy' then
			return true
		end
	end)
	local choice = {}
	choice[#choice + 1] = { event = 'bank', weight = 100 }
	if can_spawn_nest(species_name) then
		choice[#choice + 1] = { event = 'spawn', weight = 250 }
	end
	if count_total > 0 then
		choice[#choice + 1] = { event = 'consume', weight = 150 }
		if can_give_evo(species_name) then
			choice[#choice + 1] = { event = 'evo', weight = 200 }
		end
		if  DivRound(count_awake * 100, count_total) < 75 then
			choice[#choice + 1] = { event = 'wakeup', weight = 150 }
		end
	end
	print("Possible response options:")
	print(choice)
	local option, _, __ = table.weighted_rand(choice, 'weight')
	option = option.event
	print("option picked:")
	print(option)
	local weakest_nest
	if option == 'evo' or option == 'consume' then
		local nests = MapGet("map", species_nest_name, function(this_nest)
			if this_nest.state == 'asleep' then
				return true
			end
		end)
		local lowest_evo = 10
		local tiers = get_tier_Table()
		for _,v in ipairs(nests) do
			local tier = tiers[v.elder_class]
			if tier < lowest_evo then
				weakest_nest = v
				lowest_evo = tier
			end
		end
		print("Weakest nest needed, here it is:")
		print(weakest_nest)
	end
	if option == 'spawn' then
		local sb = nest_species.spawner_storybit
		ForceActivateStoryBit(sb)
	elseif option == 'evo' then
		weakest_nest.attacks_done = weakest_nest.attacks_done + 1
		if weakest_nest.attacks_to_evo == weakest_nest.attacks_done then
			weakest_nest:change_nest_herd(true)
		end
	elseif option == 'wakeup' then
		local nest_picked = MapGetFirst("map", species_nest_name, function(this_nest)
			if this_nest.state == 'asleep' then
				return true
			end
		end)
		nest_picked:SwitchState("sleepy")
	elseif option == 'bank' then
		local species_banked_aggr = species_name .. '_stored_aggr'
		if not MapVarValues[species_banked_aggr] then
			MapVar(species_banked_aggr, 5)
		else
			MapVarValues[species_banked_aggr] = MapVarValues[species_banked_aggr] + 5
		end
	elseif option == 'consume' then
		for i=1, Max(1, Get_difficulty_offset()) do
			weakest_nest:consume_closest_node()
		end
	end
end

function Aggression_down(input)
	local nest_species = find_nest_species(input)
	if not nest_species then
		nest_species = Get_nest_species_by_region()
	end
	local species_nest_name = nest_species.nest_class
	DebugPrint("Aggression down called\n")
	-- Will deactivate a nest if possible, eventually will lower attack chance/faction
	local nest
	nest = MapGetFirst("map", species_nest_name, function(this_nest)
		if this_nest.state == 'sleepy' then
			return true
		end
	end)
	if nest then
		nest:SwitchState("asleep")
	end
end
