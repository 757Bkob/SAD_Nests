
local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.DeathflySporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'GlacialisCliffs_04',
	
	MineResource = "OilAnimal",
	MineAmount = 40 * const.ResourceScale,
	
	display_name = T(874589013, "Deathfly Rock"),
	description = T(8674234451245, "Turns out the holes in the rock are actually complex tunnel networks, that Deathflys use as their nesting grounds."),
	description_unknown = T(223421771208911, "<em>A large rocky outcropping filled with tiny holes. Flying creatures can be seen flying in and out of said holes.</em>"),
	
	TimeToMine = 8 * const.HourDuration,
	FieldResearchTech = "FieldDeathflySpore",
}

DefineClass.DeathflySporeDeposit2 = {
	__parents = { "DeathflySporeDeposit" },
	entity = 'GlacialisCliffs_05',
}

DefineClass.DeathflySporeDeposit3 = {
	__parents = { "DeathflySporeDeposit" },
	entity = 'GlacialisRocks_06',
}

DefineClass.DeathflyNest = {
	__parents = { "TerritorialNest" },
	
	entity = "GlacialisCliffs_01",
	
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
	
	adult_class = "Dragonfly_T2" ,
	hatchling_class = "Dragonfly",
	elder_class = "Dragonfly_T3",
	CombatGroup = "Deathflys",
	
	terrain_change = false,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Deathfly Cliff"),
	Description = T(904421747272, "The Deathflies take the tallest porous rock formations as their home bases. Using their naturally acidic extrecetions to expand on the rocks natural tunnel system."),
}

EntityData["GlacialisCliffs_04"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DeathflySporeDeposit",
	},
}
EntityData["GlacialisCliffs_05"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DeathflySporeDeposit",
	},
}
EntityData["GlacialisRocks_06"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DeathflySporeDeposit",
	},
}
DefineClass.DeathflyNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "GlacialisCliffs_01",
	editor_text_color = RGB(255,128,128),
	NestClass = "DeathflyNest",
	--editor_color = RGB(255,0,0),
}

--[[
function DeathflyNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('Deathfly_nest_robo_decay')-- give decaying robo Deathfly_nest_robo_decay
			else
				unit:AddHealthCondition('Deathfly_nest_bio_decay')-- give decaying bio Deathfly_nest_bio_decay
			end
		end
	end,self)
end
--]]