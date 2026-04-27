local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.ShoguSporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'AlienPlants_05',
	
	MineResource = "FuelManure",
	MineAmount = 300 * const.ResourceScale,
	
	display_name = T(874589013, "Shogu Pustule"),
	description = T(8674234451245, "After cracking this pustule open, a defensive splash of parasites and bacteria greets the unfortunate inquisitor. Handle with care!"),
	description_unknown = T(223421771208911, "<em>Unknown building, it elicits a primal urge to keep away....</em>"),
	
	TimeToMine = 1 * const.HourDuration,
	FieldResearchTech = "FieldShoguSpore",
}

DefineClass.ShoguSporeDeposit2 = {
	__parents = { "ShoguSporeDeposit" },
	entity = 'AlienPlants_06',
}

DefineClass.ShoguSporeDeposit3 = {
	__parents = { "ShoguSporeDeposit" },
	entity = 'AlienPlants_03',
}

DefineClass.ShoguNest = {
	__parents = { "TerritorialNest" },
	
	entity = "AlienPlants_04",
	
	daily_plant_damage = const.Shriekers.NestDailyPlantDamage,
	guard_range = const.Shriekers.NestGuardRange,
	guardians_count = const.Scissorhands.NestGuardiansCount,
	adults_max_count = const.Shriekers.NestMaxAdultsPerNest,
	hatchlings_max_count = const.Shriekers.NestMaxHatchlingsPerNest,
	elders_max_count = const.Scissorhands.NestMaxEldersPerNest,
	min_spawn_interval = const.Shriekers.NestMinSpawnInterval,
	max_spawn_interval = const.Shriekers.NestMaxSpawnInterval,
	initial_range = const.Shriekers.NestInitialTerritorialRange,
	terrain_range_border = const.Shriekers.NestTerrainRangeAddition,
	grow_interval = const.Shriekers.NestGrowInterval,
	range_increase = const.Shriekers.NestRangeIncrease,
	max_range = const.Shriekers.NestMaxTerritorialRange,
	min_attacks_count = const.Shriekers.NestMinMembersForAttack,
	engagement_time = const.Shriekers.NestEngagementTime,
	
	adult_class = "Shogu_T3" ,
	hatchling_class = "Shogu_T2",
	elder_class = "Shogu_T4",
	CombatGroup = "Shogus",
	
	terrain_change = true,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Shogu Blight"),
	Description = T(904421747272, "How such a density of parasites and bacteria can occur without one species dominates is scientifically fascinating. Realisticaly, this is more dangerous to any form of life within a 50 mile radius."),
}

EntityData["AlienPlants_03"] = {
	entity = {
		material_type = "Wood",
		class_parent = "Deposition,ShoguSporeDeposit",
	},
}
EntityData["AlienPlants_05"] = {
	entity = {
		material_type = "Wood",
		class_parent = "Deposition,ShoguSporeDeposit",
	},
}
EntityData["AlienPlants_06"] = {
	entity = {
		material_type = "Wood",
		class_parent = "Deposition,ShoguSporeDeposit",
	},
}
DefineClass.ShoguNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "AlienPlants_04",
	editor_text_color = RGB(255,128,128),
	NestClass = "ShoguNest",
	--editor_color = RGB(255,0,0),
}


function ShoguNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('shogu_nest_robo_decay')-- give decaying robo shogu_nest_robo_decay
			else
				unit:AddHealthCondition('shogu_nest_bio_decay')-- give decaying bio shogu_nest_bio_decay
			end
		end
	end,self)
end