function Get_unit_species_preset()
	local to_return = {}
	local entries = #Presets.UnitSpeciesGroup.Default
	for i = 1, entries do
		local species = Presets.UnitSpeciesGroup.Default[i]
		if species.primary_combat_group then
			table.insert_unique(to_return, species.id)
		end
	end
	return to_return
end

DefineClass.NestingSpeciesPreset = {
	__parents = { "ListPreset", },
	properties = {
		{ category = "Species",	id = "unit_species",	name = "Related Unit Species", editor = "choice", default = false, items = function() return Get_unit_species_preset() end, help = "What species group this nesting species this belongs too", },
		{ category = "Species", id = "spawner_storybit", name = "Nest Spawn Storybit", editor = "preset_id", default = false, preset_class = "StoryBit", help = "What storybit to trigger when a new nest of this should be spawned.",},
		{ category = "Species", id = "nest_class", name = "Nest Class", editor = "choice", default = false, items = function() return ClassDescendantsList('TerritorialNest') end , help = "What nest is related to this species.",},
		{ category = "Species",	id = "resource_list",	name = "Aggression resources", editor = "nested_list", default = false, base_class = "ResAmount", template = true, help = "Amount of a specific resource to trigger an aggression event.", },
		{ category = "Species",	id = "spore_buildings",	name = "Spore Buildings", editor = "choice", default = false, items = function() return ClassDescendantsList('NestSpore') end, template = true, help = "The spore buildings this species stores resources in.", },
		{ category = "Species",	id = "aggressive",	name = "Naturally Aggressive?", editor = "bool", default = true, template = true, help = "Will this species attack unprovoked?", },
		{ category = "Species",	id = "spawnable",	name = "Nests spawning allowed from start?", editor = "bool", default = true, template = true, help = "Can nests of this species spawn from start of game?", },
		{ category = "Prefab", id = "PrefabTags",   name = "Prefab Tags Any",        editor = "set",         default = empty_table, items = function() return PrefabTagsCombo() end, three_state = true },
	},
}

DefineModItemPreset("NestingSpeciesPreset", { EditorName = "Nesting Species", EditorSubmenu = "Animals" })

local NA_res_table = {}

function Build_species_pivot_table()
	NA_res_table = {}
	local entries = #Presets.NestingSpeciesPreset.Default
	for i=1, entries do
		local species = Presets.NestingSpeciesPreset.Default[i]
		if species and species.unit_species and species.resource_list then
			for _,res_item in ipairs(species.resource_list) do
				local res_name = res_item.resource
				local chance = res_item.amount
				if not NA_res_table[res_name] then
					NA_res_table[res_name] = {}
				end
				NA_res_table[res_name][#NA_res_table[res_name]+1] = {species=species.id,chance=chance}
			end
		end
	end
end

function print_nest_res_table()
	print(NA_res_table)
end

function get_nest_res_table()
	return NA_res_table
end

function OnMsg.ModsReloaded()
	Build_species_pivot_table()
end