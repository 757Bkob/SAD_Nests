local hour_duration = const.HourDuration

-- brute force method.... not ideal
function SavegameFixups.NA_Disaster_clean()
	if GameState.SolarEclipse then
		DisasterPresets['SolarEclipse']:StopDisaster()
	end
end


function Setup_nest_mod()
	if MapVarValues["global_nest_spawn_cd"] == nil then MapVar("global_nest_spawn_cd",0) end
	if MapVarValues["Nest_Notifications"] == nil then MapVar("Nest_Notifications",1) end
	local species = Presets.NestingSpeciesPreset.Default --nests = ClassDescendantsList("TerritorialNest")
	for _, v in ipairs(species) do
		if v.nest_class then
			if MapVarValues[v.id..'_nest_spawn_cd'] == nil then MapVar(v.id..'_nest_spawn_cd',0) end
			if MapVarValues[v.id..'_evo_cd'] == nil then MapVar(v.id..'_evo_cd',0) end
			if MapVarValues[v.id..'_stored_aggr'] == nil then MapVar(v.id..'_stored_aggr',0) end
			if MapVarValues[v.id..'_aggro_events'] == nil then MapVar(v.id..'_aggro_events',0) end
		end
	end
	if MapVarValues['faction_aggression_threshold'] == nil then MapVar("faction_aggression_threshold",Max(0,6 - Get_difficulty_offset())) end --('faction_aggression_threshold',Max(0,6 - Get_difficulty_offset()))
	if MapVarValues['nest_tutorial'] == nil then MapVar("nest_tutorial",false) end
	if MapVarValues['nest_upgrade'] == nil then MapVar("nest_upgrade",false) end
	if MapVarValues['nest_disaster_species'] == nil then MapVar("nest_disaster_species",false) end
	if MapVarValues['nest_disaster'] == nil then MapVar("nest_disaster",false) end
	if MapVarValues['nests_needed'] == nil then MapVar("nests_needed",false) end
	if MapVarValues['nests_killed'] == nil then MapVar("nests_killed",false) end
	if MapVarValues['per_species_nest_max'] == nil then MapVar("per_species_nest_max",13) end
	if MapVarValues['shownNestTutorial'] == nil then MapVar("shownNestTutorial",false) end
end


------------------------------ HELPER FUNCTIONS ------------------------------
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

--assuming a string of the nest class
function get_species_from_nest(nest_class)
	local found = false
	for _,v in ipairs(ClassDescendantsList('TerritorialNest')) do
		if v == nest_class then
			found = true
		end
	end
	if not found then return end
	local entries = #Presets.NestingSpeciesPreset.Default
	for i=1, entries do
		local species = Presets.NestingSpeciesPreset.Default[i]
		if species and species.unit_species then
			if species.nest_class == nest_class then
				return species.id
			end
		end
	end
end

function Get_nest_species_by_region(region)
	region = region or Region.id
	DebugPrint("Getting nest class id by region\n")
    if region == 'Desertum' then
        return get_species_from_nest('ShriekerNest')
    elseif region == 'Sobrius' then
        return get_species_from_nest("ShriekerNest")
    elseif region == 'Saltu' then
        return get_species_from_nest('ScissorhandsNest')
	else
		return get_species_from_nest('ShriekerNest')
    end
end

function Get_nest_entity_by_region(region)
	region = region or Region.id
	DebugPrint("Getting nest class id by region\n")
    if region == 'Desertum' then
        return ('ShriekerNest')
    elseif region == 'Sobrius' then
        return get_species_from_nest("ShriekerNest")
    elseif region == 'Saltu' then
        return get_species_from_nest('ScissorhandsNest')
	else
		return get_species_from_nest('ShriekerNest')
    end
end


function Is_DLC_Present()
	DebugPrint("Checking if DLC loaded\n")
	return TradingShips['SmallCargoShip']
end

function mark_spawned_nest(nest_type)
	MapVarValues['global_nest_spawn_cd'] = GameTime() + MoonInstance.AttackCooldownMin
	local species_spawn_var = nest_type..'_nest_spawn_cd'
	MapVarValues[species_spawn_var] = MapVarValues['global_nest_spawn_cd'] * 3
end

function NA_log_nest_evolved(nest)
	local notif_level = Nest_Notifications or 1
	if notif_level == 2 then
		ForceActivateStoryBit('nests_evolving',self,true)
	elseif notif_level == 1 then
		AddGameNotification("nests_evolving", nil, nil, {nest})
	end
end

function NA_tutorial()
	if MapVarValues["shownNestTutorial"] or MapVarValues["shownNestTutorial"]==nil then return end
	Presets.TutorialHint.Default['nests_awaken_tutorial']:ShowNotification()
	MapVarValues["shownNestTutorial"]=true
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
	Nest_Notifications=nest_level
	local per_species = options.max_nest
	MapVarValues['per_species_nest_max'] = per_species or 13
end

OnMsg.GameStarted = Setup_nest_mod -- first start
OnMsg.LoadGame = Setup_nest_mod -- savegame load

function NA_QA(full_log)
	Setup_nest_mod()
	Build_species_pivot_table()
	build_pivot_tables()
	EE_Instantiate()
	full_log = full_log or false
	MapVarValues['EE_debug'] = full_log
	print("Testing regions default nests")
	print(Get_nest_entity_by_region('Desertum')=='nesting_shriekers')
	print(Get_nest_entity_by_region('Sobrius')=='nesting_shriekers')
	print(Get_nest_entity_by_region('Saltu')=='nesting_scissorhands')
	--assert(Get_nest_by_region('Desertum')=='nesting_shriekers')
	--assert(Get_nest_by_region('Sobrius')=='nesting_shriekers')
	--assert(Get_nest_by_region('Saltu')=='nesting_scissorhands')
	Bkob_Log("Testing Nest spawner storybits!")
	local all_nest_species = Presets.NestingSpeciesPreset.Default
	-- this ensures there is one of each nest on the map for continued testing
	local og_EP = EventProgress
	for _, v in ipairs(all_nest_species) do
		if not v.nest_class then goto continue end
		if v.nest_class then
			ForceActivateStoryBit(v.spawner_storybit, nil, "immediate", nil, true)
		end
		CreateRealTimeThread(function(nestclass)
			print("Testing nest: "..nestclass)
			Sleep(5000)
			local nest_on_map = MapGetFirst(true,nestclass)
			local EP_nums = {100, 800, 1200, 5000, 15000, 30000, 75000, 140000,300000}
			local def = g_Classes[nestclass]
			local attack_at = GameTime() + (2*hour_duration)
			local attacked = false
			local deleted = false
			local og_hatch = def.hatchling_class
			local og_adult = def.adult_class
			local og_elder = def.elder_class
			local elder_chain = Find_evo_chain(og_elder)
			local reset = function(nest)
				nest.hatchling_class = og_hatch
				nest.adult_class = og_adult
				nest.elder_class = og_elder
			end
			nest_on_map:expand()
			for i=1, 10 do
				nest_on_map:consume_closest_node()
			end
			nest_on_map:SwitchState("sleepy")
			print("State should be sleepy: "..nest_on_map.state)
			nest_on_map:SwitchState("awake")
			print("State should be awake: "..nest_on_map.state)
			nest_on_map:SwitchState("asleep")
			print("State should be asleep: "..nest_on_map.state)
			for _,int in ipairs(EP_nums) do
				print("Testing with EP: ")
				print(int)
				EventProgress = int
				local correct_elder = elder_chain:get_correct_evo(int)
				nest_on_map:change_nest_herd()
				local possible = #correct_elder
				table.insert_unique(correct_elder,nest_on_map.elder_class)
				if possible ~= #correct_elder then
					print("Something went wrong evolving!")
				end
				Sleep(6000)
				nest_on_map:attack()
				reset(nest_on_map)
			end
		end, v.nest_class)
		::continue::
	end
	print("Testing resources!")
	local res_table = get_nest_res_table()
	for _,res in ipairs(table.keys(res_table)) do
		print(res)
		for _,species_entry in ipairs(res_table[res]) do
			print("This should aggro: "..species_entry.species)
			local to_send = {}
			to_send[res]=species_entry.chance
			print(to_send)
			for i=1,20 do
				Resource_aggression_check(to_send)
			end
		end
	end
	EventProgress = og_EP
end