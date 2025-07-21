return {
PlaceObj('ModItemCode', {
	'name', "nest_class",
	'CodeFileName', "Code/nest_class.lua",
}),
PlaceObj('ModItemAnimalSpawnDef', {
	Behaviours = {
		PlaceObj('InvaderBehaviourRoam', {
			'Duration', 0,
			'RoamRadius', 15000,
			'RoamMinDist', 4500,
			'RoamMaxDist', 9000,
		}),
		PlaceObj('InvaderBehaviourAggressive', {
			'Duration', 0,
		}),
	},
	CheckConnectivity = true,
	ClearArea = 256,
	ClearRadius = 1000,
	CountMod = function (self, target, progress) return self:CalculateInvadersCountMod(self, progress) end,
	DistFromOthers = 1000,
	EnabledInTutorial = true,
	PostSpawn = function (self, obj, target)
		obj.CombatHostile = true
		Msg("SpawnedAnimalThreat", obj)
	end,
	SpawnAsGroup = true,
	SpawnClass = "Skarabei_Manhunting",
	SurvivorSpawnDistMin = 75000,
	TargetClass = "Human",
	TargetDistMax = 150000,
	TargetDistMin = 75000,
	TargetFilter = function (obj) return not obj:IsVirtual() end,
	TargetStartPosOnMissingTarget = true,
	group = "Attacks_Insects_NEW",
	id = "nest_attack",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ExecuteCode', {
			Code = function (self, obj, context)
				local context = context or {}
				if not obj then
					print("A nest did not trigger me!")
					-- context.inherited_image then -- pick closest nest to the nearest survivor
					local survivors = GetValidSurvivorsOnMap()
					local rand_surv_index = AsyncRand(#survivors)+1
					local random_surv = survivors[rand_surv_index]
					local closest_nest = MapFindNearest(SelectedObj,"map",'TerritorialNest',
					function(nest) 
							return nest.state == 'inactive' 
						end)
						context.object = closest_nest
						--print(closest_nest)
						context.inherited_image = closest_nest:GetStoryBitPopupImage() or nil
				else
					context.inherited_image = obj:GetStoryBitPopupImage() or nil
				end
			end,
			Params = "self, obj, context",
			param_bindings = false,
		}),
	},
	Category = "Attacks",
	Enabled = true,
	NotificationText = T(433873099185, --[[ModItemStoryBit inactive_too_sleepy NotificationText]] "A nest awakens!"),
	NotificationTitle = T(501042144899, --[[ModItemStoryBit inactive_too_sleepy NotificationTitle]] "A nest awakens!"),
	Prerequisites = {
		PlaceObj('CheckExpression', {
			Expression = function (self, obj)
				return 0 < MapCount("map",'TerritorialNest',
					function(nest) 
							return nest.state == 'inactive' 
						end)
			end,
			param_bindings = false,
		}),
	},
	Sets = set( "Attack" ),
	Text = T(924669975056, --[[ModItemStoryBit inactive_too_sleepy Text]] "A nest of predators has been alerted of our presence!\n\nThe air around the nest is starting to warm up, and there is a low rumbling.\nI fear the nest will now start to defend it's territory.\n\nThe Ant species (Our closest reference) of Earth behave a similar way.... attacking any other species colonies.\n\n<em>This nest will now periodically spawn attacks aimed at the colony, and the core nest building will steadily gain HP (Based on Difficulty).</em>"),
	Title = T(539239421300, --[[ModItemStoryBit inactive_too_sleepy Title]] "A nest awakens!"),
	UseObjectImage = true,
	comment = "Nest waking up",
	id = "inactive_too_sleepy",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	Category = "Attacks",
	Effects = {
		PlaceObj('ActivateSpawnDef', {
			SpawnDefId = "ShriekerNest",
			param_bindings = false,
		}),
	},
	Enabled = true,
	NotificationPriority = "Important",
	NotificationText = T(728880909304, --[[ModItemStoryBit new_nest_shrieker NotificationText]] "A meteor is landing nearby"),
	NotificationTitle = T(528830908123, --[[ModItemStoryBit new_nest_shrieker NotificationTitle]] "A meteor is landing nearby"),
	OneTime = false,
	Prerequisites = {
		PlaceObj('CheckExpression', {
			EditorViewComment = "Nest marker without a nest on it",
			Expression = function (self, obj) return MapCount(true,'ShriekerNest') < MapCount(true,'TerritorialNestMarker') end,
			param_bindings = false,
		}),
		PlaceObj('CheckRegion', {
			Negate = true,
			Region = set( "Saltu" ),
			param_bindings = false,
		}),
		PlaceObj('CheckTime', {
			TimeMin = 2,
			TimeScale = "years",
			param_bindings = false,
		}),
	},
	SelectObject = false,
	Sets = set( "Attack" ),
	SuppressTime = 20160000,
	Text = T(480862517656, --[[ModItemStoryBit new_nest_shrieker Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
	Title = T(744697671524, --[[ModItemStoryBit new_nest_shrieker Title]] "A meteor is landing nearby"),
	comment = "New Nest Spawn -- triggers via ticks or disaster",
	id = "new_nest_shrieker",
	max_reply_id = 2,
	qa_info = PlaceObj('PresetQAInfo', {
		Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
		param_bindings = false,
	}),
	save_in = "Mod/TGkJ3Tu",
	PlaceObj('StoryBitReply', {
		Text = T(534971747313, --[[ModItemStoryBit new_nest_shrieker Text]] "That's no normal meteor! It has lifesigns inside of it!"),
		param_bindings = false,
		unique_id = 2,
	}),
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ExecuteCode', {
			Code = function (self, obj, context)
				context.object = closest_nest
				context.inherited_image = closest_nest:GetStoryBitPopupImage() or nil
			end,
			Params = "self, obj, context",
			param_bindings = false,
		}),
	},
	Effects = {
		PlaceObj('ExecuteCode', {
			Code = function (self, obj)
				local spawn_def = SpawnDefs['Single']
				local isntance = {}
				instance.ResolveTarget = function(object)
					return MapFindNearest(SelectedObj,"map",'Human')
				end
				instance.Spawn = object:SpawnAround(object.adult_class,50,true,false)
				instance.SpawnClass = object.adult_class
				spawn_def:CreateInstance(instance)
			end,
			param_bindings = false,
		}),
	},
	HasPopup = false,
	NotificationAction = "select object",
	NotificationPriority = "AnimalAlert",
	NotificationRolloverTitle = T(256638224072, --[[ModItemStoryBit single_nest_attack NotificationRolloverTitle]] "A nearby nest has unleashed a small group"),
	NotificationText = T(810326088341, --[[ModItemStoryBit single_nest_attack NotificationText]] "A nest attacks!"),
	NotificationTitle = T(197638573046, --[[ModItemStoryBit single_nest_attack NotificationTitle]] "A nest attacks!"),
	comment = "Triggered by a nest",
	id = "single_nest_attack",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ExecuteCode', {
			Code = function (self, obj, context)
				if obj then
					context.inherited_image = obj:GetStoryBitPopupImage() or nil
				end
			end,
			Params = "self, obj, context",
			param_bindings = false,
		}),
	},
	NotificationRolloverText = T(170350729232, --[[ModItemStoryBit mass_nest_attack NotificationRolloverText]] "Every single nest in our vicinity are sending attackers!"),
	NotificationRolloverTitle = T(543781954128, --[[ModItemStoryBit mass_nest_attack NotificationRolloverTitle]] "All Nests are attacking!"),
	NotificationText = T(555437926578, --[[ModItemStoryBit mass_nest_attack NotificationText]] "All Nests are attacking!"),
	NotificationTitle = T(902260151361, --[[ModItemStoryBit mass_nest_attack NotificationTitle]] "All Nests are attacking!"),
	Text = T(907508396903, --[[ModItemStoryBit mass_nest_attack Text]] "Our worst fears have come to pass.\nA signal was detected originating from a nest, and every other nest has rallied to it's call!\n\nNow each nest is disgorging an aggressive brood!\n\nActivate our defenses and prepare for the fight of our life!\n\n<em>We must make sure <nests_needed()> nesting sites are cleared to disrupt this coordination!</em>"),
	Title = T(367999146600, --[[ModItemStoryBit mass_nest_attack Title]] "All Nests are attacking!"),
	comment = "Triggered by a nest",
	id = "mass_nest_attack",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemExpeditionPreset', {
	DisplayImage = "UI/Messages/Expeditions/exp_meteorite_falling",
	Expiration = 4800000,
	FoundByExploration = true,
	FoundByExplorationWeight = 30,
	Icon = "UI/Icons/Expeditions/meteorite_falling",
	Prerequisites = {
		PlaceObj('CheckExpression', {
			EditorViewComment = "one active nest",
			Expression = function (self, obj)
				return MapCount(true,'TerritorialNest', function(nest) if nest.state ~= 'inactive' then return true end end) > 0
			end,
		}),
	},
	RelevantSkills = set( "Construction" ),
	StoryBits = {
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "site_mega_nest_pillars",
			'Weight', 50,
		}),
	},
	UILineColor = 4293083197,
	description = T(219489814974, --[[ModItemExpeditionPreset gigantic_broken_nest description]] "A meteorite fell in this area."),
	display_name = T(769211153498, --[[ModItemExpeditionPreset gigantic_broken_nest display_name]] "A shooting star"),
	id = "gigantic_broken_nest",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	Category = "Exploration",
	Delay = 4000,
	Enabled = true,
	FxAction = "UINotificationExpedition",
	NotificationText = T(676096752128, --[[ModItemStoryBit site_mega_nest_pillars NotificationText]] "Expedition complete: <ExplorationSiteName>"),
	OneTime = false,
	PopupFxAction = "MessagePopup",
	ScriptDone = true,
	SelectObject = false,
	Text = T(493932761411, --[[ModItemStoryBit site_mega_nest_pillars Text]] "I found where the meteor landed, but you wouldn't believe what's here!\n\nThere was a destroyed nest in the middle of the small crater. \nIt was broken in half, like an egg.\n\nAnd are now two protruding pillars partially exposed.\nThey appear like horns from a distance.\n\nI concluded they must have been structurally integral.\nWhat's more, I can hear them vibrating!\n\nWhat should I do?"),
	Title = T(483107297188, --[[ModItemStoryBit site_mega_nest_pillars Title]] "A nest?!"),
	UseObjectImage = true,
	comment = "Expedition -- can trigger disaster early",
	group = "Expedition_FollowUP",
	id = "site_mega_nest_pillars",
	max_reply_id = 10,
	qa_info = PlaceObj('PresetQAInfo', {
		Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Vihar on 2020-Oct-14\nModified by Ivan on 2020-Dec-21\nModified by Ivan on 2021-Jan-06\nModified by Vihar on 2021-Jan-06\nModified by Gaby on 2021-Jan-07\nModified by Lina on 2021-Jan-11\nModified by Ivan on 2021-Feb-11\nModified by Bobby on 2021-May-20\nModified by Lina on 2021-Aug-19\nModified by Lina on 2021-Aug-23\nModified by Lina on 2021-Aug-24\nModified by Lina on 2021-Aug-31\nModified by Lina on 2021-Sep-02\nModified by Gaby on 2021-Sep-03\nModified by Lina on 2021-Dec-17\nModified by Lina on 2022-Jan-07\nModified by Xaerial on 2022-Oct-10",
		param_bindings = false,
	}),
	save_in = "Mod/TGkJ3Tu",
	PlaceObj('StoryBitReply', {
		Text = T(926625800729, --[[ModItemStoryBit site_mega_nest_pillars Text]] "Shoot the pillars, bring them down!"),
		param_bindings = false,
		unique_id = 10,
	}),
	PlaceObj('StoryBitOutcome', {
		Effects = {
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					CreateGameTimeThread(function()
					local delay_days = AsyncRand(3)
					local d_dur = const.DayDuration
					sleep(delay_hours * d_dur)
					ForceActivateStoryBit('begin_nest_disaster')
					return end)
				end,
				param_bindings = false,
			}),
		},
		Text = T(329248656624, --[[ModItemStoryBit site_mega_nest_pillars Text]] "All my munitions landed on target.\nBut these pillars are made of stern stuff!\n\nWorse still, the pillars are now vibrating so loud it is starting to hurt.\nI'm getting out of here before I start to go deaf!"),
		Title = T(573170111095, --[[ModItemStoryBit site_mega_nest_pillars Title]] "Pillar's are louder!"),
		param_bindings = false,
	}),
	PlaceObj('StoryBitReply', {
		Text = T(826795568152, --[[ModItemStoryBit site_mega_nest_pillars Text]] "Stop that noise, these vibrations must be signals!"),
		param_bindings = false,
		unique_id = 8,
	}),
	PlaceObj('StoryBitOutcome', {
		Effects = {
			PlaceObj('GiveExpeditionRewardToSurvivor', {
				Amount = 80000,
				Resource = "CarbonNanotubes",
				param_bindings = false,
			}),
		},
		Prerequisites = {
			PlaceObj('CheckSkillLevel', {
				Amount = 7,
				Condition = ">",
				Skill = "Construction",
				param_bindings = false,
			}),
		},
		Text = T(702067002755, --[[ModItemStoryBit site_mega_nest_pillars Text]] "I managed to scavenge some of the nests own material to bind the pillars together.\nCombined with some thick reeds nearby to lash them together.\n\nAs soon as there was continuous nest material connecting the pillars, the vibrations stopped.\n\nHopefully this will get us something we want.\n\n<em>One nest has been de-activated and will no longer generate attacks</em>"),
		Title = T(250769668217, --[[ModItemStoryBit site_mega_nest_pillars Title]] "Pillar's Stopped"),
		param_bindings = false,
	}),
	PlaceObj('StoryBitOutcome', {
		Effects = {
			PlaceObj('GiveExpeditionRewardToSurvivor', {
				Amount = 50000,
				Resource = "CarbonNanotubes",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					local survivors = GetValidSurvivorsOnMap()
					local rand_surv_index = AsyncRand(#survivors)+1
					local random_surv = survivors[rand_surv_index]
					local closest_nest = MapFindNearest(SelectedObj,"map",'TerritorialNest',
					function(nest) 
							return nest.state == 'inactive' 
						end)
					if closest_nest then
						closest_nest:SwitchState('sleepy')
					end
				end,
				param_bindings = false,
			}),
		},
		Prerequisites = {
			PlaceObj('CheckSkillLevel', {
				Amount = 3,
				Condition = ">",
				Skill = "Physical",
				param_bindings = false,
			}),
			PlaceObj('CheckSkillLevel', {
				Amount = 7,
				Condition = "<=",
				Skill = "Physical",
				param_bindings = false,
			}),
		},
		Text = T(695821266966, --[[ModItemStoryBit site_mega_nest_pillars Text]] "I felled a few small trees and tried to bind them around the pillars.\n\nEven though they literally cannot move, they still vibrate.\n\nI am going to take some of the nest material back with me.\nIt feels weird but doesn't look very natural....\n\n<em>One nest is activated, and will periodically send attacks to the colony</em>"),
		Title = T(636542954862, --[[ModItemStoryBit site_mega_nest_pillars Title]] "Pillar's Not Stopped"),
		param_bindings = false,
	}),
	PlaceObj('StoryBitOutcome', {
		Effects = {
			PlaceObj('GiveExpeditionRewardToSurvivor', {
				Amount = 50000,
				Resource = "CarbonNanotubes",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					local survivors = GetValidSurvivorsOnMap()
					local rand_surv_index = AsyncRand(#survivors)+1
					local random_surv = survivors[rand_surv_index]
					local closest_nest = MapFindNearest(SelectedObj,"map",'TerritorialNest',
					function(nest) 
							return nest.state == 'inactive' 
						end)
					if closest_nest then
						closest_nest:SwitchState('sleepy')
					end
					local closest_nest = MapFindNearest(SelectedObj,"map",'TerritorialNest',
					function(nest) 
							return nest.state == 'inactive' 
						end)
					if closest_nest then
						closest_nest:SwitchState('sleepy')
					end
				end,
				param_bindings = false,
			}),
		},
		Prerequisites = {
			PlaceObj('CheckSkillLevel', {
				Amount = 3,
				Condition = "<=",
				Skill = "Physical",
				param_bindings = false,
			}),
		},
		Text = T(442233584296, --[[ModItemStoryBit site_mega_nest_pillars Text]] "I took a few swings at the pillars, and they are made of some pretty sturdy stuff!\n\nMuch harder than any tree, possibly even metal!\n\nI'll gather up some of scraps and shards.\nHopefully the vibrations don't mean much....\n\n<em>Two nests will activate, and will periodically send attacks to the colony</em>"),
		Title = T(612377216813, --[[ModItemStoryBit site_mega_nest_pillars Title]] "Pillar's not stopped"),
		param_bindings = false,
	}),
	PlaceObj('StoryBitReply', {
		Text = T(289518266882, --[[ModItemStoryBit site_mega_nest_pillars Text]] "Leave it, we do not know what would happen if we did anything"),
		param_bindings = false,
		unique_id = 9,
	}),
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ChangeDisasterEffect', {
			Disaster = "SolarEclipse",
			param_bindings = false,
		}),
	},
	Category = "Disaster",
	Effects = {
		PlaceObj('ExecuteCode', {
			Code = function (self, obj)
				start_nest_disaster()
			end,
			param_bindings = false,
		}),
	},
	Enabled = true,
	ExpirationTime = 46080000,
	Image = "Mod/TGkJ3Tu/Solar Eclipse.JPG",
	NotificationPriority = "Critical",
	NotificationRolloverText = T(249499954776, --[[ModItemStoryBit begin_nest_disaster NotificationRolloverText]] "Click to see what colonists have found about this Eclipse"),
	NotificationRolloverTitle = T(116450847130, --[[ModItemStoryBit begin_nest_disaster NotificationRolloverTitle]] "An unexplained Eclipse has started!"),
	NotificationText = T(136928266076, --[[ModItemStoryBit begin_nest_disaster NotificationText]] "Click to see what colonists have found about this Eclipse"),
	NotificationTitle = T(103290807944, --[[ModItemStoryBit begin_nest_disaster NotificationTitle]] "An unexplained Eclipse has started!"),
	SuppressTime = 20160000,
	Text = T(266362493553, --[[ModItemStoryBit begin_nest_disaster Text]] "An asteroid is directly above us, and has apparently <em>locked orbit</em> with us!!\n\nAfter we collected our jaws, we started to investigate....\n\nThere are small pieces of it breaking off and falling to the planet.\nMost if not all are expected to land near if not on top of us!\n\n<em>Brace for impact!</em>"),
	Title = T(589063501156, --[[ModItemStoryBit begin_nest_disaster Title]] "An Asteroid has locked orbit!"),
	comment = "1st phase of event",
	id = "begin_nest_disaster",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ChangeDisasterEffect', {
			Disaster = "SolarEclipse",
			StartDisaster = false,
			param_bindings = false,
		}),
		PlaceObj('ExecuteCode', {
			Code = function (self, obj)
				MapForEach(true,'TerritorialNest',function(nest)
				nest:SwitchState('awake')
				end)
			end,
			param_bindings = false,
		}),
	},
	NotificationRolloverText = T(501750393611, --[[ModItemStoryBit nest_coordination NotificationRolloverText]] "The situation has changed with the Asteroids"),
	NotificationRolloverTitle = T(480031496740, --[[ModItemStoryBit nest_coordination NotificationRolloverTitle]] "Update on the Asteroids"),
	NotificationText = T(776896274811, --[[ModItemStoryBit nest_coordination NotificationText]] "Update on the Asteroids"),
	NotificationTitle = T(149689226931, --[[ModItemStoryBit nest_coordination NotificationTitle]] "Update on the Asteroids"),
	Prerequisites = {
		PlaceObj('CheckAND', {
			Conditions = {
				PlaceObj('CheckDifficulty', {
					Difficulty = "Easy",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "Hard",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "Medium",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "VeryHard",
					Negate = true,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	},
	SelectObject = false,
	Sets = set( "Negative" ),
	Text = T(153431079337, --[[ModItemStoryBit nest_coordination Text]] "The orbital bombardment has stopped.\nThe asteroid has moved on.\n\nDid it finish raining hell on us?\nGood news is we lived!\n\nBad news, every asteroid that landed was an alien nest.\n\nOur researcher have surmised they have formed a mesh network.\nWhich means they are all actively growing broods and coordinating.\n\nWe must destroy <nests_needed()> of these nests to disrupt this network.\nHopefully that will return the nests to an inactive zit on the planet."),
	Title = T(688893463096, --[[ModItemStoryBit nest_coordination Title]] "Situation has worsened"),
	comment = "2nd phase - low difficulty",
	id = "nest_coordination",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ChangeDisasterEffect', {
			Disaster = "SolarFlare",
			param_bindings = false,
		}),
		PlaceObj('ExecuteCode', {
			Code = function (self, obj)
				MapForEach(true,'TerritorialNest',function(nest)
				nest:SwitchState('awake')
				end)
			end,
			param_bindings = false,
		}),
	},
	NotificationRolloverText = T(153227302834, --[[ModItemStoryBit nest_coordination_insane NotificationRolloverText]] "Update on the Asteroids"),
	NotificationRolloverTitle = T(118586802562, --[[ModItemStoryBit nest_coordination_insane NotificationRolloverTitle]] "Update on the Asteroids"),
	NotificationText = T(309056483418, --[[ModItemStoryBit nest_coordination_insane NotificationText]] "Update on the Asteroids"),
	NotificationTitle = T(408001153551, --[[ModItemStoryBit nest_coordination_insane NotificationTitle]] "Update on the Asteroids"),
	Prerequisites = {
		PlaceObj('CheckAND', {
			Conditions = {
				PlaceObj('CheckDifficulty', {
					Difficulty = "Easy",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "Hard",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "Medium",
					Negate = true,
					param_bindings = false,
				}),
				PlaceObj('CheckDifficulty', {
					Difficulty = "VeryHard",
					Negate = true,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	},
	Sets = set( "Negative" ),
	Text = T(649949890941, --[[ModItemStoryBit nest_coordination_insane Text]] "The asteroid is still hovering above us.\nThe orbital bombardment has stopped... for now.\n\nIt was replaced by a cacophony of electromagnetic signals from the asteroid.\nThis has disrupted our electric grid like we are under a Solar Flare.\nWe are sitting ducks with this... thing looming over us.\n\nThe somehow even worse news?\nEvery asteroid that landed was an alien nest.\n\nOur researcher have surmised they have formed a mesh network.\nWhich means they are all actively growing broods and coordinating.\n\nWe must destroy <nests_needed()> of these nests to disrupt this network.\nHopefully that will return the nests to an inactive zit on the planet."),
	Title = T(504022856330, --[[ModItemStoryBit nest_coordination_insane Title]] "Situation has worsened"),
	comment = "2nd phase -- high difficulty",
	id = "nest_coordination_insane",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemNotificationPreset', {
	dismissable = false,
	fx_action = "UINotificationAnimalAttack",
	game_time = true,
	id = "nests_overactive",
	msg_reactions = {
		PlaceObj('MsgReaction', {
			Event = "StoryBitCompleted",
			Handler = function (self, storybit_id, storybit_state)
				if storybit_id == 'nest_coordination' or storybit_id == 'nest_coordination_insane' then
					MapForEach(true,'TerritorialNest',function(nest,notif)
					if nest.state == 'awake' then notif:AddObject(nest) end end,self)
				end
			end,
		}),
		PlaceObj('MsgReaction', {
			Event = "TerritorialNestDestroyed",
			Handler = function (self, nest, attacker)
				if nest.state == 'awake' then 
				self:RemoveObject(nest)
				local old_nest_killed = MapVarValues['nests_killed'] or 0
				nest_map_upsert('nests_killed',old_nest_killed + 1)
				if MapVarValues['nests_killed'] > MapVarValues['nests_needed'] or MapCount(true,'TerritorialNest')==0  then
					ForceActivateStoryBit('end_nest_disaster')
				end
				end
			end,
		}),
	},
	priority = "Critical",
	remove_invalid_objs = true,
	rollover_text = T(723428939529, --[[ModItemNotificationPreset nests_overactive rollover_text]] "The nearby nests are all working together and spawning attack after attack. We need to kill <nests_left()> to break their communications!"),
	save_in = "Mod/TGkJ3Tu",
	text = T(675595909147, --[[ModItemNotificationPreset nests_overactive text]] "Nest's are Overactive!"),
}),
PlaceObj('ModItemStoryBit', {
	HasNotification = false,
	Image = "Mod/TGkJ3Tu/sorry.jpg",
	SelectObject = false,
	Text = T(798104028451, --[[ModItemStoryBit not_supported_map Text]] "This is a WiP mod and doesn't work for Saltu currently...\n\nI am working to make Saltu and it's Scissorhands nests be used by this mod, but I'm still working on it.\n\nCheck back on the mod occasionally to see if an update mentions other regions!"),
	Title = T(319240132968, --[[ModItemStoryBit not_supported_map Title]] "I'm sorry...."),
	id = "not_supported_map",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	ActivationEffects = {
		PlaceObj('ChangeDisasterEffect', {
			Disaster = "SolarEclipse",
			StartDisaster = false,
			param_bindings = false,
		}),
		PlaceObj('ChangeDisasterEffect', {
			Disaster = "SolarFlare",
			StartDisaster = false,
			param_bindings = false,
		}),
	},
	HasNotification = false,
	Text = T(714108855519, --[[ModItemStoryBit end_nest_disaster Text]] "All the nests are deactivating.\nThe earth no longer rumbles.\n\nAnd I can hear the wind and the birds again.\n\nThe threat has subsided.... for now.\n\nWe must be proactive about cleaning these nests.\nOr else if that asteroid ever returns, it will be easier to start this assault again.\n"),
	Title = T(160725137676, --[[ModItemStoryBit end_nest_disaster Title]] "It's Over"),
	id = "end_nest_disaster",
	save_in = "Mod/TGkJ3Tu",
}),
}
