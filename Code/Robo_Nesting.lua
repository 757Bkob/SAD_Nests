DefineClass.RoboNesting = {
	properties = {
		{ category = "Nest", id = "CanBeNestGuardian", name = "Can Be Nest Guardian",  editor = "choice", default = false, items = {true, false, "always"}, template = true },
		{ category = "Nest", id = "CanBurrowInNest",   name = "Can Burrow In Nest",    editor = "bool", default = false, template = true },
		{ category = "Nest", id = "NestEffect",        name = "Nest Proximity Effect", editor = "preset_id", default = "FamiliarGroundRobo", preset_class = "RobotConditionComponent ", template = true },
	},
	nest = false,
	is_guardian = false,
	nest_nearby = false,
}
--[[
function __RobotNestExtension()
	Robot.nest_nearby = false
	Robot.is_guardian = false
	Robot.nest = false
	Robot.NestEffect = 
end
]]--

function RoboNesting:OnCombatDisengage()
	-- force the member to go back close to its roaming spot
	if self.nest then
		self:TrySetCommand("Roam")
	end
end

function RoboNesting:OnAttackReceived(attacker)
	local nest = attacker and self.nest
	if not IsValid(nest) then
		return
	end
	nest:RegisterTarget(attacker)
	nest:UpdateEngagementRange(attacker) -- temporary increase engagement range if necessary
end

function RoboNesting:EmitDistressCall(attacker, units_to_enrage, delayed)
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	local RESPONSE_DISTRESS = const.DelayedResponseDistress
	for _, member in ipairs(nest.nest_members) do
		if member ~= self and not member.is_guardian
		and member.can_attack and member:IsAggressive()
		and member:ShouldRespondToDistressCall(self, attacker) then
			member:SetDelayedResponce(RESPONSE_DISTRESS, attacker)
		end
	end
end

function RoboNesting:GameInit()
	if IsValid(self.nest) then
		self.roam_start_pos = self.nest:GetPos()
	end
end

function RoboNesting:OnDie()
	self:SetNest(false)
end

function RoboNesting:CanDetect(target)
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	local targets = nest.nest_targets
	if targets and targets[target] then
		return true
	end
	return nest:IsCloser(target, nest.territorial_range)
end

function RoboNesting:OnObjUpdate()
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	local effect = self.NestEffect or ""
	if effect == "" then
		return
	end
	local nest_nearby = self:IsCloser(nest, nest.territorial_range) or false
	if nest_nearby == self.nest_nearby then
		return
	end
	self.nest_nearby = nest_nearby
	if nest_nearby then
		self:AddRobotCondition(effect, "nest")
	else
		self:RemoveRobotCondition(effect, "nest")
	end
end

function RoboNesting:UnitEnterDetection(unit)
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	for _, member in ipairs(nest.nest_members) do
		if member ~= self then
			member:MarkAsDetected(unit)
		end
	end
	if AttackTargetFilter(unit, self) then
		return nest:RegisterTarget(unit)
	end
end

function RoboNesting:GetAttackStartingPoint()
	local nest = self.nest
	if not IsValidPos(nest) then
		return
	end
	return nest:GetPos()
end

function RoboNesting:GetCombatEngagementRange()
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	return nest:GetCombatEngagementRange()
end

function RoboNesting:GetRoamingStartPos()
	local nest = self.nest
	if not IsValidPos(nest) then
		return
	end
	return nest:GetPos():SetInvalidZ()
end

function RoboNesting:GetRoamRadius()
	local nest = self.nest
	if not IsValid(nest) then
		return
	end
	if self.is_guardian then
		return nest.guard_range
	else
		return Max(nest.guard_range, nest:GetAttackRange() / 3)
	end
end

function RoboNesting:Done()
	self:SetNest(false)
end

function RoboNesting:LeaveHerd()
	self:SetNest(false)
end

function RoboNesting:SetNest(nest)
	nest = nest or false
	if nest == self.nest then return end
	local old_nest = self.nest
	if IsValid(old_nest) then
		old_nest:RemoveNestMember(self)
	end
	self.nest = nest or nil
	if IsValid(nest) then
		nest:AddNestMember(self)
	end
end

function RoboNesting:SetNestGuardian(guardian)
	if self.is_guardian == guardian then return end
	self.is_guardian = guardian
	if guardian then
		self.nest:AddNestGuardian(self)
	else
		self.nest:RemoveNestGuardian(self)
	end
end

function RoboNesting:RandomWaitAttackTarget(target)
	Sleep(self:Random(1000, "RandomWaitAttackTarget"))
	if self.can_attack and self:IsAggressive() and IsValid(target) and AttackTargetFilter(target, self) then
		return self:WaitAttackTarget(target)
	end
end

AppendClass.Robot = {
	__parents = { "RoboNesting" },
}

--OnMsg.ClassesBuild() __RobotNestExtension() end