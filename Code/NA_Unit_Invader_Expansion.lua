
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
	invader.pathing_to = MapFindNearest(invader,true,my_nest_id, function(obj, from) if obj ~= from and obj:IsCloserToPlayer(from) then return true end end,invader.pathing_from)
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
	local box = nil --self:Quad_to_box()
	local retry = self.pathing_proximity or (15 * guim)
	while (retry > 0 and not valid_point) do
		valid_point = self:FindValidScoutingPoint(box, self.scouted_pos, retry)
		retry = retry - (3 * guim)
	end
	return valid_point
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
			local dx = x - pt.x
			local dy = y - pt.y
			if dx * dx + dy * dy < min_sq then
				return false
			end
		end
		return true
	end

	-- use ConnectivityRandomTile instead of manual loop. the function will
	-- perform its own randomised attempts and respects connectivity; the final
	-- argument is our filter defined above.
	local seed = rand()
	local retries = 4096
	-- ConnectivityRandomTile(seed, origin, center, max_dist, min_dist, Human.pfclass, 4096, filter_far_from_nest)
	local pos = ConnectivityRandomTile(seed, my_pos, my_pos, 100000, 0, my_pfclass, retries, filter)
	if not pos then
		return false
	end
	return pos
end

--[[
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
--]]
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
		if self.pathing then
			if self:IsCloser(self.pathing_to, self.pathing_proximity) then
				--print("Invader Idle call detecting we are too close to the target!")
				self.pathing = false
				Bkob_Log_NA("Arrived at passive move target!")
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
		elseif self.scouting then
			if self.forced_aggression_until then
				Bkob_Log_NA("Aggressively scouting!")
				self:SetCommand("CmdScoutAngry")
			else
				Bkob_Log_NA("Passive scouting!")
				self:SetCommand("CmdScoutPassive")
			end
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
	Bkob_Log_NA("Got told to move passively!")
	if not self.pathing_to or not IsValid(self.pathing_to) then
		Bkob_Log_NA("No class of this type on map!")
		return -- no target found
	end
	local closests_exact_pos = self.pathing_to:GetPos()
	-- prefer a tile that respects this unit's pfclass and collision
	local closest_to_dest = terrain.FindPassableTile(closests_exact_pos, const.tfpPassClass, self)
	if not ConnectivityCheck(self, closest_to_dest) then
		Bkob_Log_NA("We cannot reach this class....")
		return
	end
	Bkob_Log_NA("Telling myself to GoTo this position:", closest_to_dest)
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
function UnitInvader:OnObjUpdate(game_time, update_interval)
	self:UpdateForcedAggression()
	-- Passive move arrival check: when `pathing` is true and a passive target was set,
	-- trigger the arrival callback when within range (runs on the main update thread).
	if self.pathing or self.scouting then
		UnitInvader:ReactToNewMovement()
	end
end
--]]

function UnitInvader:OnForcedApproachEnd(target, range)
	self:ForcedApproachStopLeading()
	self.forced_aggression_approach = nil
	self:ForcedApproachPlanning_Reset()
	self.formation_leader = nil
	self.formation_force_run = nil
end

function UnitInvader:CmdScoutAngry(target, range)
	-- wrapper command keeping the command-object structure, now looping
	local forced_until = self.forced_aggression_until
	assert(forced_until and GameTime() < forced_until)
	range = range or self:GetMaxAttackRange()
	self:OnForcedApproachStart(target, range)
	self:PrepareToMove(target, range)
	self.roam_start_pos = nil
	self.delayed_response = true
	self.forced_approach_started = true

	-- push destructor and build callback that marks loop termination
	local done = false
	local dtors = self:PushDestructor("OnForcedApproachEnd")
	local function callDestructor()
		done = true
		self:PopAndCallDestructor(dtors)
	end

	-- loop: pick a new scouting point every iteration and execute internal movement
	while not done do
		local scout_pt = self:FindNextScoutingPoint()
		if not scout_pt then
			break -- no valid point, give up
		end
		local attacked = self:CmdForcedApproach_Internal(scout_pt, range, callDestructor)
		-- if the internal logic performed an attack return value, we break out
		if attacked then
			return true
		end
		-- continue looping until destructorCallback flips done
	end
end

function UnitInvader:MiniAngryMove(target, range, destructorCallback)
	local forced_until = self.forced_aggression_until
	local status, moving, approach_target, approach_range, formation_radius, leader, keep_formation, approach_reset, group_size
	local pfSleep = self.MoveSleep
	while true do
		if not approach_target then
			local idle_anim
			while not approach_target do
				approach_target, formation_radius, leader, keep_formation, group_size = self:GetFormationApproachTarget(target)
				if not approach_target then
					approach_target, approach_range = target, range -- default approach
				elseif not keep_formation then
					approach_range = 0
					approach_reset = GameTime() + 10000 + self:Random(group_size, "ForcedApproach")
				else
					approach_range = 0
					local speed, leader_speed = self:GetSpeed(), leader:GetSpeed()
					if speed > leader_speed and not idle_anim and self:IsCloser(leader, formation_radius) and self:IsCloser(approach_target, formation_radius) then
						-- the formation leader is too slow
						if self.formation_force_run then
							self.formation_force_run = false
							self:UpdateWalkAnim()
						else
							approach_target = false
							idle_anim = self:PickIdleAnim()
							self:SetState(idle_anim)
							local idle_max = Min(self:GetAnimDuration(), 2500)
							local idle_min = Min(idle_max, 500)
							local idle_sleep = self:RandRange(idle_min, idle_max, "ForcedApproach")
							Sleep(idle_sleep)
						end
					elseif speed <= leader_speed and not self.formation_force_run and not self:IsCloser(approach_target, max_formation_radius) then
						self.formation_force_run = true
						self:UpdateWalkAnim()
					end
				end
			end
			self.forced_aggression_approach = approach_target
			self.formation_leader = keep_formation and leader
		end
		status = self:ForcedApproachStep(approach_target, approach_range)
		if not moving then
			if self:CanStartMove(status) then
				self:OnStartMoving(approach_target, approach_range)
				moving = true
			else
				if not self.forced_aggression_fail_time then
					self.forced_aggression_fail_time = GameTime()
				end
				break
			end
		end
		if status >= 0 then
			if self:OnGotoStep(status) then
				break -- interrupted
			end
			pfSleep(self, status)
			local time = GameTime()
			if forced_until and time < forced_until then
				-- update target
				local new_target = not self:TryFailForceAggression() and self:MarkForcedTarget()
				if not new_target then
					break
				end
				if new_target ~= target
				or keep_formation and self:IsCloser(approach_target, guim)
				or approach_reset and approach_reset <= time and not self:IsCloser(approach_target, 64*guim) then
					target = new_target
					approach_target = nil
					approach_reset = nil
				end
			end
		elseif not self:TryContinueMove(status, approach_target, approach_range) then
			break
		end
	end
	if moving then
		self:OnStopMoving(status)
	end
	if IsValid(target) and self.can_attack and self:IsAggressive() and target:CanBeAttacked(self) then
		local attack_flags, max_attacks = COMBAT_MAX_ATTACKS, -1
		if not self:CanDetect(target) then
			self:SetAttackTargetIgnored(target)
			local attack_target = self:FindAttackTarget(nil, target)
			if attack_target then
				target = attack_target
			else
				self:RoamReset()
				self.forced_aggression_roam = true
				max_attacks = 10 + self:Random(10, "ForcedApproach") -- retry to do something else after a few attacks
				target = self:FindObstructionTarget(nil, target)
			end
		end
		if target and self:TryAttackTargetReason("ForcedApproach", target, attack_flags, max_attacks) then
			return true
		end
	end
	self:ClearPath()
	if destructorCallback then
		destructorCallback()
	end
end


--[[
@class InvaderBehaviourPassiveMoveComplex
Enables a non-aggressive movement to another more complicated location
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
	Documentation = -[-[The <style GedHighlight>Scouting behavior</style> is to be used by nests when trying to find the player's stuff or another species territorial nest.
Scouts will always log anything owned by the player (Buildings, Survivors, Robots, etc...), but can also log any other spawn class if specified.
Scouting code splits the map into 200m x 200m quadrants, and the unit will pick the closest quadrant that has not been scouted in the last year by its species to explore.
Scouting behavior:
<style GedHighlight>Step 1: </style>Get inside quadrant.
<style GedHighlight>Step 2: </style>Pick random spot X meters away (Set by distance_points) from current position and from all prior scouted positions.
<style GedHighlight>Step 3: </style> When within 5 meters from spot, record all observed objects owned by the player or matching the log_classes list.
<style GedHighlight>Step 4: </style> Repeat until no spot can be found that is x meters away from all prior scouted points, or until scouting time runs out.

Note 1: that in order for a species to actually learn of other species, this behavior should be followed with a "return to nest" behavior.
Note 2: If <style GedHighlight>map_hack</style> is enabled, the scout will auto record all player owned objects and matching classes in the quadrant. But will still move around the quadrant.-]-]

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
	invader.target_quadrant = invader:Get_quadrant_to_scout()
	invader.pathing_to = invader:Get_random_point_in_quad(invader.target_quadrant,invader.scouted_pos)
	invader.min_scout_distance = self.distance_points * guim
	invader.looking_for = self.log_classes
	invader.map_hack = self.map_hack
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
	rawset(invader, 'min_scout_distance', nil)
	rawset(invader, 'looking_for', nil)
	rawset(invader, 'map_hack', nil)
	invader:UpdateAttachedUI()
	return InvaderBehaviourBase.OnExpire(self, invader)
end

function UnitInvader:record_surroundings()
	local observed = MapGet(self, self.min_scout_distance, self.looking_for)
	for _, obj in ipairs(observed) do
		table.insert_unique(self.observed_objects, obj)
	end
end

function UnitInvader:CmdScoutPassive()
	while true do
		local closest_to_dest = terrain.FindPassableTile(self.pathing_to, const.tfpPassClass, self)
		if self:GetDist2D(closest_to_dest) <= self.pathing_proximity then
			self:record_surroundings()
			if #self.scouted_pos >= 3 then
				local new_three = self.pathing_to
				local new_two = self.scouted_pos[3]
				local new_one = self.scouted_pos[2]
				self.scouted_pos = {}
				self.scouted_pos[1] = new_one
				self.scouted_pos[2] = new_two
				self.scouted_pos[3] = new_three
			else
				self.scouted_pos[#self.scouted_pos + 1] = self.pathing_to
			end
			self.pathing_to = false
			local retry = 5
			while retry > 0 and not self.pathing_to do
				local possible = self:FindNextScoutingPoint()
				if ConnectivityCheck(self, possible) then
					self.pathing_to = possible
					retry = -1
				else
					retry = retry - 1
				end
			end
		end
		local closest_to_new_dest = terrain.FindPassableTile(self.pathing_to, const.tfpPassClass, self)
		self:Goto(closest_to_new_dest)
	end
end
--]]
