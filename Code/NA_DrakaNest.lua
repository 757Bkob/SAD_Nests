
local RESPONSE_NONE = const.DelayedResponseNone
local RESPONSE_DISTRESS = const.DelayedResponseDistress
local RESPONSE_ATTACK = const.DelayedResponseAttack

DefineClass.DrakaSporeDeposit = {
	__parents = { "MineableRock", "NestSpore" },
	entity = 'CrystalFormation_01',
	
	MineResource = "EnergyCrystals",
	MineAmount = 40 * const.ResourceScale,
	
	display_name = T(874589013, "Draka Chrysalis"),
	description = T(8674234451245, "These crystal structures incubate what we consider \"normal\" Draka into the stronger variants we have recently observed...."),
	description_unknown = T(223421771208911, "<em>A large crystal growth that radiates a large energy signature.</em>"),
	
	TimeToMine = 8 * const.HourDuration,
	FieldResearchTech = "FieldDrakaSpore",
}

DefineClass.DrakaSporeDeposit2 = {
	__parents = { "DrakaSporeDeposit" },
	entity = 'CrystalFormation_02',
}

DefineClass.DrakaSporeDeposit3 = {
	__parents = { "DrakaSporeDeposit" },
	entity = 'CrystalFormation_03',
}

DefineClass.DrakaNest = {
	__parents = { "TerritorialNest" },
	
	entity = "CrystalFormation_04",
	
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
	
	adult_class = "Draka_T3" ,
	hatchling_class = "Draka_T2",
	elder_class = "Draka_T4",
	CombatGroup = "Drakas",
	
	terrain_change = false,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Gemling Grove"),
	Description = T(904421747272, "Wether it is parasitic or symbiotic, all we know is that these mineral growths enable newly born Draka's to be deadly."),
}

EntityData["CrystalFormation_01"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DrakaSporeDeposit",
	},
}
EntityData["CrystalFormation_02"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DrakaSporeDeposit",
	},
}
EntityData["CrystalFormation_03"] = {
	entity = {
		material_type = "Metal",
		class_parent = "Deposition,DrakaSporeDeposit",
	},
}
DefineClass.DrakaNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "CrystalFormation_04",
	editor_text_color = RGB(255,128,128),
	NestClass = "DrakaNest",
	--editor_color = RGB(255,0,0),
}

--[[
function DrakaNest:OnObjUpdate(time, update_interval)
	MapForEach(self,self.territorial_range,'Unit',function(unit,nest)
		if unit.CombatGroup ~= nest.CombatGroup then
			if IsKindOf(unit,'Robot') then
				unit:AddRobotCondition('Draka_nest_robo_decay')-- give decaying robo Draka_nest_robo_decay
			else
				unit:AddHealthCondition('Draka_nest_bio_decay')-- give decaying bio Draka_nest_bio_decay
			end
		end
	end,self)
end
--]]