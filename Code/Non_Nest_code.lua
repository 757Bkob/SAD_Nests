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

------------------------------ HELPER ------------------------------
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
	return TradingShips['SmallCargoShip']
end


------- TO BE EXPANDED ON IN FACTION OVERHAUL?!?!? -------

-- Aggression throttling based on difficulty
-- Hitting this function will auto-increment faction delay
-- Returns true/false if this aggression instance is to be acted on
function Aggression_log_faction(faction)
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
	return to_return
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
--[[
function ActivateNearestConsortiumNest()
    local center = Get_center_of_survivors()
    local closest_nest = MapFindNearest(center,true,'ConsortiumNest',function(nest_i_want) return nest_i_want.state == 'asleep' end)
    if closest_nest then
        closest_nest:SwitchState('sleepy')
		closest_nest:SwitchState('sleepy')
	elseif Get_difficulty_offset() > 4 then
		ForceActivateStoryBit('new_nest_consortium')
		closest_nest = MapFindNearest(center,true,'ConsortiumNest',function(nest_i_want) return nest_i_want.state == 'asleep' end)
		if closest_nest then
			closest_nest:SwitchState('sleepy')
		else
			--("ERROR NO CONSORTIUM NEST SPAWNED!")
		end
    end
end

function ActivateNearestInsectNest()
    local nest_type = Get_nest_by_region()
	local nest_sb = species_to_new_storybit_table[nest_type]
    local center = get_center_of_survivors()
    local closest_nest = MapFindNearest('TerritorialNest',center,function(nest_i_want,s_c)
		if (nest_i_want.entity == s_c or IsKindOf(nest_i_want,'ScissorhandsNest')) and nest_i_want.state == 'asleep' then
			return true
		end
	end,s_c)
    if closest_nest then
        closest_nest:SwitchState('sleepy')
	elseif Get_difficulty_offset() > 4 then
		ForceActivateStoryBit(nest_sb)
    	    local closest_nest = MapFindNearest('TerritorialNest',center,function(nest_i_want,s_c)
				if (nest_i_want.entity == s_c or IsKindOf(nest_i_want,'ScissorhandsNest')) and nest_i_want.state == 'asleep' then
					return true
				end
			end,s_c)
		if closest_nest then
        	closest_nest:SwitchState('sleepy')
		else
			--("ERROR NO INSECT NEST SPAWNED")
		end
    end
end
--]]

local species_to_new_storybit_table = {}
species_to_new_storybit_table['ShriekerNest'] = 'new_nest_shrieker'
species_to_new_storybit_table['ScissorhandsNest'] = 'new_nest_scissorhand'
species_to_new_storybit_table['ConsortiumNest'] = 'new_nest_consortium'

function Add_To_Nest_Table(species,storybitname)
	species_to_new_storybit_table[species] = storybitname
end

local res_nest_mapping = {}
res_nest_mapping[#res_nest_mapping+1] = {res='Silicon',nest="ConsortiumNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='Ore',nest="ConsortiumNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='Stone',nest="ScissorhandsNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='RawMeat',nest="ScissorhandsNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='CarbonNanotubes',nest="ShriekerNest"}
res_nest_mapping[#res_nest_mapping+1] = {res='RawMeatInsect',nest="ShriekerNest"}

function Add_to_res_nest_mapping(res,nest)
	res_nest_mapping[res] = {nest}
end

function Resource_aggression_check(wierd_res_table)
	--("Checking this table for resources used factions care about:")
	--(wierd_res_table)
	local chance
	for _,v_table in ipairs(res_nest_mapping) do
		chance = wierd_res_table[v_table['res']]
		--("Is "..v_table['res'].." in this recipe table?")
		--(wierd_res_table[v_table['res']])
		if chance then
			--("I FOUND A RESOURCE A SPECIES CARES ABOUT!")
			Aggression_up(v_table['nest'])
			--[[if AsyncRand(100) > DivRound(chance,1000) then
				-- If recipe uses 40 units of the resource, 40% chance to be detected
				Aggression_up(v_table['nest'])
			end--]]
		end
	end
end

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
    if MapVarValues['nest_disaster'] then return end
    MapVar('nest_disaster',GameTime()+hours_per_day)
	local nest_class = MapVarValues['nest_disaster_species'] or MapVar(nest_disaster_species,Get_nest_by_region())
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
		MapVar("nests_needed",MulDiv(nests,denom))
        ForceActivateStoryBit("nest_disaster_phase_2")
	end,nest_class,nest_storybit_spawner)
end

------------------------------ NEW NEST SPAWN CODE ------------------------------

function SpawnNestInsideMap(marker, seed, nest_type, danger_lvl)
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

------------------------------ GENERIC FACTION CALLS ------------------------------

function Aggression_up(species)
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

------------------------- NEST WAKING UP BASED ON RESOURCE USE --------------------------


function Aggression_based_on_recipe(device)
	--(device)
	local producing = device.unfinished_item_data
	--(producing)
	for _,v in ipairs(producing.used_resources) do
		-- test
		--(v)
		for _,info in ipairs(res_nest_mapping) do
			local resour = info['item']
			--(resour)
			--local nest_class = info['nest']
			--(resour == v)
			if v[resour] == v[f_to_call] and AsyncRand(100) < 5 then
				f()
			end
		end
	end
end

------------------------------ T-FORMATTING ------------------------------

function TFormat.nests_needed(context_obj)
	local nests = MapVarValues['nests_needed'] or 0
	return T{121110100812,"<no>",no=nests}
end

function TFormat.disaster_species(context_obj)
	if MapVarValues['nest_disaster_species'] == 'ShriekerNest' then
		return T{124110100435,"Shriekers"}
	elseif MapVarValues['nest_disaster_species'] == 'ScissorhandsNest' then
		return T{124110100437,"Scissorhands"}
	elseif MapVarValues['nest_disaster_species'] == 'ConsortiumNest' then
		return T{124110100436,"Robots"}
	else
		return T{124110100436,"Everything that has attacked us"}
	end
end


function TFormat.nests_left(context_obj)
	local nests_killed = MapVarValues['nests_killed'] or 1
    local nests_needed = MapVarValues['nests_needed'] or 10
	return T{121110100822,"<no>",no=nests_needed-nests_killed+1}-- Plus 1 because we start the var at 1
end

function TFormat.spore_diff_text(context_obj)
	if Get_difficulty_offset() > 5 then
		return T{121110100435,"\n\nOur scouting of the buildings surrounding the core nest are smaller and less dense...\nThe nests must have used those stored resources to evolve!\n<em>(Due to high difficulty setting)</em>"}
	else
		return T{121110100436,"\n\nThankfully our scouting has not found any other abnormalities in the nest.\n(<em>Due to low difficulty</em>)"}
	end
end

------------------------------ META ------------------------------

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

--TGkJ3Tu
OnMsg.ApplyModOptions = NA_Mod_Set

--[[
local function nests_awaken_reset_vars()
    local starting_nests = MapCount(true,"TerritorialNestMarker")
	local denom = Get_difficulty_offset()
    if not MapVarValues['nests_killed'] then
        MapVar('nests_needed',DivRound(nests_possible,denom))
    end
    if not MapVarValues['nests_killed'] then
        MapVar('nests_killed',0)
    end
end
--]]

--OnMsg.NewMapLoaded = nests_awaken_reset_vars
