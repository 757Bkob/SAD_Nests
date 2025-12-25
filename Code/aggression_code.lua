function Aggression_log_faction(nest_id)
	DebugPrint("Logging an aggression event\n")
	local to_return = false
	local threshold = faction_aggression_threshold
	local count = MapVarValues[nest_id .. '_aggro_events'] or 0
	count = count + 1
	if count >= threshold then
		to_return = true
		MapVarValues[nest_id .. '_aggro_events'] = 0
	else
		MapVarValues[nest_id .. '_aggro_events'] = count
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

function Add_To_Nest_Table(species, storybitname)
	species_to_new_storybit_table[species] = storybitname
end

local res_nest_mapping = {}
res_nest_mapping[#res_nest_mapping + 1] = { res = 'Silicon', nest = "ConsortiumNest" }
res_nest_mapping[#res_nest_mapping + 1] = { res = 'Synthetics', nest = "ConsortiumNest" }
res_nest_mapping[#res_nest_mapping + 1] = { res = 'Ore', nest = "ScissorhandsNest" }
res_nest_mapping[#res_nest_mapping + 1] = { res = 'RawMeat', nest = "ScissorhandsNest" }
res_nest_mapping[#res_nest_mapping + 1] = { res = 'CarbonNanotubes', nest = "ShriekerNest" }
res_nest_mapping[#res_nest_mapping + 1] = { res = 'RawMeatInsect', nest = "ShriekerNest" }

function Add_to_res_nest_mapping(res, nest)
	res_nest_mapping[res] = { nest }
end

function Resource_aggression_check(wierd_res_table)
	if not wierd_res_table then return end
	DebugPrint("A recipe completed\n")
	--("Checking this table for resources used factions care about:")
	--(wierd_res_table)
	local chance
	for _, v_table in ipairs(res_nest_mapping) do
		chance = wierd_res_table[v_table['res']]
		--("Is "..v_table['res'].." in this recipe table?")
		--(wierd_res_table[v_table['res']])
		if chance then
			DebugPrint("A resource was consumed a species cares about!\n")
			--("I FOUND A RESOURCE A SPECIES CARES ABOUT!")
			Aggression_up(v_table['nest'])
			if AsyncRand(100) > DivRound(chance, 1000) then
				DebugPrint("And it was noticed\n")
				-- If recipe uses 40 units of the resource, 40% chance to be detected
				Aggression_up(v_table['nest'])
			else
				DebugPrint("But it went unnoticed\n")
			end
		end
	end
end

local function can_spawn_nest(species)
	local count_total = MapCount("map", species)
	-- Do nothing if too many nests exist
	if count_total >= per_species_nest_max then
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

local function can_give_evo(species)
	local new_evo_time = GameTime() + DivRound(MoonInstance.AttackCooldownMin, 2)
	local species_evo_var = species .. '_evo_cd'
	if not MapVarValues[species_evo_var] then
		MapVar(species_evo_var, new_evo_time)
		return true
	elseif MapVarValues[species_evo_var] < GameTime() then
		MapVarValues[species_evo_var] = new_evo_time
		return true
	end
	return false
end

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
	local choice = { event = 'bank', weight = 100 }
	--choice[#choice + 1] = { event = 'attack', weight = 150 }
	if can_spawn_nest(species) then
		choice[#choice + 1] = { event = 'spawn', weight = 250 }
	end
	if can_give_evo(species) then
		choice[#choice + 1] = { event = 'evo', weight = 200 }
	end
	local count_total = MapCount("map", species)
	local count_awake = MapCount("map", species, function(this_nest)
		if this_nest.state == 'sleepy' then
			return true
		end
	end)
	if DivRound(count_awake * 100, count_total) < 75 then
		choice[#choice + 1] = { event = 'wakeup', weight = 150 }
	end
	local option, _, __ = table.weighted_rand(choice, 'weight')
	option = option.event
	if option == 'spawn' then
		local sb = species_to_new_storybit_table[species]
		ForceActivateStoryBit(sb)
	elseif option == 'evo' then
		local nest_picked = MapGetFirst("map", species)
		nest_picked.attacks_done = nest_picked.attacks_done + 1
		if nest_picked.attacks_to_evo == nest_picked.attacks_done then
			nest_picked:change_nest_herd(true)
		end
	elseif option == 'wakeup' then
		local nest_picked = MapGetFirst("map", species, function(this_nest)
			if this_nest.state == 'asleep' then
				return true
			end
		end)
		nest_picked:SwitchState("sleepy")
	elseif option == 'bank' then
		local species_banked_aggr = species .. '_stored_aggr'
		if not MapVarValues[species_banked_aggr] then
			MapVar(species_banked_aggr, 5)
		else
			MapVarValues[species_banked_aggr] = MapVarValues[species_banked_aggr] + 5
		end
	end
end

function Aggression_down(species)
	DebugPrint("Aggression down called\n")
	-- Will deactivate a nest if possible, eventually will lower attack chance/faction
	species = species or Get_nest_by_region()
	local nest
	nest = MapGetFirst("map", species, function(this_nest)
		if this_nest.state == 'sleepy' then
			return true
		end
	end)
	if nest then
		nest:SwitchState("asleep")
	end
end
