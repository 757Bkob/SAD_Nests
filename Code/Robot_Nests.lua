DefineClass.ConsortiumNestMarker = {
	__parents = { "TerritorialNestMarker" },
	
	entity = "PXPowerFacility",
	editor_text_color = RGB(255,128,128),
	NestClass = "ConsortiumNest",
	--editor_color = RGB(255,0,0),
}

DefineClass.ConsortiumSporeDeposit = {
	__parents = { "MineableRock" },
	
	MineResource = "ScrapMetal",
	MineAmount = 300 * const.ResourceScale,
	
	display_name = T(874568713, "Consortium Droid Support"),
	description = T(86745321245, "A standard building included in all Consortium Resource-Extraction-Prefab-Operation bundles."),
	description_unknown = T(257771208911, "<em>Unknown Consortium building. Requires up close studying to determine what this structure does.</em>"),
	
	TimeToMine = 4 * const.HourDuration,
	FieldResearchTech = "FieldConsortiumSpore",
}

DefineClass.ConsortiumNest = {
	__parents = { "TerritorialNest" },
	
	entity = "PXPowerFacility",
	
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
	
	adult_class = "LightHostileRobot_LVL1" ,
	hatchling_class = "FarmhandRobot",
	elder_class = "Crawl_APC_LVL1",
	
	terrain_change = true,
	terrain_form_preset = "ShriekerTerritoryTerrain",
	terrain_noise_preset = "ShriekerTerritoryNoise",
	terrain_type1 = "A_Grass_Blue",
	terrain_type2 = "AlienEarth_01_C2",
	
	detect_spot = "Origin",
	DisplayName = T(7864339223400, "Automaton Base"),
	Description = T(904421747272, "An automated control center, managing a group of harvest droids and it's defenders."),
}
-- Overriding to preserve the base class of the robots in adult/elder class
-- We do not stutterstep down, instead the assaults and crawlers will just get stronger
function ConsortiumNest:change_nest_herd(force_evo)
	-- Consortium nests will always have the same farmhand robot to simulate them consuming nearby resources
    local elder, adult= self.elder_class, self.adult_class
	local new_elder
	local new_adult
	local upgraded_flag = false
	if force_evo then
		new_elder = get_next(elder)
		new_adult = get_next(adult)
	else
		new_elder, _, _ = check_count_and_upgrade(elder,{},100)
		if new_elder ~= elder then 
			self.elder_class = new_elder
			upgraded_flag = true
			end
		new_adult, _, _ = check_count_and_upgrade(adult,{},100)
		if new_adult ~= adult then
			self.adult_class = new_adult
			upgraded_flag = true
		end
	end
	if not MapVarValues.nest_upgraded and (force_evo or upgraded_flag) then --first time is essentially a flag
		ForceActivateStoryBit("Nests_evolving")
		MapVar("nest_upgraded",true)
	end
	-- remove any newly-invalid creatures from nest_creatures
	local removed = false
	for _, unit in ipairs(self.nest_members) do
		local class = unit.class
		if not class == self.elder_class and not class == self.adult_class and not class == self.hatchling_class then
			self:RemoveNestMember(unit)
			-- This will force spawn a new set of higher tier nests. 
			-- If Nests are left unnattended they can get quite large groups defending it
		end
	end
	if removed then
		self:UpdateNextSpawnTime()
	end
    if force_evo then
        self.attacks_done = 0
        self.attacks_to_evo = self.attacks_to_evo + 1
    end
end