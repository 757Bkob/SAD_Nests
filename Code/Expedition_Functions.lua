function All_skills_up(colonist)
	colonist = colonist or GetValidSurvivorsOnMap()[1]
	--("Colonist: ",colonist.id)
	local do_not_up = {}
	for id in pairs(Skills) do
		--('1: ',id)
		--("Looing at skill: ",id)
		--('inclination: ',colonist:GetSkillInclination(id).id)
		--('skill level: ',colonist:GetSkillLevel(id))
		if colonist:GetSkillInclination(id).id ~= 'indifferent' and colonist:GetSkillLevel(id) < 10 then
			--("Colonist is not indifferent and below level 10")
			colonist:SetSkillLevel(id,colonist:GetSkillLevel(id)+1,'silent')
		end
	end
end