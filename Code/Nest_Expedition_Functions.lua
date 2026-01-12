function get_species()
	local presets = Presets.UnitSpeciesGroup.Default
	local to_return = {}
	for _,v in ipairs(presets) do
		if v.id and v.primary_combat_group then
			table.insert_unique(to_return,v.id)
		end
	end
	return to_return
end

DefineClass.GiveExpeditionSpeciesEffectToSurvivor = {
	__parents = { "Effect", },
	__generated_by_class = "EffectDef",

	properties = {
		{ id = "species", name = "species", help = "What species is affected", editor = "choice", default = false, items = function (self) return get_species() end, },
		{ id = "effect", name = "effect", help = "If species is getting more or less aggressive", editor = "choice", default = 'aggression up', items = {"aggression up","aggression down"}},
	},
	EditorView = Untranslated("<species> will have it's <effect>"),
	Documentation = "Colony effects a species",
	EditorNestedObjCategory = "Preset",
}

function GiveExpeditionSpeciesEffectToSurvivor:__exec(obj, context)
	if self.effect == 'aggression up' then
		Aggression_up(self.species)
	elseif self.effect == 'aggression down' then
		Aggression_down(self.species)
	end
end

function GiveExpeditionSpeciesEffectToSurvivor:GetError()
	if not self.effect then
		return "Select an effect the species will do"
	end
end



--local old_init = UnitAnimal.Init

function set_scissorhand_burned()
	local animals = ClassDescendantsList('UnitAnimal')
	for _,v in animals do
		local def = g_Classes[v]
		if def.SpeciesGroup == 'species_scissorhand' then
			table.insert_unique(def.AnimalPerks, "scissorhand_burned")
		end
	end
	MapForEach(true,"UnitAnimal",function(unit)
		if unit.SpeciesGroup == 'species_scissorhand' then
			local new_max = DivRound(unit.MaxHealth*12,10)
			unit.MaxHealth = new_max
			unit.Health = new_max
		end
	end)
end

function set_scissorhand_eaten()
	local animals = ClassDescendantsList('UnitAnimal')
	for _,v in animals do
		local def = g_Classes[v]
		if def.SpeciesGroup == 'species_scissorhand' then
			table.insert_unique(def.AnimalPerks, "scissorhand_full")
		end
	end
	MapForEach(true,"UnitAnimal",function(unit)
		if unit.SpeciesGroup == 'species_scissorhand' then
			local new_max = DivRound(unit.MaxHealth*8,10)
			if self.Health > new_max then
				unit.Health = new_max
			end
			unit.MaxHealth = new_max
		end
	end)
end

--[[
function UnitAnimal:Init()
	old_init()
	if UnitAnimal.SpeciesGroup == 'species_scissorhand' and g_Classes[UnitAnimal.id].MaxHealth == UnitAnimal.MaxHealththen then
		if MapVarValues["Scissorhands_burned"] then
			local new_max = DivRound(unit.MaxHealth*8,10)
			if self.Health > new_max then
				self.Health = new_max
			end
			self.MaxHealth = new_max
		elseif MapVarValues["Scissorhands_full"] then
			local new_max = DivRound(unit.MaxHealth*12,10)
			self.MaxHealth = new_max
			self.Health = new_max
		end
	end
end
--]]