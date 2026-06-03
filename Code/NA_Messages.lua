OnMsg.NANewNest = NA_Recalc_Closest

function NA_Recalc_Closest(nest)
	local species = nest.nest_species
end

OnMsg.ScoutingReport = NA_Scout_Recalc

function NA_Scout_Recalc(unit)
	if not unit.nest then return end
	local species = get_species_from_nest(unit.nest)
end