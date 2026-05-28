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

function IsPosFree(x, y)
	return not occupied[EncodeVoxelPos(x, y)] 
		and not occupied[EncodeVoxelPos(x + dx, y + dy)]
		and GetPassType(x, y) == 0
end


function UnitExpedition:TraumaBond()
	Bkob_Log_FE("Starting to spawn a unit around a colonist!")
    local spawn_def = SpawnDefs['spawn_nearby']
	local map = Region.id
	local animals = {}
	-- make it so off map animals are more likely
	if map == 'Saltu' then
		animals[#animals+1] = {id='Shrieker_T4',weight='100' }
		animals[#animals+1] = {id='Ulfen_T4',weight='100' }
		animals[#animals+1] = {id='Draka_T4',weight='100' }
		animals[#animals+1] = {id='Gujo_T4',weight='50' }

		animals[#animals+1] = {id='Noth_T4',weight='50' }
		animals[#animals+1] = {id='Scissorhands_T4',weight='50' }
		animals[#animals+1] = {id='Shogu_T4',weight='50' }
	end
	local def = class and g_Classes[class]
	local instance = {}
	instance.SpawnClass = class
	instance.location = self
	if name then
		instance.name = name
	end
	if who and IsKindOf(def,'UnitAnimal') then
		instance.PostSpawn = function(self,obj,target,context)
				if not obj.Tameable then
					Bkob_Log_FE("Animal can't be tamed")
					return
				end
				obj:CheatResearch()
				obj:Tame()
				Msg("AnimalTamed", nil, obj, true)
				if instance.name then
					obj.DisplayName = instance.name
				end
			end
	end
	-- one of two spawns
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t,{},100)
	-- Let's go again!
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t,{},100)
	local animal = MapGetNearest
	self:BondWithAnimal(animal, 'Found and bonded on a journey home')
end

function UnitAnimal:ForceSetGender(male_flag)
	local reproduction = self.ReproductionType
	if reproduction == "two sexes" then
		if male_flag then
			self.Gender = "male"
		else
			self.Gender = "female"
		end
	end
end

function UnitExpedition:EjectAndStrand(unit,damage)
    -- detach from balloon if still attached and remove from passenger list
	unit = unit or self
	damage = damage or 75
	local balloon_base
	if unit.in_balloon then
        local balloon = unit.in_balloon
		balloon_base = unit.in_balloon.landing_pad

		-- Remove unit from expedition
	    unit:LeaveBalloon(balloon)
		unit:SetVisible(false)
		-- because this colonist will be gone for multiple days
		unit:CheatToggleGodMode()
		unit:ChangeEnergy(unit.MaxEnergyAvailable)

		-- damage landing pad
		local max = pad.MaxHealth
		local net_loss = MulDivRound(max*percentage,1,100)
		unit:DamageLandingPad(damage)
		local net_loss = MulDivRound(max*percentage,1,100)
    	balloon_base:ChangeHealth(-net_loss, "balloon_damage")
	else
		balloon_base = MapGetFirst(true,"HotairBalloon")
	end
	CreateGameTimeThread(function(balloon_base,unit)
		Sleep(const.Scale.h)
		local edge_quads = {1,2,3,4,5,6,10,11,15,16,20,21,25}
		local pfclass = unit.pfclass
		local closest, closest_dist
		for _,quad in ipairs(edge_quads) do
			local box = Get_box_from_quadrant(quad)
			local dist = box:Dist2D(balloon_base)
			if not closest_dist or dist < closest_dist then
				closest = quad
				closest_dist = dist
			end
		end
		local target_dist_min = closest_dist
		--local box = Get_box_from_quadrant(closest)
		local target_dist_max = max_int
		local connectivity_target = terrain.FindPassable(balloon_base, pfclass, target_dist_max)
		local rand = InteractionRandCreate("BalloonEject")
		local seed = rand()
		local rand_retries = 4096
		local nests = MapGet("map", "TerritorialNest")
		local function filter_far_from_nest(x, y)
			-- check for distance to shrieker nests
			for _, nest in ipairs(nests or empty_table) do
				if nest:IsCloser2D(x, y, nest.territorial_range) then
					return false
				end
			end
			return true
		end
		local dest = ConnectivityRandomTile(seed, connectivity_target, balloon_base, target_dist_max, target_dist_min, pfclass, rand_retries, filter_far_from_nest)
		unit:FallAt(dest)
		unit.unit_stranded = true
		unit:ClearPath()
		unit:SetVisible(true)
		unit:SetOpacity(100)
		local give_traits = {}
		give_traits[#give_traits+1]='NA_balloon_ejected_1' -- horse with no name
		give_traits[#give_traits+1]='NA_balloon_ejected_2' -- starvation
		give_traits[#give_traits+1]='NA_balloon_ejected_3' -- was a boy scout in a past life
		give_traits[#give_traits+1]='NA_balloon_ejected_3' -- trauma bonded
		local give_trait = give_traits[AsyncRand(#give_traits)]
		unit:SetTrait(give_trait,true,false)
		unit:CheatToggleGodMode()
		ObjModified(unit)
		ForceActivateStoryBit('NA_ExpeditionStranded',unit)
	end,balloon_base,unit)
end

function UnitExpedition:DamageLandingPad(percentage)
	local balloon = self.in_balloon
    if not percentage or percentage == 0 then return end
    local pad = balloon.landing_pad
    if not IsValid(pad) then return end
	local max = pad.MaxHealth
	local net_loss = MulDivRound(max*percentage,1,100)
    pad:ChangeHealth(-net_loss, "balloon_damage")
    ObjModified(pad)
end


function PlaceRandomExplorationSites(survivor)
	local travel_time = 4
	local valid = {}
	ForEachPreset("ExpeditionPreset", function(preset, group, valid)
		if preset.FoundByExploration and CheckExpeditionSpawnPrerequisites(preset) then
			valid[#valid + 1] = preset
		end
	end, valid)
	local chosen = survivor:TableWeightedRand(valid, "FoundByExplorationWeight", "SpawnExplorationSite")
	if chosen then
		local site = PlaceExpeditionSiteByTravelTime(chosen.id, travel_time)
	end
end