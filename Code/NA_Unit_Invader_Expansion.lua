
-- ============================================================================
-- Support Behaviour
-- Spawned by a nest, and the unit will move to the next closest nest of it's species.
-- what a nest gets from being supported is a class function inside of nest expansion
-- ============================================================================
DefineClass.InvaderBehaviourSupport = {
	__parents = { "InvaderBehaviourBase", },
	properties = {
		{ id = "same_species", name = "Help same species?", help = "Automatically use the species as the primary spawned unit.", 
			editor = "bool", default = true},
		{ id = "support_species", name = "Species to Help", help = "The source nest (can be set automatically)", 
			editor = "choice", default = false, items = function() return Get_species_nests() end, no_edit = function(self) return self.same_species end},
		{ id = "ArrivalDistance", name = "Arrival Distance", help = "Distance to get close to the target nest before considering arrival", 
			editor = "number", default = 50000, scale = "m", min = 5000, },
	},
	EditorName = "Go to the second closest nest and support them.",
	
	-- Runtime state
	support_thread = false,
	from_nest = false,
	to_nest = false,
	arrival_confirmed = false,
}

function InvaderBehaviourSupport:OnAssign(invader, end_time)
	Bkob_Log_NA("assinging support behavior!")
	InvaderBehaviourBase.OnAssign(self, invader, end_time)
	invader.pathing = true
	invader.path_until = end_time
	invader.supporting = true
	invader.on_arrive = function(invader, target, progress)
		if IsKindOf(target,"TerritorialNest") then
			target:support_arrived()
		end
		RemoveAttachedUIToObject(invader, 'NestRolePermanent')
		RemoveAttachedUIToObject(invader, 'NestRoleClose')
		RemoveAttachedUIToObject(invader, 'NestRoleFar')
		self:SetCommand("CmdDespawn")
		return true
	end
	invader.pathing_proximity = self.ArrivalDistance or 50000
	local my_nest_id = invader:GetNestClass()
	invader.pathing_from = MapFindNearest(invader,true,my_nest_id)
	-- Destination = nearest same-species nest that is closer to the survivors than the origin AND
	-- within ~60 degrees of the origin's bearing from the survivor centre. The angular gate (Ark
	-- Builder's concern) keeps support from walking across the player's base to a ~180-degree-
	-- opposite nest. Mirrors EnhancedTerritorialNest:GetSupportTarget on the unit side.
	local center = Get_center_of_survivors()
	local from_bearing = invader.pathing_from and CalcOrientation(center, invader.pathing_from:GetPos())
	invader.pathing_to = MapFindNearest(invader,true,my_nest_id, function(obj, from)
		if obj == from or not obj:IsCloserToPlayer(from) then return end
		if from_bearing and abs(AngleDiff(from_bearing, CalcOrientation(center, obj:GetPos()))) > 60*60 then return end
		return true
	end,invader.pathing_from)
	invader:UpdateAttachedUI()
end

function InvaderBehaviourSupport:OnExpire(invader)
	Bkob_Log_NA("Expire support behavior!")
	rawset(invader, 'pathing', nil)
	rawset(invader, 'path_until', nil)
	rawset(invader, 'supporting', nil)
	rawset(invader, 'on_arrive', nil)
	rawset(invader, 'pathing_proximity', nil)
	rawset(invader, 'pathing_from', nil)
	rawset(invader, 'pathing_to', nil)
	invader:UpdateAttachedUI()
	return InvaderBehaviourBase.OnExpire(self, invader)
end

--[[
@class InvaderBehaviourPassiveMove
Enables non-aggressive movement to the closest object of a certain class
--]]
DefineClass.InvaderBehaviourPassiveMove = {
	__parents = { "InvaderBehaviourBase", },
	properties = {
		{ id = "target_class", name = "Target Class", help = "Class of the target to move to. If empty, the unit will move to a random point.", editor = "choice", default = "TerritorialNest", items = function(self) return GetSpawnClasses() end, },
		{ id = 'complex_targeting', name = 'Use more complex targeting logic?', help = 'Instead of just picking the closest target, use a more complex logic to pick the target. Currently this is only used for picking the closest target that is also closer to the player than the unit itself.', editor = 'bool', default = false},
		{ id = 'targeting_function', name = 'Find_Point_to_move_to', help = 'Function to find the point to move to.', editor = "expression",
			default = function(self, invader, progress) return Get_center_of_survivors() end, params = "self, invader, progress",
			no_edit = function(self) return not self.complex_targeting end},
		{ id = "on_arrival", name = "OnArrive", help = "Function this unit performs once it arrives at the target.", editor = "expression", default = function(invader, target, progress) return true end, params = "invader, target, progress", },
		{ id = "proximity", name = "Stop if this close", help = "When the unit is this many meters close to the target, trigger the on_arrival function and interrupt behavior.", editor = "number", default = 50000, scale = "m", min = 5000, },
	},
	EditorName = "Passive walk to closest target",
}

function InvaderBehaviourPassiveMove:OnAssign(invader, end_time)
	InvaderBehaviourBase.OnAssign(self, invader, end_time)
	invader.pathing = true
	invader.path_until = end_time
	invader.on_arrive = self.on_arrival
	invader.pathing_proximity = self.proximity
	if self.complex_targeting then
		--print("Having to calculate complex place to move too!")
		local target = self.targeting_function(self, invader, EventProgress)
		--print(target)
		--print(target.class)
		invader.pathing_to = target
	else
		invader.pathing_to = MapFindNearest('map',invader,true,self.target_class)
	end
	invader:UpdateAttachedUI()
end

function InvaderBehaviourPassiveMove:OnExpire(invader)
	rawset(invader, 'pathing', nil)
	rawset(invader, 'path_until', nil)
	rawset(invader, 'on_arrive', nil)
	rawset(invader, 'pathing_proximity', nil)
	rawset(invader, 'pathing_to', nil)
	return InvaderBehaviourBase.OnExpire(self, invader)
end

--test
function EnhancedTerritorialNest:new_behavior_qa()
	--print("Testing new behaviors!")
	local spawn_def
	spawn_def = SpawnDefs['passive_move']
    local instance = {}
    instance.nest = self
    spawn_def = spawn_def:CreateInstance(instance)
	--print("Triggering spawndef!")
	local t = spawn_def:ResolveTarget()
    spawn_def:ActivateSpawn(t,{},100)
end

function UnitInvader:FindNextScoutingPoint()
	local valid_point = false
	print("Trying to find a spot in quadrant,")
	local box = Get_box_from_quadrant(self.target_quadrant)
	local retry = 10
	local range = self.pathing_proximity or (15 * guim)
	while (retry > 0 and not valid_point) do
		valid_point = self:FindValidScoutingPoint(box, self.scouted_pos, range)
		retry = retry -1
		range = range + 5*guim
	end
	if valid_point then
		return valid_point
	else
		ForceActivateStoryBit('unable_to_scout',self,true)
		self.pathing = false
		return
	end
end

function UnitInvader:FindValidScoutingPoint(box_area, scouted_points, min_dist)
	-- early validation identical to previous implementation
	if not box_area or min_dist <= 0 then
		return false
	end
	local w = box_area:maxx() - box_area:minx()
	local h = box_area:maxy() - box_area:miny()
	if w < min_dist * 2 and h < min_dist * 2 then
		return false
	end

	scouted_points = scouted_points or {}
	local min_sq = min_dist * min_dist

	local my_pfclass = self:GetPfClass()
	-- origin for connectivity: try to find a passable tile near the centre.
	local my_pos = terrain.FindPassable(self, my_pfclass)

	local function filter(x, y)
		for _, pt in ipairs(scouted_points) do
			local dx = x - pt:x()
			local dy = y - pt:y()
			if dx * dx + dy * dy < min_sq then
				return false
			end
		end
		if box_area:Dist2D(point(x,y)) > 0 then
			return false
		end
		return true
	end

	-- use ConnectivityRandomTile instead of manual loop. the function will
	-- perform its own randomised attempts and respects connectivity; the final
	-- argument is our filter defined above.
	local seed = AsyncRand()
	local retries = 4096
	-- ConnectivityRandomTile(seed, origin, center, max_dist, min_dist, Human.pfclass, 4096, filter_far_from_nest)
	local pos = ConnectivityRandomTile(seed, my_pos, my_pos, max_int, 0, my_pfclass, retries, filter)
	--Get_box_from_quadrant(12):Dist2D(point(906300,17715500))
	if not pos then
		return false
	end
	print(box_area:Dist2D(pos))
	return pos
end


function UnitInvader:Get_quadrant_to_scout()
	local my_quad = Get_quadrant_from_obj(self)
	local my_nesting_species = self:Get_Nesting_Species()
	if not my_nesting_species then return my_quad end
	local nest_logs = G_nest_scout_logs[my_nesting_species].quadrants or {}
	-- Try to scout where I am
	if not nest_logs[my_quad] or (GameTime() - nest_logs[my_quad]) < year_duration * 2 then
		return Collapse_quad(my_quad)
	else
		local retry = 2
		local tried_quads = {}
		tried_quads[Collapse_quad(my_quad)] = true
		while retry > 0 do
			for quad in ipairs(table.keys(tried_quads)) do
				local adjacent = Get_adjacent_quads(Uncollapse_quad(quad))
				for _,quad in ipairs(adjacent) do
					if not nest_logs[quad] or (GameTime() - nest_logs[quad]) < year_duration * 2 then
						return Collapse_quad(quad)
					else
						tried_quads[quad] = true
					end
				end
				retry = retry - 1
			end
		end
	end
end

function UnitInvader:CheckForNewBehaviors()
	if self.pathing or self.pathing_to or self.scouting or self.wallbreaking then
		return true
	end
	return false
end

--FindObstructionTarget for future wall breaker behavior
function UnitInvader:InvaderIdle()
	self.idling = true
	if self:IsTimeToDespawn() and self:CanDespawn() then
		self:SetCommand("CmdDespawn")
		return
	end
	local something_new = self:CheckForNewBehaviors()
	local forced_until = self.forced_aggression_until
	if something_new then
		-- pass to make sure we don't force fail due to the below checks
	elseif not forced_until or self:TryFailForceAggression() then
		return
	end
	Bkob_Log_NA("Checking what we as an invader should do!")
	if something_new then
		print("Pathing too:")
		print(self.pathing_to)
		print("And I need to be this close:")
		print(self.pathing_proximity)
		print("And I am this far away: ")
		print(self:GetDist2D(self.pathing_to))
		local close_enough = self:IsCloser(self.pathing_to, self.pathing_proximity)
		if self.scouting and close_enough then
				print("Unit is scouting and is close enough to their curtrent point. Recording surroundings and rolling a enw point!")
				self:near_scout_point()
				-- we will have a new pathing_to prop from the above function
				self:SetCommand("CmdPassiveMove")
		elseif self.pathing then
			print('Unit is trying to get to a specific point!')
			if close_enough then
				print("And they are close enough!")
				--print("Invader Idle call detecting we are too close to the target!")
				self.pathing = false
				print("Arrived at passive move target!")
				if self.on_arrive then
					local EP = EventProgress
					self.on_arrive(self, self.pathing_to, EP)
				end
				self.pathing = nil
				self.pathing_to = nil
				self:UpdateAttachedUI()
			end
			Bkob_Log_NA("Telling unit to start (passively) moving to a target!")
			self:SetCommand("CmdPassiveMove")
		end
	elseif GameTime() >= forced_until then
		Bkob_Log_NA("Stop attacking!")
		self:ClearForcedAttack()
	elseif self.forced_aggression_roam then
		Bkob_Log_NA("Agrily roaming!")
		self.forced_aggression_roam = nil
		self:Roam()
		return true
	elseif self:IsAttackSearchActive() then
		local new_target = self:MarkForcedTarget()
		if new_target and not self:IsAttackTargetIgnored(new_target) then
			local range = self:GetMaxAttackRange()
			if pf.GetLinearDist(self, new_target) > range then
				self.roam_start_pos = false
				self:SetCommand("CmdForcedApproach", new_target, range)
			else
				self:TryAttackTargetReason("InvaderIdle", new_target)
			end
		end
		local scheduled_time = self.forced_aggression_roam_scheduled
		if not scheduled_time or scheduled_time > self.roam_at_time then
			-- move to a new position if no attack target is found
			self:RoamSchedule(0, 3333)
			self.forced_aggression_roam_scheduled = self.roam_at_time
		end
	end
end

function UnitInvader:CmdPassiveMove()
	print("Got told to move passively!")
	if not self.pathing_to then
		print("No idea what we are trying to move too!")
		self.pathing = false
		return -- no target found
	end
	local closests_exact_pos
	if IsValid(self.pathing_to) then
		closests_exact_pos = self.pathing_to:GetPos()
	else
		closests_exact_pos = self.pathing_to
	end
	-- prefer a tile that respects this unit's pfclass and collision
	local closest_to_dest = terrain.FindPassableTile(closests_exact_pos, const.tfpPassClass, self)
	if not ConnectivityCheck(self, closest_to_dest) then
		print("We cannot reach this class....")
		return
	end
	print("Telling myself to GoTo this position:", closest_to_dest)
	if self:IsCloser(self.pathing_to, self.pathing_proximity) then
		--print("I am close enough to trigger my on arrive!")
		if self.on_arrive then
			local EP = EventProgress
			--print("And I do have a function of it! Triggering it")
			self.on_arrive(self, self.pathing_to, EP)
		end
		-- This will stop an infinite loop if the movement behavior is still waiting to timeout
		self.pathing = false
	else
		self:Goto(closest_to_dest)
	end
end

--[[
@class InvaderBehaviourNestScout
Enables a non-aggressive movement to another more complicated location
00]]
DefineClass.InvaderBehaviourNestScout = {
	__parents = { "InvaderBehaviourBase", },
	properties = {
		{ id = "map_hack", name = "Give scout map hacks?", help = "The scout will always learn of all classes it is looking for in the 4% of the map it is exploring", editor = "bool", default = false},
		{ id = "log_classes", name = "What class should the unit record?", help = "What is this unit looking for?", editor = "string_list", items = function (self) return GetSpawnClasses() end, default = false},
		{ id = 'distance_points', name = 'Distance between scouting points (in guim)', help = 'Quadrants are approximately 200m x 200m', editor = 'number', default = 25, scale = 'm'},
		{ id = "attack_hostile", name = "Is the scout hostile?", help = "Will this unit fight anyone while it is roaming?", editor = "bool", default = false, no_edit = function(self) return self.attack_hostile end},
		{ id = "ForcedGroups", name = "Combat Groups", help = "Define specific combat groups as priority targets. If empty, all groups from the specified combat classes will be targeted. If no classes are specified too, the unit will be aggressive towards everything, but its own.", editor = "set", default = set( "Humans" ), items = function (self) return CombatGroupsSetItems() end, no_edit = function(self) return self.attack_hostile end},
		{ id = "SearchLabels", name = "Search Labels", help = "Define a label where to search for the targets. If missing, the search will be limited to a radius around.", editor = "string_list", default = {"Survivors"}, item_default = "", items = function (self) return BuildingLabelComboItems() end, no_edit = function(self) return self.attack_hostile end},
		{ id = "SearchRadius", name = "Search Radius", help = "Search range for the targets if no search label is defined. Leave 0 to use the invader's default.", editor = "number", default = 200000, scale = "m", no_edit = function(self) return self.attack_hostile end},
		{ id = "ForcedClasses", name = "Target Classes", help = "Define specific combat classes as priority targets. If empty, all classes with the specified combat groups will be targeted. If no groups are specified too, the unit will be aggressive towards everything, but its own..", editor = "string_list", default = {}, item_default = "", items = function (self) return ClassDescendantsList("AttackableObject") end, no_edit = function(self) return self.attack_hostile end},
		{ id = "KeepFormation", name = "Keep Group Formation", help = "I true, the invaders will approach keeping close to each other.", editor = "bool", default = true, no_edit = function(self) return self.attack_hostile end},
	},
	EditorName = "Scout around the map (based on species logs)",
	Documentation = [[The <style GedHighlight>Scouting behavior</style> is to be used by nests when trying to find the player's stuff or another species territorial nest.
Scouts will always log anything owned by the player (Buildings, Survivors, Robots, etc...), but can also log any other spawn class if specified.
Scouting code splits the map into 200m x 200m quadrants, and the unit will pick the closest quadrant that has not been scouted in the last year by its species to explore.
Scouting behavior:
<style GedHighlight>Step 1: </style>Get inside quadrant.
<style GedHighlight>Step 2: </style>Pick random spot X meters away (Set by distance_points) from current position and from all prior scouted positions.
<style GedHighlight>Step 3: </style> When within 5 meters from spot, record all observed objects owned by the player or matching the log_classes list.
<style GedHighlight>Step 4: </style> Repeat until no spot can be found that is x meters away from all prior scouted points, or until scouting time runs out.

Note 1: that in order for a species to actually learn of other species, this behavior should be followed with a "return to nest" behavior.
Note 2: If <style GedHighlight>map_hack</style> is enabled, the scout will auto record all player owned objects and matching classes in the quadrant. But will still move around the quadrant.]]

}

--self:SetCommand("CmdForcedApproach", new_target, range)

function InvaderBehaviourNestScout:OnAssign(invader, end_time)
	if self.attack_hostile then
		invader:ForceAggressionStart(self.ForcedGroups, self.ForcedClasses, end_time, self.SearchLabels, self.SearchRadius, self.KeepFormation)
	end
	-- Initialize scouting state
	invader.scouting = true
	invader.observed_objects = {}
	invader.scouted_pos = {}
	if not invader.from_nest or not invader.from_nest.quadrant_scouting then
		invader.target_quadrant = invader:Get_quadrant_to_scout()
	else
		invader.target_quadrant = invader.from_nest.quadrant_scouting
	end
	invader.pathing = true
	invader.pathing_to = invader:FindNextScoutingPoint(invader.target_quadrant,invader.scouted_pos)
	--invader.min_scout_distance = self.distance_points * guim
	invader.looking_for = self.log_classes
	invader.map_hack = self.map_hack
	invader.player_found = false
	invader.pathing_proximity = 5000
	-- grant a buff to all scouts, making them able to see past 30 meters
	if invader:GetDetectionRange() < 30 * guim then
		if IsKindOf(invader,'Robot') then
			invader:AddRobotCondition('scouting_sight_buff_robot','mod')
		else
			invader:AddHealthCondition('scouting_sight_buff_animal','mod')
		end
	end
	if self.map_hack then
		invader.observed_objects = Get_objs_in_quad(invader.target_quadrant, self.log_classes)
	end
	invader:UpdateAttachedUI()
end

function InvaderBehaviourNestScout:OnExpire(invader)
	rawset(invader, 'scouting', nil)
	rawset(invader, 'observed_objects', nil)
	rawset(invader, 'scouted_pos', nil)
	rawset(invader, 'target_quadrant', nil)
	rawset(invader, 'pathing_to', nil)
	--rawset(invader, 'min_scout_distance', nil)
	rawset(invader, 'looking_for', nil)
	rawset(invader, 'map_hack', nil)
	if IsKindOf(invader,'Robot') then
		invader:RemoveRobotCondition('scouting_sight_buff_animal')
	else
		invader:RemoveHealthCondition('scouting_sight_buff_animal')
	end
	invader:UpdateAttachedUI()
	return InvaderBehaviourBase.OnExpire(self, invader)
end

local detect_enum_flags = const.efVisible | const.efUnit | const.efAttackable
local detect_game_flags = const.gofDamageable | const.gofSyncObject

local function Scout_Detect(unit, self, detected_units)
	--DbgAddSegment(unit, self, RandColor(self.handle))
	if self == unit
	or not unit.detect_spot
	or not self:IsDetectionTarget(unit)
	or not self:CanDetect(unit) then
		return
	end
	for _, v in ipairs(self.looking_for) do
		if IsKindOf(unit,v) then
			print("I detected this, a thing I'm looking for: "..unit.class)
			table.insert_unique(self.observed_objects, unit)
		end
	end
	if unit.player then
		print("I detected something owned by the player!")
		self.player_found = true
	end
end

function UnitDetection:detect_nearby()
	local units = self.detected_units
	if not self.detect_spot or not self:IsDetectionEnabled() then
		if units then
			self:ClearDetectionCache()
		end
		return
	end
	local seed = self:RandSeed("DetectUnits")
	if not units then
		units = {}
		self.detected_units = units
	end
	local range = self:GetDetectionRange()
	self:GetMaxCollisionRadius(range + MaxLosTargetRadius) -- cache information about the surrounding, boosting the surf enum effectiveness
	self.los_checks = self.los_max_checks -- Limit the maximum allowed LOS checks. The enum is randomized, so we should eventually check all units.
	local collection_idx = self:GetDetectCollectionIdx()
	MapForEach(self, range, "!collection", collection_idx, "shuffle", seed, "UnitDetection", detect_enum_flags, nil, detect_game_flags, Scout_Detect, self, units)
	self.los_checks = nil
	local count = #units
	for i=count,1,-1 do
		local unit = units[i]
		if time ~= units[unit] then
			self:UnitExitDetection(unit)
			units[i] = units[count]
			units[count] = nil
			units[unit] = nil
			count = count - 1
		end
	end
end

function UnitInvader:Get_New_Scout_Point()
	local new_three = self.pathing_to
	local new_two = self.scouted_pos[3]
	local new_one = self.scouted_pos[2]
	self.scouted_pos = {}
	self.scouted_pos[1] = new_one
	self.scouted_pos[2] = new_two
	self.scouted_pos[3] = new_three
	self.pathing_to = self:FindNextScoutingPoint(self.target_quadrant,self.scouted_pos)
	if self.pathing_to then
		print("Pathing to new point!")
	end
end

function UnitInvader:near_scout_point()
	print("Recording things around me!")
	self:Get_New_Scout_Point()
	if not self.map_hack then
		self:detect_nearby()
	end
end

function TFormat.ScoutFailed(context_obj)
	local map_name = GetMapName()
	local quadrant = 5 --context_obj.target_quadrant
	local unit = context_obj.actor.class or 'Unknown'
	return Untranslated('<em>Map Name:  '..map_name..'\nQuadrant:  '..quadrant..'\nUnit:  '..unit..'</em>')
end
