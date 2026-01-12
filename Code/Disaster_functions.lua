--[[ disabling until it's cleaner
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