
local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.GlutchSporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'AlienFormations_05',
	
	MineResource = "LiquidFuel",
	MineAmount = 200 * const.ResourceScale,
	
	display_name = T(874589013, "Glutch Pustule"),
	description = T(8674234451245, "A fully hollowed out dead tree, filled with compressed gasses. Care needs to be taken to extract and convert the gas into usable fuel!"),
	description_unknown = T(223421771208911, "<em>By all appearances, these are dying foliage. But these can occasionally be seen to explode(!), even from minor impacts.</em>"),
	
	TimeToMine = 10 * const.HourDuration,
	FieldResearchTech = "FieldGlutchSpore",
}

DefineClass.GlutchSporeDeposit2 = {
	__parents = { "GlutchSporeDeposit" },
	entity = 'AlienFormations_07',
}

DefineClass.GlutchSporeDeposit3 = {
	__parents = { "GlutchSporeDeposit" },
	entity = 'AlienFormations_09',
}

DefineClass.GlutchNest = {
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
	
	adult_class = "Glutch_Brute" ,
	hatchling_class = "Glutch",
	elder_class = "Glutch_T3",
	CombatGroup = "Glutchs",
	
	terrain_change = true,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Glutch Canister"),
	Description = T(904421747272, "A tree that naturally generates gaseous methane and other easily combustible gasses. Loved by Glutches as their favorite meal, and usually where Glutch Pods spawn."),
}

EntityData["AlienFormations_05"] = {
	entity = {
		material_type = "Plant-Fruit",
		class_parent = "Deposition,GlutchSporeDeposit",
	},
}
EntityData["AlienFormations_07"] = {
	entity = {
		material_type = "Plant-Fruit",
		class_parent = "Deposition,GlutchSporeDeposit",
	},
}
EntityData["AlienFormations_09"] = {
	entity = {
		material_type = "Plant-Fruit",
		class_parent = "Deposition,GlutchSporeDeposit",
	},
}
EntityData["Glutch_EggPile"] = {
	entity = {
		material_type = "Plant-Fruit",
		class_parent = "Deposition,GlutchSporeDeposit",
	},
}
DefineClass.GlutchNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "AlienPlants_04",
	editor_text_color = RGB(255,128,128),
	NestClass = "GlutchNest",
	--editor_color = RGB(255,0,0),
}

--[[
function GlutchNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('Glutch_nest_robo_decay')-- give decaying robo Glutch_nest_robo_decay
			else
				unit:AddHealthCondition('Glutch_nest_bio_decay')-- give decaying bio Glutch_nest_bio_decay
			end
		end
	end,self)
end
--]]