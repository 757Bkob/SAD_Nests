local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.NothSporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'SpaceshipDebris_01',
	
	MineResource = "Metal",
	MineAmount = 150 * const.ResourceScale,
	
	display_name = T(874589013, "Metallic Debris"),
	description = T(8674234451245, "The falling debris introduced from nearby space traffic. Even though this is man made, you can clearly make out bite marks from nearby Noths...."),
	description_unknown = T(223421771208911, "<em>Crashed Spaceship debris, but oddly enough nearby Noths seem drawn to it.</em>"),
	
	TimeToMine = 10 * const.HourDuration,
	FieldResearchTech = "FieldNothSpore",
}

DefineClass.NothSporeDeposit2 = {
	__parents = { "NothSporeDeposit" },
	entity = 'SpaceshipDebris_02',
}

DefineClass.NothSporeDeposit3 = {
	__parents = { "NothSporeDeposit" },
	entity = 'SpaceshipDebris_03',
}

DefineClass.NothNest = {
	__parents = { "TerritorialNest" },
	
	entity = "Noth_Anvil",
	
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
	
	adult_class = "Noth_T3" ,
	hatchling_class = "Noth_T2",
	elder_class = "Noth_T4",
	CombatGroup = "Noths",
	
	terrain_change = false,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Noth Forge"),
	Description = T(904421747272, "With easy to forage metal from nearby debris, some evolved Noths have made this their home. And it appears the nearby metal also makes Noth reproduction MUCH easier."),
}

EntityData["AlienPlants_03"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,NothSporeDeposit",
	},
}
EntityData["SpaceshipDebris_03"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,NothSporeDeposit",
	},
}
EntityData["SpaceshipDebris_02"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,NothSporeDeposit",
	},
}
DefineClass.NothNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "Noth_Anvil",
	editor_text_color = RGB(255,128,128),
	NestClass = "NothNest",
	--editor_color = RGB(255,0,0),
}


function NothNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('Noth_nest_robo_decay')-- give decaying robo Noth_nest_robo_decay
			else
				unit:AddHealthCondition('Noth_nest_bio_decay')-- give decaying bio Noth_nest_bio_decay
			end
		end
	end,self)
end