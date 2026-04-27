
local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.JunoSporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'AlienMushrooms_A_09',
	
	MineResource = "DryMeat",
	MineAmount = 100 * const.ResourceScale,
	
	display_name = T(874589013, "Pulsing Mass"),
	description = T(8674234451245, "A giant single-celled organism. Based on estimated, 95% of this cell is made of protien and is eerily similar to human muscle tissue."),
	description_unknown = T(223421771208911, "<em>A small, convulsing reddish mass.</em>"),
	
	TimeToMine = 2 * const.HourDuration,
	FieldResearchTech = "FieldJunoSpore",
}

DefineClass.JunoSporeDeposit2 = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'AlienMushrooms_A_10',
	
	MineResource = "DryMeat",
	MineAmount = 100 * const.ResourceScale,
	
	display_name = T(874589013, "Pulsing Mass"),
	description = T(8674234451245, "A giant single-celled organism. Based on estimated, 95% of this cell is made of protien and is eerily similar to human muscle tissue."),
	description_unknown = T(223421771208911, "<em>A small, convulsing reddish mass.</em>"),
	
	TimeToMine = 2 * const.HourDuration,
	FieldResearchTech = "FieldJunoSpore",
}

DefineClass.JunoSporeDeposit3 = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'AlienMushrooms_A_16',
	
	MineResource = "DryMeat",
	MineAmount = 100 * const.ResourceScale,
	
	display_name = T(874589013, "Pulsing Mass"),
	description = T(8674234451245, "A giant single-celled organism. Based on estimated, 95% of this cell is made of protien and is eerily similar to human muscle tissue."),
	description_unknown = T(223421771208911, "<em>A small, convulsing reddish mass.</em>"),
	
	TimeToMine = 2 * const.HourDuration,
	FieldResearchTech = "FieldJunoSpore",
}

DefineClass.JunoNest = {
	__parents = { "TerritorialNest" },
	
	entity = "AlienPlants_01",
	
	daily_plant_damage = const.Shriekers.NestDailyPlantDamage,
	guard_range = const.Shriekers.NestGuardRange,
	guardians_count = MulDivRound(const.Scissorhands.NestGuardiansCount,1,2),
	adults_max_count = MulDivRound(const.Shriekers.NestMaxAdultsPerNest,1,2),
	hatchlings_max_count = MulDivRound(const.Shriekers.NestMaxHatchlingsPerNest,1,2),
	elders_max_count = MulDivRound(const.Scissorhands.NestMaxEldersPerNest,1,2),
	min_spawn_interval = const.Shriekers.NestMinSpawnInterval,
	max_spawn_interval = const.Shriekers.NestMaxSpawnInterval,
	initial_range = const.Shriekers.NestInitialTerritorialRange,
	terrain_range_border = const.Shriekers.NestTerrainRangeAddition,
	grow_interval = const.Shriekers.NestGrowInterval,
	range_increase = const.Shriekers.NestRangeIncrease,
	max_range = const.Shriekers.NestMaxTerritorialRange,
	min_attacks_count = const.Shriekers.NestMinMembersForAttack,
	engagement_time = const.Shriekers.NestEngagementTime,
	
	adult_class = "Juno_Brute" ,
	hatchling_class = "Juno",
	elder_class = "Juno_T3",
	CombatGroup = "Junos",
	
	terrain_change = true,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Juno Infection "),
	Description = T(904421747272, "An automated control center, managing a group of harvest droids and it's defenders."),
}

EntityData["AlienMushrooms_A_09"] = {
	entity = {
		material_type = "Flesh",
		class_parent = "Deposition,JunoSporeDeposit",
	},
}
EntityData["AlienMushrooms_A_10"] = {
	entity = {
		material_type = "Flesh",
		class_parent = "Deposition,JunoSporeDeposit",
	},
}
EntityData["AlienMushrooms_A_16"] = {
	entity = {
		material_type = "Flesh",
		class_parent = "Deposition,JunoSporeDeposit",
	},
}
DefineClass.JunoNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "AlienPlants_01",
	editor_text_color = RGB(255,128,128),
	NestClass = "JunoNest",
	--editor_color = RGB(255,0,0),
}

--[[
function JunoNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('Juno_nest_robo_decay')-- give decaying robo Juno_nest_robo_decay
			else
				unit:AddHealthCondition('Juno_nest_bio_decay')-- give decaying bio Juno_nest_bio_decay
			end
		end
	end,self)
end
--]]