function CheckAndSet(varname,val)
	if table.find(MapVars, varname) then
		MapVarValues[varname] = val
		return true
	else
		MapVar(varname,val)
	end
end

function Setup_nest_mod()
	CheckAndSet("global_nest_spawn_cd",0)
	CheckAndSet("Nest_Notifications",1)
	local nests = ClassDescendantsList("TerritorialNest")
	for _, nest in ipairs(nests) do
		CheckAndSet(nest..'_nest_spawn_cd',0)
		CheckAndSet(nest..'_evo_cd',0)
		CheckAndSet(nest..'_stored_aggr',0)
		CheckAndSet(nest..'_aggro_events',0)
	end
	CheckAndSet('faction_aggression_threshold',Max(0,6 - Get_difficulty_offset()))
	CheckAndSet('nest_tutorial',false)
	CheckAndSet('nest_upgrade',false)
	CheckAndSet('nest_disaster_species',false)
	CheckAndSet('nest_disaster',false)
	CheckAndSet('nests_needed',false)
	CheckAndSet('nests_killed',false)
	CheckAndSet('per_species_nest_max',13)
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

function mark_spawned_nest(nest_type)
	MapVarValues['global_nest_spawn_cd'] = GameTime() + MoonInstance.AttackCooldownMin
	local species_spawn_var = nest_type..'_nest_spawn_cd'
	MapVarValues[species_spawn_var] = MapVarValues['global_nest_spawn_cd'] * 3
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