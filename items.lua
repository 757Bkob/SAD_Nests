return {
PlaceObj('ModItemStoryBit', {
	Category = "Attacks",
	Effects = {
		PlaceObj('ActivateSpawnDef', {
			SpawnDefId = "ShriekerNest",
			param_bindings = false,
		}),
	},
	Enabled = true,
	HasNotification = false,
	HasPopup = false,
	NotificationPriority = "Important",
	NotificationText = T(140394645384, --[[ModItemStoryBit new_nest_shrieker_danger_close NotificationText]] "A meteor is landing nearby"),
	NotificationTitle = T(438817252583, --[[ModItemStoryBit new_nest_shrieker_danger_close NotificationTitle]] "A meteor is landing nearby"),
	Obsolete = true,
	OneTime = false,
	Prerequisites = {
		PlaceObj('CheckRegion', {
			Negate = true,
			Region = set( "Saltu" ),
			param_bindings = false,
		}),
		PlaceObj('CheckOR', {
			Conditions = {
				PlaceObj('CheckTime', {
					TimeMin = 2,
					TimeScale = "years",
					param_bindings = false,
				}),
				PlaceObj('CheckTech', {
					Tech = "AncientLanguage",
					param_bindings = false,
				}),
				PlaceObj('CheckProgress', {
					ProgressMin = 5400,
					param_bindings = false,
				}),
				PlaceObj('CheckAND', {
					Conditions = {
						PlaceObj('CheckProgress', {
							ProgressMin = 900,
							param_bindings = false,
						}),
						PlaceObj('CheckOR', {
							Conditions = {
								PlaceObj('CheckDifficulty', {
									Difficulty = "Easy",
									param_bindings = false,
								}),
								PlaceObj('CheckDifficulty', {
									Difficulty = "Medium",
									param_bindings = false,
								}),
							},
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
				PlaceObj('CheckAND', {
					Conditions = {
						PlaceObj('CheckProgress', {
							ProgressMin = 1800,
							param_bindings = false,
						}),
						PlaceObj('CheckDifficulty', {
							Difficulty = "Hard",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
				PlaceObj('CheckAND', {
					Conditions = {
						PlaceObj('CheckProgress', {
							ProgressMin = 2700,
							param_bindings = false,
						}),
						PlaceObj('CheckDifficulty', {
							Difficulty = "VeryHard",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
				PlaceObj('CheckAND', {
					Conditions = {
						PlaceObj('CheckProgress', {
							ProgressMin = 3600,
							param_bindings = false,
						}),
						PlaceObj('CheckDifficulty', {
							Difficulty = "Insane",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	},
	SelectObject = false,
	Sets = set( "Attack", "Negative" ),
	SuppressTime = 40000,
	Text = T(441492873284, --[[ModItemStoryBit new_nest_shrieker_danger_close Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
	Title = T(779576850737, --[[ModItemStoryBit new_nest_shrieker_danger_close Title]] "A meteor is landing nearby"),
	comment = "WiP",
	id = "new_nest_shrieker_danger_close",
	max_reply_id = 3,
	qa_info = PlaceObj('PresetQAInfo', {
		Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
		param_bindings = false,
	}),
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemCode', {
	'name', "Robo_Nesting",
	'CodeFileName', "Code/Robo_Nesting.lua",
}),
PlaceObj('ModItemCode', {
	'name', "Robot_Nests",
	'CodeFileName', "Code/Robot_Nests.lua",
}),
PlaceObj('ModItemCode', {
	'name', "Non_Nest_code",
	'CodeFileName', "Code/Non_Nest_code.lua",
}),
PlaceObj('ModItemCode', {
	'name', "nest_class",
	'CodeFileName', "Code/nest_class.lua",
}),
PlaceObj('ModItemFolder', {
	'name', "Notifications",
	'NameColor', RGBA(0, 144, 201, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Attacks",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/sleepy_insect.jpg",
		NotificationText = T(433873099185, --[[ModItemStoryBit back_to_sleep NotificationText]] "A nest has become inactive"),
		NotificationTitle = T(501042144899, --[[ModItemStoryBit back_to_sleep NotificationTitle]] "A nest has become inactive"),
		Sets = set( "Negative" ),
		Text = T(924669975056, --[[ModItemStoryBit back_to_sleep Text]] "Twas the night before the attack, when all through the nest.\nNot an insect was stirring, not even a louse.\n\n<em>A nest has either forgotten about us, or ran out of things to eat and sustain their level of aggression.</em>\n\nRegardless, there is one less active threat against us! "),
		Title = T(539239421300, --[[ModItemStoryBit back_to_sleep Title]] "A nest has become inactive"),
		UseObjectImage = true,
		id = "back_to_sleep",
		max_reply_id = 3,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(715181198950, --[[ModItemStoryBit back_to_sleep Text]] "Ok"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(275615090059, --[[ModItemStoryBit back_to_sleep Text]] "That was cute, but no more popups"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['nests_notifications'] = 1
						else
						     MapVar('nests_notifications',1)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(411649778347, --[[ModItemStoryBit back_to_sleep Text]] "That wasn't cute, and don't notify me at all"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['Nest_Notifications'] = 0
						else
						     MapVar('nests_notifications',0)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemNotificationPreset', {
		dismissable = false,
		game_time = true,
		id = "back_to_sleep",
		priority = "StoryBit",
		remove_invalid_objs = true,
		rollover_text = T(551742581635, --[[ModItemNotificationPreset back_to_sleep rollover_text]] "A nest has become inactive"),
		save_in = "Mod/TGkJ3Tu",
		text = T(908362848310, --[[ModItemNotificationPreset back_to_sleep text]] "A nest has become inactive"),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Attacks",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Alarm_Clock.jpeg",
		NotificationText = T(126554022751, --[[ModItemStoryBit waking_up NotificationText]] "A nest has activated!"),
		NotificationTitle = T(568019442711, --[[ModItemStoryBit waking_up NotificationTitle]] "A nest has activated!"),
		Sets = set( "Negative" ),
		Text = T(603041965465, --[[ModItemStoryBit waking_up Text]] "A nest of predators has been alerted of our presence!\n\nThe air around the nest is starting to warm up, and there is a low rumbling in the earth.\n\nThe ant species (Our closest reference) of Earth respond aggressively to any other rival species colonies.\n\n<em>This nest will now:\n1. It's spawn cycles will attack the colony\n2. The core nest building will steadily gain HP.</em>"),
		Title = T(945135996075, --[[ModItemStoryBit waking_up Title]] "A nest has activated!"),
		UseObjectImage = true,
		id = "waking_up",
		max_reply_id = 3,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(236737271727, --[[ModItemStoryBit waking_up Text]] "Ok"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(647394331432, --[[ModItemStoryBit waking_up Text]] "No more popups please"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['Nest_Notifications'] = 1
						else
						     MapVar('nests_notifications',1)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(760133305481, --[[ModItemStoryBit waking_up Text]] "Don't notify me at all"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['Nest_Notifications'] = 0
						else
						     MapVar('nests_notifications',0)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemNotificationPreset', {
		dismissable = false,
		game_time = true,
		id = "waking_up",
		priority = "StoryBit",
		remove_invalid_objs = true,
		rollover_text = T(448523028409, --[[ModItemNotificationPreset waking_up rollover_text]] "A nest has activated!"),
		save_in = "Mod/TGkJ3Tu",
		text = T(868817520708, --[[ModItemNotificationPreset waking_up text]] "A nest has learned of our presence!"),
	}),
	PlaceObj('ModItemStoryBit', {
		Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Evolution.jpg",
		NotificationText = T(815248275915, --[[ModItemStoryBit nests_evolving NotificationText]] "A nest has evolved it's brood!"),
		NotificationTitle = T(134460250774, --[[ModItemStoryBit nests_evolving NotificationTitle]] "A nest has evolved it's brood!"),
		Text = T(535664889736, --[[ModItemStoryBit nests_evolving Text]] "A nearby nest has released a creature that is different than it's prior broods...\n\nThis means the nest diverted some resources to improve and evolve it's defenders!\nWe must hurry and deal with this nest before the creatures get even stronger!\n<spore_diff_text()>"),
		Title = T(769708346612, --[[ModItemStoryBit nests_evolving Title]] "A nest has evolved it's brood!"),
		id = "nests_evolving",
		max_reply_id = 3,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(350519377508, --[[ModItemStoryBit nests_evolving Text]] "Ok"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(813034085672, --[[ModItemStoryBit nests_evolving Text]] "No more popups please"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['Nest_Notifications'] = 1
						else
						     MapVar('nests_notifications',1)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(959647789954, --[[ModItemStoryBit nests_evolving Text]] "Don't notify me at all"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						if MapVarValues['Nest_Notifications'] then
						    MapVarValues['Nest_Notifications'] = 0
						else
						     MapVar('nests_notifications',0)
						end
					end,
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemNotificationPreset', {
		dismissable = false,
		game_time = true,
		id = "nests_evolving",
		priority = "StoryBit",
		remove_invalid_objs = true,
		rollover_text = T(706400074027, --[[ModItemNotificationPreset nests_evolving rollover_text]] "A nest has evolved it's brood!"),
		save_in = "Mod/TGkJ3Tu",
		text = T(277231115910, --[[ModItemNotificationPreset nests_evolving text]] "A nest has evolved it's brood!"),
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Nest Spawner storybits",
	'NameColor', RGBA(192, 4, 4, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Attacks",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ScissorhandNest",
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(493683430303, --[[ModItemStoryBit new_nest_scissorhand NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(421352706613, --[[ModItemStoryBit new_nest_scissorhand NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Attack", "Negative" ),
		SuppressTime = 40000,
		Text = T(150518945986, --[[ModItemStoryBit new_nest_scissorhand Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(206941887720, --[[ModItemStoryBit new_nest_scissorhand Title]] "A meteor is landing nearby"),
		id = "new_nest_scissorhand",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
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
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(728880909304, --[[ModItemStoryBit new_nest_shrieker NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(528830908123, --[[ModItemStoryBit new_nest_shrieker NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Attack", "Negative" ),
		SuppressTime = 40000,
		Text = T(480862517656, --[[ModItemStoryBit new_nest_shrieker Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(744697671524, --[[ModItemStoryBit new_nest_shrieker Title]] "A meteor is landing nearby"),
		id = "new_nest_shrieker",
		max_reply_id = 2,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Attacks",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ConsortiumNest",
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(395839683430, --[[ModItemStoryBit new_nest_consortium NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(615713043810, --[[ModItemStoryBit new_nest_consortium NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Attack", "Negative" ),
		SuppressTime = 40000,
		Text = T(485076708155, --[[ModItemStoryBit new_nest_consortium Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(992773234973, --[[ModItemStoryBit new_nest_consortium Title]] "A meteor is landing nearby"),
		id = "new_nest_consortium",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "UI",
	'NameColor', RGBA(22, 153, 0, 255),
}, {
	PlaceObj('ModItemXTemplate', {
		group = "Infopanel Sections",
		id = "tabOverview_200_BuildingHealth",
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('XTemplateTemplate', {
			'__context_of_kind', "WorkAreaObject",
			'__condition', function (parent, context) return context:IsSingleWorkAreaObject() end,
			'__template', "InfopanelSection",
		}, {
			PlaceObj('XTemplateWindow', {
				'__class', "XContextWindow",
				'FoldWhenHidden', true,
				'ContextUpdateOnOpen', true,
				'OnContextUpdate', function (self, context, ...)
					XContextWindow.OnContextUpdate(self, context, ...)
					local player = context.player
					local area = context:GetChosenWorkArea()
					local found
					for i, area in ipairs(player.labels.WorkArea) do
						if area:IsInsideWorkArea(context) then
							found = true
							break
						end
					end
					self:SetVisible(area ~= player or found)
				end,
			}, {
				PlaceObj('XTemplateWindow', {
					'__class', "XText",
					'Padding', box(0, 0, 0, 0),
					'HAlign', "left",
					'FoldWhenHidden', true,
					'HandleMouse', false,
					'TextStyle', "InfopanelText",
					'Translate', true,
					'Text', T(669542448673, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Work Area"),
				}),
				PlaceObj('XTemplateWindow', {
					'__class', "XText",
					'Id', "idWorkArea",
					'Padding', box(0, 0, 0, 0),
					'HAlign', "right",
					'FoldWhenHidden', true,
					'HandleMouse', false,
					'TextStyle', "TextEmphasis",
					'ContextUpdateOnOpen', true,
					'OnContextUpdate', function (self, context, ...)
						XText.OnContextUpdate(self, context, ...)
						self:SetVisible(context:GetChosenWorkArea() == context.player)
					end,
					'Translate', true,
					'Text', T(309932974886, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Global"),
				}),
				PlaceObj('XTemplateWindow', {
					'__class', "XTextButton",
					'HAlign', "right",
					'Background', RGBA(0, 0, 0, 0),
					'OnContextUpdate', function (self, context, ...)
						XTextButton.OnContextUpdate(self, context, ...)
						self:SetVisible(context:GetChosenWorkArea() ~= context.player)
					end,
					'FocusedBackground', RGBA(0, 0, 0, 0),
					'OnPress', function (self, gamepad)
						ViewAndSelectObject(self.context:GetChosenWorkArea())
					end,
					'RolloverBackground', RGBA(0, 0, 0, 0),
					'PressedBackground', RGBA(0, 0, 0, 0),
					'TextStyle', "TextButton",
				}, {
					PlaceObj('XTemplateWindow', {
						'__class', "XText",
						'TextStyle', "TextButton",
						'Translate', true,
						'Text', T(908268590289, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "<IPWorkAreaName>"),
					}, {
						PlaceObj('XTemplateFunc', {
							'name', "CalcTextColor",
							'func', function (self, ...)
								local parent = self.parent
								return self.enabled
									and ((parent:IsFocused(true) or parent.rollover) and self.RolloverTextColor or self.TextColor)
									or self.DisabledTextColor
							end,
						}),
						}),
					}),
				}),
			}),
		PlaceObj('XTemplateTemplate', {
			'__context_of_kind', "StoragePileInfopanelObject",
			'__condition', function (parent, context) return context:IsConstructionFinished() end,
			'__template', "InfopanelSection",
			'Id', "idHealthBarSection",
		}, {
			PlaceObj('XTemplateWindow', {
				'__class', "FrameProgress",
				'RolloverTemplate', "TutorialHintRollover",
				'Id', "idHealthBar",
				'BindTo', "Health",
				'BarColor', RGBA(192, 60, 58, 255),
				'Text', T(936317374826, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Integrity<right><Progress> / <MaxProgress>"),
			}),
			}),
		PlaceObj('XTemplateTemplate', {
			'__context_of_kind', "EnhancedTerritorialNest",
			'__condition', function (parent, context) return context.Health > 0 and IsKindOf(context,'EnhancedTerritorialNest') end,
			'__template', "InfopanelSection",
			'RolloverAnchorId', "NestHelp",
			'RolloverText', T(352700748157, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "<style TextNegative>Nests will consume nearby flora & fauna.</style>\nWith the material it will:\n1. Create & send attacks\n2. Evolve the units it creates\n3. Store excess in nearby nest structures."),
			'RolloverTitle', T(685477114002, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "What Enhanced Nests do"),
			'RolloverHint', T(987068224940, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverHint]] "<em>Kill it quick before it becomes a problem!</em>"),
			'Id', "idNestInfographic",
			'IdNode', false,
			'OnContextUpdate', function (self, context, ...)
				XSection.OnContextUpdate(self, context, ...)
				self:SetVisible(context.Health >0 or not context.HideIntegrityBarWhenDestroyed)
			end,
			'Title', T(515573972235, --[[ModItemXTemplate tabOverview_200_BuildingHealth Title]] "Nests Awaken Enhancements (?)"),
		}, {
			PlaceObj('XTemplateWindow', {
				'comment', "State - sleepy",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:IsSleepy() end,
				'__class', "XText",
				'Id', "idNestStateText",
				'FoldWhenHidden', true,
				'TextStyle', "InfopanelText",
				'OnContextUpdate', function (self, context, ...)
					FrameProgress.OnContextUpdate(self, context, ...)
					self:SetVisible(self.value > 0)
				end,
				'Translate', true,
				'Text', T(395383134651, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "An <style TextEmphasis>awoken</style> nest, actively growing and sending attacks."),
				'HideOnEmpty', true,
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "State - awake",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:IsAwake() end,
				'__class', "XText",
				'Id', "idNestStateText",
				'FoldWhenHidden', true,
				'TextStyle', "InfopanelText",
				'OnContextUpdate', function (self, context, ...)
					FrameProgress.OnContextUpdate(self, context, ...)
					self:SetVisible(self.value > 0)
				end,
				'Translate', true,
				'Text', T(304647586842, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "An <style TextNegative>overactive</style> nest, coordinating with all other nests to grow and attack!"),
				'HideOnEmpty', true,
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "State - asleep",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:IsAsleep() end,
				'__class', "XText",
				'Id', "idNestStateText",
				'FoldWhenHidden', true,
				'TextStyle', "InfopanelText",
				'OnContextUpdate', function (self, context, ...)
					FrameProgress.OnContextUpdate(self, context, ...)
					self:SetVisible(self.value > 0)
				end,
				'Translate', true,
				'Text', T(821602814761, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "An <style TextPositive>inert</style> nest, slowly growing with some patrolling defenders."),
				'HideOnEmpty', true,
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "How close to an attack",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context.Health > 0 end,
				'__class', "FrameProgress",
				'Id', "idNestHarvest",
				'OnContextUpdate', function (self, context, ...)
					FrameProgress.OnContextUpdate(self, context, ...)
					self:SetVisible(self.value > 0)
				end,
				'BindTo', "ui_attack_percent",
				'BarColor', RGBA(96, 116, 127, 255),
				'Text', T(430714079282, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Biomass Buildup<right><percent(value, nil, 0)>"),
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "How close to evolving",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context.Health > 0 end,
				'__class', "FrameProgress",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(938069739118, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "Every nest attack leaves residual material for a nest to evolve it's denizens. Kill it quick before it becomes too strong to handle!"),
				'RolloverTitle', T(948710175809, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Nest Evolution"),
				'RolloverHint', T(773481274810, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverHint]] "Every nest attack leaves residual material for a nest to evolve it's denizens. Kill it quick before it becomes too strong to handle!"),
				'Id', "idNestEvoBar",
				'HandleMouse', true,
				'OnContextUpdate', function (self, context, ...)
					FrameProgress.OnContextUpdate(self, context, ...)
					self:SetVisible(self.value > 0)
				end,
				'BindTo', "ui_evo",
				'BarColor', RGBA(96, 116, 127, 255),
				'Text', T(547344869850, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Biomass dedicated for evolution<right><percent(value, nil, 0)>"),
			}),
			}),
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Nest Spawn Setup",
	'NameColor', RGBA(255, 232, 45, 255),
}, {
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target)
			AddGameNotification("InsectNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,'ShriekerNest')
		end,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		comment = "Overriding of base",
		id = "ShriekerNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target)
			AddGameNotification("InsectNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"ScissorhandsNest")
		end,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "ScissorhandNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("ConsortiumNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"ConsortiumNest")
		end,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "ConsortiumNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "scissorhands_nest",
		'TagDist', {
			PlaceObj('DistToTag', {
				'Tag', "spill_rocks",
				'Dist', 20000,
			}),
			PlaceObj('DistToTag', {
				'Tag', "lake",
				'Dist', 20000,
			}),
		},
	}),
	PlaceObj('ModItemPrefabType', {
		'Id', "scissor_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "scissorhands_nest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "scissor_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "scissorhands_nest" ),
		'DistToSame', 20000,
		'TerrainSlopeMax', 900,
		'PrefabTypeGroups', {
			PlaceObj('PrefabTypeGroup', {
				'types', {
					"S_Plains",
					"S_Plains_Dry",
					"S_Plains_Rocky",
					"S_Meadows",
					"S_Birches",
					"S_Bushes_Flat",
					"S_Bushes_Hazel",
					"S_Bushes_Blue",
					"S_Alpine",
					"S_Spruces",
					"S_Riverside",
					"D_Sands",
					"D_Cacti_Desert",
					"D_Cacti_Waste",
					"D_Grass_Dry",
					"D_Palms_Low",
					"D_Palms",
					"D_Floodplain",
					"D_Waste",
					"D_Waste_Salt",
					"D_Rocky_Sands",
					"D_Rocky_Waste",
					"D_Rocky_Grass",
					"D_Shrubs_Dry",
					"D_Shrubs_Semi",
					"D_Shrubs_Grass",
					"J_Grassland",
					"J_Grassland_Reed",
					"J_Grassland_Rocky",
					"J_Forest_Banana",
					"J_Forest_Palm",
					"J_Wetland",
					"J_Wetland_Grass",
					"J_Wetland_Mangrove",
					"J_Wetland_Palms",
					"J_Wetland_Reed",
					"J_Wetland_Taro",
					"J_Wetland_Rocky",
					"J_Highland_Grass",
					"J_Highland_Rocky",
				},
			}),
		},
		'OverlayColor', RGBA(130, 38, 38, 255),
	}),
	PlaceObj('ModItemPrefabType', {
		'Id', "ConsortiumNest",
		'OnObjOverlap', 3,
		'Tags', set( "ConsortiumNest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "ConsortiumNest",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "ConsortiumNest" ),
		'DistToSame', 20000,
		'TerrainSlopeMax', 900,
		'PrefabTypeGroups', {
			PlaceObj('PrefabTypeGroup', {
				'types', {
					"S_Plains",
					"S_Plains_Dry",
					"S_Plains_Rocky",
					"S_Meadows",
					"S_Birches",
					"S_Bushes_Flat",
					"S_Bushes_Hazel",
					"S_Bushes_Blue",
					"S_Alpine",
					"S_Spruces",
					"S_Riverside",
					"D_Sands",
					"D_Cacti_Desert",
					"D_Cacti_Waste",
					"D_Grass_Dry",
					"D_Palms_Low",
					"D_Palms",
					"D_Floodplain",
					"D_Waste",
					"D_Waste_Salt",
					"D_Rocky_Sands",
					"D_Rocky_Waste",
					"D_Rocky_Grass",
					"D_Shrubs_Dry",
					"D_Shrubs_Semi",
					"D_Shrubs_Grass",
					"J_Grassland",
					"J_Grassland_Reed",
					"J_Grassland_Rocky",
					"J_Forest_Banana",
					"J_Forest_Palm",
					"J_Wetland",
					"J_Wetland_Grass",
					"J_Wetland_Mangrove",
					"J_Wetland_Palms",
					"J_Wetland_Reed",
					"J_Wetland_Taro",
					"J_Wetland_Rocky",
					"J_Highland_Grass",
					"J_Highland_Rocky",
				},
			}),
		},
		'OverlayColor', RGBA(130, 38, 38, 255),
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "ConsortiumNest",
		'TagDist', {
			PlaceObj('DistToTag', {
				'Tag', "spill_rocks",
				'Dist', 20000,
			}),
			PlaceObj('DistToTag', {
				'Tag', "lake",
				'Dist', 20000,
			}),
		},
	}),
	PlaceObj('ModItemNotificationPreset', {
		expiration = 480000,
		fx_action = "UINotificationImportant",
		game_time = true,
		id = "ConsortiumNestSpawned",
		rollover_text = T(212707868936, --[[ModItemNotificationPreset ConsortiumNestSpawned rollover_text]] "A large Consortium Automated Base has dropped from orbit!"),
		rollover_title = T(133001288045, --[[ModItemNotificationPreset ConsortiumNestSpawned rollover_title]] "New Consortium Base"),
		save_in = "Mod/TGkJ3Tu",
		text = T(593714970551, --[[ModItemNotificationPreset ConsortiumNestSpawned text]] "New Consortium Base"),
	}),
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(971095329043, --[[ModItemTech FieldConsortiumSpore Description]] "Based on what landed, this seems to be the Consortium's R.E.P.O. (Resource Extraction Prefab Objects) package.\n\nFrom their advertisement channel:\n<style TextPositive>Ever want to collect and hoard rare minerals but too lazy to leave your planet? Look no further! The R.E.P.O. prefab is a self-replicating automatazapalooza that can strip a planet dry within a decade!</style>\n<style FinePrint>Terms and conditions apply, The Consortium does not guarantee minimum efficiency of prefabs. To see the full disclaimer list, please visit the Consortium Headquarters during it's visitor hours on Mondays between 8 and 9 am.</style>"),
		DisplayName = T(919872346092, --[[ModItemTech FieldConsortiumSpore DisplayName]] "Consortium Prefab"),
		DisplayNamePl = T(553422873878, --[[ModItemTech FieldConsortiumSpore DisplayNamePl]] "Consortium Prefabs"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Consortium Nest Research.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldConsortiumSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
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
		comment = "-- \n    Called from custom Lua code, no storybit attack",
		group = "Attacks_Insects_NEW",
		id = "nest_attack",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Behaviours = {
			PlaceObj('AnimalSpawnDefBehaviourRoam', {
				'Duration', 9600000,
				'NoSleep', false,
			}),
			PlaceObj('AnimalSpawnDefBehaviourBerserk', {
				'Duration', 320000,
			}),
			PlaceObj('AnimalSpawnDefBehaviourRoam', {
				'Duration', 0,
				'NoSleep', false,
			}),
		},
		PostSpawn = function (self, obj, target, context)
			obj.CombatHostile = true
		end,
		SpawnClass = "Shrieker_Manhunting_Hatchling",
		comment = "---\n    Perma-wandering insects because player is unknown/neutral\n    Called from custom Lua code, no storybit attack",
		id = "nest_overflow",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNotificationPreset', {
		expiration = 60000,
		expiration_bar = true,
		fx_action = "UINotificationAnimalAttack",
		id = "nests_disgorged",
		rollover_text = T(337902645815, --[[ModItemNotificationPreset nests_disgorged rollover_text]] "A nearby nest has created too many creatures and let some loose!"),
		save_in = "Mod/TGkJ3Tu",
		text = T(818323081200, --[[ModItemNotificationPreset nests_disgorged text]] "A nest has released roaming units!"),
	}),
	PlaceObj('ModItemMapDataPreset', {
		AssetsRevision = 29397,
		GameLogic = false,
		HeightMapAvg = 6900,
		HeightMapMax = 6900,
		HeightMapMin = 6900,
		IsPrefabMap = true,
		LuaRevision = 373414,
		MapType = "system",
		MaxObjRadius = 33812,
		MaxSurfRadius2D = 7210,
		ModEditor = true,
		NetHash = 9010960979011690416,
		ObjectsHash = -5275805457219513278,
		OrgLuaRevision = 373414,
		TerrainHash = 5957367570479299252,
		group = "PrefabMap",
		id = "nest_prefab_holder",
		markers = {
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_01",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1354319414,
				'pos', point(55200, 14400),
				'data', 'return {name="SpawnConsortiumNest_01",marker={handle = 1354319414,map = "nest_prefab_holder"},hash=1144278545109099966,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=2577293333366477412,type_names={Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=9682,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_02",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1353441996,
				'pos', point(14400, 55200),
				'data', 'return {name="SpawnConsortiumNest_02",marker={handle = 1353441996,map = "nest_prefab_holder"},hash=-6863084763251148546,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=7823967666307924114,type_names={Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=10929,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_03",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1725445525,
				'pos', point(14400, 14400),
				'data', 'return {name="SpawnConsortiumNest_03",marker={handle = 1725445525,map = "nest_prefab_holder"},hash=-1934449408694917449,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=2577293333366477412,type_names={Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=6,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=11448,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnScissorNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1683640773,
				'pos', point(208800, 74400),
				'data', 'return {name="SpawnScissorNest_1",marker={handle = 1683640773,map = "nest_prefab_holder"},hash=7098478348796132684,revision=29265,tags=set( "scissorhands_nest" ),poi_type="scissor_prefab_POI",poi_area="Default",size=point(33600, 31200),height_hash=5956781812321257378,height_offset=-1380,min=point(7, 0, 0),max=point(8, 0, 0),type_hash=-2622297160058893600,type_names={Sand_01 = 0},grass_hash=-315783998437808945,mask_hash=1740846206681711898,total_area=2821,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=1455,obj_max_radius=9680,obj_avg_radius=3645,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnScissorNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1787213042,
				'pos', point(163200, 72000),
				'data', 'return {name="SpawnScissorNest_2",marker={handle = 1787213042,map = "nest_prefab_holder"},hash=4831566415555661102,revision=29265,tags=set( "scissorhands_nest" ),poi_type="scissor_prefab_POI",poi_area="Default",size=point(36000, 33600),height_hash=6143602635854926162,height_offset=-1380,min=point(12, 0, 0),max=point(13, 0, 0),type_hash=-8333799106890059670,type_names={Sand_01 = 0},grass_hash=-1077138140842274167,mask_hash=-2325952025988458901,total_area=3111,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=1455,obj_max_radius=9680,obj_avg_radius=4773,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnScissorNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1854838865,
				'pos', point(117600, 69600),
				'data', 'return {name="SpawnScissorNest_3",marker={handle = 1854838865,map = "nest_prefab_holder"},hash=8325010866724925378,revision=29265,tags=set( "scissorhands_nest" ),poi_type="scissor_prefab_POI",poi_area="Default",size=point(38400, 38400),height_hash=-6588654090796207555,height_offset=-1380,min=point(23, 0, 0),max=point(24, 0, 0),type_hash=1099485564251231799,type_names={Sand_01 = 0},grass_hash=-5341408941896045999,mask_hash=-305019797789143729,total_area=3439,min_radius=33,max_radius=33,obj_count=12,obj_min_radius=1455,obj_max_radius=9680,obj_avg_radius=3666,}',
				'data_version', "1",
			}),
		},
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemEntity', {
		'name', "PXTeslaRod",
		'class_parent', "ConsortiumSporeDeposit",
		'fade_category', "Max",
		'ClassParents', {
			"ConsortiumSporeDeposit",
		},
		'entity_name', "PXTeslaRod",
		'material_type', "Metal",
		'material', {
			"PXTeslaRod_PXTeslaRod",
		},
		'mesh', {
			"PXTeslaRod_PXTeslaRod.m",
		},
		'texture', {
			"6966000",
			"6966001",
			"6966002",
			"6966003",
			"6966004",
			"6966005",
			"6966006",
			"6966007",
		},
	}),
	PlaceObj('ModItemEntity', {
		'name', "PXPowerFacility",
		'class_parent', "ConsortiumSporeDeposit",
		'fade_category', "Max",
		'ClassParents', {
			"ConsortiumSporeDeposit",
		},
		'entity_name', "PXPowerFacility",
		'material_type', "Metal",
		'material', {
			"PXPowerFacility_PXPowerFacility",
		},
		'mesh', {
			"PXPowerFacility_PXPowerFacility.m",
		},
		'texture', {
			"10014000",
			"10014001",
			"10014002",
			"10014003",
			"10014004",
			"10014005",
			"10014006",
		},
	}),
	PlaceObj('ModItemEntity', {
		'name', "PXSatelite",
		'class_parent', "ConsortiumSporeDeposit",
		'ClassParents', {
			"ConsortiumSporeDeposit",
		},
		'entity_name', "PXSatelite",
		'material_type', "Metal",
		'material', {
			"PXSatelite_PXSatelite",
		},
		'mesh', {
			"PXSatelite_PXSatelite.m",
		},
		'texture', {
			"6995004",
			"6995005",
			"6995006",
			"6995007",
			"6995008",
			"6995009",
			"6995010",
			"6995011",
			"6995012",
			"6995013",
			"6995014",
		},
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Disaster",
	'NameColor', RGBA(176, 86, 0, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Disaster",
		Effects = {
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					Start_Nest_Disaster()
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		ExpirationTime = 46080000,
		HasPopup = false,
		Image = "Mod/TGkJ3Tu/Solar Eclipse.JPG",
		NotificationCanDismiss = false,
		NotificationPriority = "Critical",
		NotificationTitle = T(385391840178, --[[ModItemStoryBit begin_nest_disaster NotificationTitle]] "Something is happening!"),
		SuppressTime = 20160000,
		Text = T(545174437678, --[[ModItemStoryBit begin_nest_disaster Text]] "An asteroid is directly above us, and has apparently <em>locked orbit</em> with us!!\n\nAfter we collected our jaws, we started to investigate....\n\nThere are small pieces of it breaking off and falling to the planet.\nMost if not all are expected to land near if not on top of us!\n\n<em>Brace for impact!</em>"),
		Title = T(314102780013, --[[ModItemStoryBit begin_nest_disaster Title]] "An Asteroid is causing the eclipse!"),
		comment = "Lua code checks and triggers correct storybit",
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
		NotificationRolloverText = T(501750393611, --[[ModItemStoryBit nest_disaster_phase_2 NotificationRolloverText]] "The situation has changed with the Asteroids"),
		NotificationRolloverTitle = T(480031496740, --[[ModItemStoryBit nest_disaster_phase_2 NotificationRolloverTitle]] "Update on the Asteroids"),
		NotificationText = T(776896274811, --[[ModItemStoryBit nest_disaster_phase_2 NotificationText]] "Update on the Asteroids"),
		NotificationTitle = T(149689226931, --[[ModItemStoryBit nest_disaster_phase_2 NotificationTitle]] "Update on the Asteroids"),
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(153431079337, --[[ModItemStoryBit nest_disaster_phase_2 Text]] "The orbital bombardment has stopped.\nThe asteroid has moved on.\n\nDid it finish raining hell on us?\nThe good news is we lived!\n\nBad news, every asteroid that landed was an alien nest.\n\nOur researcher have surmised they have formed a mesh network.\nWhich means they are all actively growing broods and coordinating.\n\nWe must destroy <nests_needed()> of these nests to disrupt this network.\nHopefully that will return the nests to an inactive zit on the planet."),
		Title = T(688893463096, --[[ModItemStoryBit nest_disaster_phase_2 Title]] "Situation has worsened"),
		comment = "Enough nests, time to coordinate!",
		id = "nest_disaster_phase_2",
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
		Effects = {
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					end_disaster(true)
				end,
				param_bindings = false,
			}),
		},
		HasNotification = false,
		Text = T(714108855519, --[[ModItemStoryBit end_nest_disaster Text]] "All the nests are deactivating.\nThe earth no longer rumbles.\n\nAnd I can hear the wind and the birds again.\n\nThe threat has subsided.... for now.\n\nWe must be proactive about cleaning these nests.\nOr else if that asteroid ever returns, it will be easier to start this assault again.\n"),
		Title = T(160725137676, --[[ModItemStoryBit end_nest_disaster Title]] "It's Over"),
		id = "end_nest_disaster",
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
	PlaceObj('ModItemStoryBit', {
		ActivationEffects = {
			PlaceObj('ChangeDisasterEffect', {
				Disaster = "SolarEclipse",
				param_bindings = false,
			}),
		},
		Category = "Disaster",
		Enabled = true,
		ExpirationTime = 46080000,
		Image = "Mod/TGkJ3Tu/Solar Eclipse.JPG",
		NotificationPriority = "Critical",
		NotificationRolloverTitle = T(116450847130, --[[ModItemStoryBit begin_nest_disaster_shrieker NotificationRolloverTitle]] "An unexplained Eclipse has started!"),
		NotificationTitle = T(103290807944, --[[ModItemStoryBit begin_nest_disaster_shrieker NotificationTitle]] "An unexplained Eclipse has started!"),
		SuppressTime = 20160000,
		Text = T(266362493553, --[[ModItemStoryBit begin_nest_disaster_shrieker Text]] "An asteroid is directly above us, and has apparently <em>locked orbit</em> with us!!\n\nAs we collected our jaws, a small piece breaks off and starts falling.\nIt crashes nearby, and through the dust we see a Shrieker Nest unfurl!\n\nThose still watching the asteroid report more objects breaking off.....\n\n<em>Brace for impact!</em>"),
		Title = T(589063501156, --[[ModItemStoryBit begin_nest_disaster_shrieker Title]] "An Asteroid is directly above us!"),
		id = "begin_nest_disaster_shrieker",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		ActivationEffects = {
			PlaceObj('ChangeDisasterEffect', {
				Disaster = "SolarEclipse",
				param_bindings = false,
			}),
		},
		Category = "Disaster",
		Enabled = true,
		ExpirationTime = 46080000,
		NotificationPriority = "Critical",
		NotificationRolloverTitle = T(497010627846, --[[ModItemStoryBit begin_nest_disaster_scissor NotificationRolloverTitle]] "Unexplained Earthquakes are now occurring"),
		NotificationTitle = T(672098277776, --[[ModItemStoryBit begin_nest_disaster_scissor NotificationTitle]] "Unexplained Earthquakes!"),
		SuppressTime = 20160000,
		Text = T(659817074401, --[[ModItemStoryBit begin_nest_disaster_scissor Text]] "The earth rumbles....\nIt groans and creaks.\n\nAnd when you put your ear to the ground, you can barely make out scraping and clawing.\n\nJust as you recover, your scouts report a Scissorhands nest bursting from the dirt nearby.\nThe denizens are quickly cleaning their claws of mud.\n\nThis must only be the vanguard... the faster tunnelers...\n<em>Prepare for more!</em>"),
		Title = T(707807296355, --[[ModItemStoryBit begin_nest_disaster_scissor Title]] "The planet moves!"),
		id = "begin_nest_disaster_scissor",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		ActivationEffects = {
			PlaceObj('ChangeDisasterEffect', {
				Disaster = "SolarEclipse",
				param_bindings = false,
			}),
		},
		Category = "Disaster",
		Enabled = true,
		ExpirationTime = 46080000,
		NotificationPriority = "Critical",
		NotificationRolloverTitle = T(359227274176, --[[ModItemStoryBit begin_nest_disaster_robot NotificationRolloverTitle]] "An unexplained Eclipse has started!"),
		NotificationTitle = T(286101144728, --[[ModItemStoryBit begin_nest_disaster_robot NotificationTitle]] "An unexplained Eclipse has started!"),
		SuppressTime = 20160000,
		Text = T(194288232486, --[[ModItemStoryBit begin_nest_disaster_robot Text]] "The air is filled with smoke, and the smell of petrol is pungent.\n\nThe sound of rotors fills the air, and you barely see the silhouette of hundreds of Consortium ships piercing the atmosphere.\n\nDrones"),
		Title = T(297523086088, --[[ModItemStoryBit begin_nest_disaster_robot Title]] "An Asteroid is causing the eclipse!"),
		id = "begin_nest_disaster_robot",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNotificationPreset', {
		dismissable = false,
		fx_action = "UINotificationAnimalAttack",
		game_time = true,
		id = "dis_nests_overactive",
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
		rollover_text = T(272691265125, --[[ModItemNotificationPreset dis_nests_overactive rollover_text]] "The nearby nests are all working together and spawning attack after attack. We need to kill <nests_left()> to break their communications!"),
		save_in = "Mod/TGkJ3Tu",
		text = T(947183453884, --[[ModItemNotificationPreset dis_nests_overactive text]] "Nest's are Overactive!"),
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Expeditions",
	'NameColor', RGBA(126, 214, 232, 255),
}, {
	PlaceObj('ModItemExpeditionPreset', {
		DisplayImage = "UI/Messages/Expeditions/exp_meteorite_falling",
		Expiration = 4800000,
		FoundByExploration = true,
		FoundByExplorationDisplayText = T(334501410635, --[[ModItemExpeditionPreset NA_Exped_Shrieker_Nest FoundByExplorationDisplayText]] "A falling meteor was spotted nearby!"),
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/meteorite_falling",
		OneInstanceOnly = true,
		Prerequisites = {
			PlaceObj('CheckOR', {
				Conditions = {
					PlaceObj('CheckTech', {
						Tech = "FieldShrieker",
					}),
					PlaceObj('CheckExpression', {
						EditorViewComment = "one Shrieker nest awoken",
						Expression = function (self, obj)
							return MapCount(true,'TerritorialNest', function(nest) if nest.state ~= 'inactive' and nest.entity == 'AlienSphere_Shape_05' then return true end end) > 0
						end,
					}),
				},
			}),
		},
		RelevantSkills = set( "Combat", "Construction", "Crafting", "Farming", "Physical" ),
		StoryBits = {
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Broken_Shrieker_Nest",
				'Weight', 50,
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Food_Pile_Shrieker_Nest",
				'Weight', 50,
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "World_War_Insect",
				'Weight', 50,
			}),
		},
		UILineColor = 4293083197,
		description = T(219489814974, --[[ModItemExpeditionPreset NA_Exped_Shrieker_Nest description]] "A meteorite fell in this area."),
		display_name = T(769211153498, --[[ModItemExpeditionPreset NA_Exped_Shrieker_Nest display_name]] "A shooting star"),
		id = "NA_Exped_Shrieker_Nest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemFolder', {
		'name', "Shrieker Nest Events/Outcomes",
		'NameColor', RGBA(33, 229, 0, 255),
	}, {
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Delay = 4000,
			Enabled = true,
			FxAction = "UINotificationExpedition",
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
			NotificationText = T(676096752128, --[[ModItemStoryBit Broken_Shrieker_Nest NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			PopupFxAction = "MessagePopup",
			ScriptDone = true,
			SelectObject = false,
			Text = T(493932761411, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I found the landing site, and lots of dead Shriekers strewn around. And large shards of black and red claylike material! \nThe meteor must have landed on top of a humungous nest of creatures!\n\nAll that's left of the nest is two protruding pillars partially exposed that look like horns from a distance.\n\nThese must be the strongest pillars of the nest.\nAnd their vibrations are hurting my head!\n\nWhat should I do?"),
			Title = T(483107297188, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "[The Nests Awaken] Broken Nest"),
			comment = "Disaster trigger option",
			group = "Expedition_FollowUP",
			id = "Broken_Shrieker_Nest",
			max_reply_id = 12,
			qa_info = PlaceObj('PresetQAInfo', {
				Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Vihar on 2020-Oct-14\nModified by Ivan on 2020-Dec-21\nModified by Ivan on 2021-Jan-06\nModified by Vihar on 2021-Jan-06\nModified by Gaby on 2021-Jan-07\nModified by Lina on 2021-Jan-11\nModified by Ivan on 2021-Feb-11\nModified by Bobby on 2021-May-20\nModified by Lina on 2021-Aug-19\nModified by Lina on 2021-Aug-23\nModified by Lina on 2021-Aug-24\nModified by Lina on 2021-Aug-31\nModified by Lina on 2021-Sep-02\nModified by Gaby on 2021-Sep-03\nModified by Lina on 2021-Dec-17\nModified by Lina on 2022-Jan-07\nModified by Xaerial on 2022-Oct-10",
				param_bindings = false,
			}),
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				HideIfDisabled = true,
				Prerequisites = {
					PlaceObj('CheckSkillInclination', {
						Inclination = "Forbidden",
						Negate = true,
						Skill = "Combat",
						param_bindings = false,
					}),
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return not MapVarValues['nest_disaster'] end,
						param_bindings = false,
					}),
				},
				Text = T(926625800729, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "Shoot the pillars, bring them down!"),
				param_bindings = false,
				unique_id = 10,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar("nest_disaster_species","ShriekerNest")
							CreateGameTimeThread(function()
							local delay_days = AsyncRand(3)
							local d_dur = const.DayDuration
							Sleep(delay_hours * d_dur)
							ForceActivateStoryBit('begin_nest_disaster')
							return end)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Text = T(329248656624, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I tried to damage the pillars with what I had...\nBut these pillars are made of stern stuff!\n\nWorse still, the pillars are now vibrating so loud it is starting to hurt.\nI'm getting out of here before I start to go deaf!\n<style TextNegative>The consequences of this action will occur in due time</style>"),
				Title = T(573170111095, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Pillar's are louder!"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				PrerequisiteText = "",
				Text = T(826795568152, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "Lash the pillars together and silence them!"),
				param_bindings = false,
				unique_id = 8,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 100000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Physical",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Construction",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(702067002755, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I managed to scavenge some of the nests own material to bind the pillars together.\nCombined with some thick reeds nearby to lash them together.\n\nAs soon as there was continuous nest material connecting the pillars, the vibrations stopped.\n\nHopefully this will get us something we want.\n\n<em>Local Shrieker Nest aggression levels lowered.</em>\n<em>Carbon Nanotubes Gained</em>"),
				Title = T(250769668217, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Pillar's Stopped"),
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
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">",
								Skill = "Physical",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">",
								Skill = "Construction",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Physical",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Construction",
								param_bindings = false,
							}),
						},
						Negate = true,
						param_bindings = false,
					}),
				},
				Text = T(695821266966, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I felled a few small trees and tried to bind them around the pillars.\n\nEven though they are touching, they still vibrate.\n\nI am going to take some of the nest material back with me.\nIt feels weird but doesn't look very natural....\n\n<em>Local Shrieker Nest aggression levels raised.</em>\n<em>Carbon Nanotubes Gained</em>"),
				Title = T(636542954862, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Pillar's Not Stopped"),
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
							Aggression_up('ShriekerNest')
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">",
								Skill = "Physical",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">",
								Skill = "Construction",
								param_bindings = false,
							}),
						},
						Negate = true,
						param_bindings = false,
					}),
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Physical",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = ">",
								Skill = "Construction",
								param_bindings = false,
							}),
						},
						Negate = true,
						param_bindings = false,
					}),
				},
				Text = T(442233584296, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I tried to tie them together, but nothing I could move would make them budge!!\n\nI'll gather up some of scraps and shards.\nHopefully the vibrations don't mean much....\n\n<em>Local Shrieker Nest aggression levels raised twice.</em>\n<em>Carbon Nanotubes Gained</em>"),
				Title = T(612377216813, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Pillar's not stopped"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(184256034270, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "Look for and help the survivors"),
				param_bindings = false,
				unique_id = 11,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Sniping_Entropy_Shielded_Shrieker')
							Aggression_down('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckAND', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Healing",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(842855697422, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I found a nearby Shrieker that had flung far away from the nest.\nIt's tail was bent at a very wrong angle, and it's exoskeleton was leaking fluid, so it was in no position to stop me from doing anything.\n\nI nursed it back to health, and it now follows me!\nLet's see if these things get altitude sickness!\n\n<em>A high tier Shrieker will be brought back from this expedition.</em>\n<em>Local Shrieker Nest aggression levels lowered.</em>"),
				Title = T(341052381042, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Found a wounded Shrieker!"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Entropic_Shrieker')
							Aggression_down('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckAND', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Healing",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(814318562989, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "It took me a while to find a Shrieker that wasn't hurt so much I couldn't to heal it, but not healthy enough to fight me off.....\n\nI did find one and nursed it back to health.\nBut it's not one of the biggest one's I saw.\n\n<em>A medium tier Shrieker will be brought back from this expedition</em>\n<em>Local Shrieker Nest aggression levels lowered.</em>"),
				Title = T(323773298695, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Found a wounded Shrieker!"),
				Weight = 400,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 75000,
						Resource = "RawMeatInsect",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 30000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Text = T(467152558503, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "Most of the Shriekers I found where too far gone to even attempt to help.\nLet alone tame.\n\nThat being said, I made sure to butcher and scavenge some of the shards.\n\n<em>Local Shrieker Nest aggression levels raised.</em>\n<em>Carbon Nanotubes Gained</em>\n<em>Insect Meat Gained</em>"),
				Title = T(935055858908, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Did not save any Shriekers"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				PrerequisiteText = "",
				Text = T(635825711080, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "Hunt the survivors down!"),
				param_bindings = false,
				unique_id = 12,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "RawMeatInsect",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 90000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Bruise_Common",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Bruise_Common",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "CrackedSkull_Common",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 7,
								Condition = "<=",
								Skill = "Combat",
								param_bindings = false,
							}),
							PlaceObj('CheckRandom', {
								Chance = 30,
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(282308119094, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] 'I hunted and found some Shriekers that survived the crash.\nDang things put up a fight, but I killed all I could find!\n\nThe noises they made when they die makes me realize how apt the name "Shriekers" is for em!\n\nI even scrounged and took some of their nest structure to research!\n<em>Local Shrieker Nest aggression levels raised twice.</em>\n<em>Carbon Nanotubes Gained</em>\n<em>Insect Meat Gained</em>'),
				Title = T(334334388120, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "A dead Shrieker is a good Shrieker"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_TailStab",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ShriekerHorns.jpg",
				Text = T(163964550429, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "There were.... too many....\n\nI got the drop on the first thing, but when it yelled I heard them coming from all over.\n\nI started running once I saw the 4th appear.\nThankfully they weren't smart enough to target the Balloon, or I'd be dead already.\n\n<em>Local Shrieker Nest aggression levels raised.</em>"),
				Title = T(804168191504, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "Wounded and retreating"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(289518266882, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "<style TextPositive>Safely</style> scavenge from a distance"),
				param_bindings = false,
				unique_id = 9,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 30000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
				},
				Text = T(283986861030, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I scavenged some outlying nest structures.\n\nIt's not much, but I didn't get hurt\n\n<em>Carbon Nanotubes Gained</em>"),
				Title = T(315621291031, --[[ModItemStoryBit Broken_Shrieker_Nest Title]] "I scavenged"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Delay = 4000,
			Enabled = true,
			FxAction = "UINotificationExpedition",
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
			NotificationText = T(659084137633, --[[ModItemStoryBit Food_Pile_Shrieker_Nest NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			PopupFxAction = "MessagePopup",
			ScriptDone = true,
			SelectObject = false,
			Text = T(432054219238, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "I found where the meteor landed, but what greeted me was very pungent.\n\nMy nose was assaulted with the smell of burnt-to-a-crisp dog food.\nAnd there was a conga line of Shriekers running to the pile.\nEach would dive in, and leave with a pile of (often still on fire) this gunk.\n\nWhat... what should I do?!?!"),
			Title = T(320487496148, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "[The Nests Awaken] A pile of burnt... food?"),
			comment = "Expedition -- Skill increase",
			group = "Expedition_FollowUP",
			id = "Food_Pile_Shrieker_Nest",
			max_reply_id = 17,
			qa_info = PlaceObj('PresetQAInfo', {
				Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Vihar on 2020-Oct-14\nModified by Ivan on 2020-Dec-21\nModified by Ivan on 2021-Jan-06\nModified by Vihar on 2021-Jan-06\nModified by Gaby on 2021-Jan-07\nModified by Lina on 2021-Jan-11\nModified by Ivan on 2021-Feb-11\nModified by Bobby on 2021-May-20\nModified by Lina on 2021-Aug-19\nModified by Lina on 2021-Aug-23\nModified by Lina on 2021-Aug-24\nModified by Lina on 2021-Aug-31\nModified by Lina on 2021-Sep-02\nModified by Gaby on 2021-Sep-03\nModified by Lina on 2021-Dec-17\nModified by Lina on 2022-Jan-07\nModified by Xaerial on 2022-Oct-10",
				param_bindings = false,
			}),
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(752976472411, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "Observe how the Shriekers work together"),
				param_bindings = false,
				unique_id = 13,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('SetSkillLevel', {
						Level = 7,
						Skill = "Intellectual",
						param_bindings = false,
					}),
					PlaceObj('SetSkillInclination', {
						Inclination = "Interested",
						Skill = "Intellectual",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Prerequisites = {
					PlaceObj('CheckSkillLevel', {
						Amount = 6,
						Condition = "<=",
						Skill = "Intellectual",
						param_bindings = false,
					}),
				},
				Text = T(106151430908, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "The Shriekers moved like a well choreographed dance group.\nEach one flicking it's tail to perfectly move what food drops off it's carapace onto the Shrieker behind it.\nIt more I watched, the more enthralled I was.\n\nEventually after all the food was long gone I was able to collect myself start the return journey.\nBut I cannot keep my mind off of what other wonders the universe has....\n\nI must keep looking for more things like this.... I MUST!\n\n<em>This character now has an Intellectual skill of 7 and is interested in Intellectual activities.</em>"),
				Title = T(298740240290, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Stolen Piece"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							all_skills_up(obj)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Text = T(335238353172, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "The Shriekers where very well coordinated and single focused.\nNearby Drakas stood in a trance, but the Shriekers did not pursue or attack.\nI could sense the trance encroaching my mind the more I watched the Shriekers.\n\nI did not succumb, and my mind was sharpened by the trial.\nI now feel more capable in all things because of it.\n\n<em>This colonist has gained +1 to all skills, unless the skill is maxxed or indifferent</em>"),
				Title = T(160304860392, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Stolen Piece"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(835762142336, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "Quickly grab the best sample you can!"),
				param_bindings = false,
				unique_id = 14,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('SetSkillLevel', {
						Level = 7,
						Skill = "Intellectual",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Prerequisites = {
					PlaceObj('CheckSkillLevel', {
						Amount = 4,
						Condition = ">=",
						Skill = "Physical",
						param_bindings = false,
					}),
				},
				Text = T(327854680802, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "I dashed in and when I was close, I bent down to pick up some of the cleaner looking pieces.\n\nI had to stop because that stuff is super slippery! I could barely hold onto it. This also got me a few spikes in the back as the Shriekers started closing in.....\n\nI couldn't exactly run with this slick & slimy stuff, so I did the next best thing..... I ate it.....\n\nMy legs managed to get me to my ride home!\nBut now I can't help but feel..... wayyyyyy too full. \nLike I ate 10 meals in those few bites I got.\nHope this is the only side effect....\n\n<em>This colonist now needs 80% less food but moves 20% slower.</em>\n<em>Local Shrieker Nest aggression levels raised.</em>"),
				Title = T(808455532347, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Stolen... Bread?"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
							Aggression_yp("ShriekerNest")
						end,
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "hidden",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "locked",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Text = T(880426466168, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "Well I ran in as best I could.\nUnfortunately the Shriekers where alerted and started shooting quicker than I could dash in and out.\n\nI couldn't even make it to the pile.....\n\nI did patch myself up as much as I could and waited for the Shriekers to be done.\nSo I have a sample... just a very burnt one.\nBringing it home with me.\n\n<em>Local Shrieker Nest aggression levels raised twice.</em>"),
				Title = T(601836334546, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Failed to get fresh sample"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(409109555755, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "Trap the path the Shriekers took and collect the spoils"),
				param_bindings = false,
				unique_id = 15,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "hidden",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "locked",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "RawMeatInsect",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 40000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Construction",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Combat",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(239211206803, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "I made sure to track their path from the comet, and lo and behold there was a small clearing that had a well worn path back to their nest.\n\nNo sentries either, dumb bugs don't know how to handle guerrilla warfare.\nThere was even a small nest building that I looted after I made sure all the Shriekers where dead!\n\nI'm coming back with some of that really slippery food and enough bug meat to last a winter!\n\n<em>Local Shrieker Nest aggression levels raised twice.</em>\n<em>Carbon Nanotubes Gained</em>\n<em>Insect Meat Gained</em>\n<em>New breakthrough research available</em>"),
				Title = T(191968638200, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Got some spoils!"),
				Weight = 450,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Sniping_Entropy_Shielded_Shrieker')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Crafting",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(662410562178, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "I used my skills to set up a live trap.\n\nI hid it in a clearing that had a good path from the Shriekers going to the meteor.\n\nI sat with it and got it tamed, and it's coming back with me.\nI didn't get any food, but the Shrieker I did get is a beast. One of the biggest ones I've seen!\n\n<em>A high tier Shrieker will be brought back from this expedition.</em>"),
				Title = T(572094894653, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Got a live specimen!"),
				Weight = 450,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "hidden",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "locked",
						PresetId = "Shrieker_food_scraps",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('AddRemoveHealthCondition', {
						HealthCond = "Shrieker_SpikePuncture",
						HealthCondType = "Injury",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/pile of food.jpg",
				Text = T(365940755626, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "Well I ran in as best I could.\nUnfortunately the Shriekers where alerted and started shooting quicker than I could dash in and out.\n\nI couldn't even make it to the pile.....\n\nI did patch myself up as much as I could and waited for the Shriekers to be done.\nSo I have a sample... just a very burnt one.\nBringing it home with me.\n\n<em>Local Shrieker Nest aggression levels raised twice.</em>\n<em>New breakthrough research available</em>"),
				Title = T(978230562876, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "Failed to get fresh sample"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(186402334417, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "<style TextPositive>Safely</style> scavenge from a distance"),
				param_bindings = false,
				unique_id = 17,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 30000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
				},
				Text = T(954570739174, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Text]] "I scavenged some outlying nest structures.\n\nIt's not much, but I didn't get hurt\n\n<em>Carbon Nanotubes Gained</em>"),
				Title = T(202713456976, --[[ModItemStoryBit Food_Pile_Shrieker_Nest Title]] "I scavenged"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Delay = 4000,
			Enabled = true,
			FxAction = "UINotificationExpedition",
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
			NotificationText = T(377903967280, --[[ModItemStoryBit World_War_Insect NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			PopupFxAction = "MessagePopup",
			ScriptDone = true,
			SelectObject = false,
			Text = T(166675964945, --[[ModItemStoryBit World_War_Insect Text]] 'As I flew in the crater left by the meteor is massive!\nIt broke into 4 "smaller" pieces with each piece being a fully functional Shrieker nest!\n\nI can see in the crash debris what\'s left of a Deathfly Mating Spire, and the Deathfly\'s have decided to greet their new neighbors with appropriate force!\n\nNot to leave a new neighbor un-greeted, the commotion has also roused a nearby mound of Scissorhands.\n\nI\'m afraid to fly even closer, lest I cannot even get home!\nWhat do I do?!?!?'),
			Title = T(968759677777, --[[ModItemStoryBit World_War_Insect Title]] "[The Nests Awaken] World War Insect?"),
			group = "Expedition_FollowUP",
			id = "World_War_Insect",
			max_reply_id = 20,
			qa_info = PlaceObj('PresetQAInfo', {
				Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Vihar on 2020-Oct-14\nModified by Ivan on 2020-Dec-21\nModified by Ivan on 2021-Jan-06\nModified by Vihar on 2021-Jan-06\nModified by Gaby on 2021-Jan-07\nModified by Lina on 2021-Jan-11\nModified by Ivan on 2021-Feb-11\nModified by Bobby on 2021-May-20\nModified by Lina on 2021-Aug-19\nModified by Lina on 2021-Aug-23\nModified by Lina on 2021-Aug-24\nModified by Lina on 2021-Aug-31\nModified by Lina on 2021-Sep-02\nModified by Gaby on 2021-Sep-03\nModified by Lina on 2021-Dec-17\nModified by Lina on 2022-Jan-07\nModified by Xaerial on 2022-Oct-10",
				param_bindings = false,
			}),
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Comment = "Combat Experience",
				CustomOutcomeText = T(338811045314, --[[ModItemStoryBit World_War_Insect CustomOutcomeText]] "Combat Increase"),
				HideIfDisabled = true,
				Prerequisites = {
					PlaceObj('CheckSkillInclination', {
						Inclination = "Forbidden",
						Negate = true,
						Skill = "Combat",
						param_bindings = false,
					}),
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return not MapVarValues['nest_disaster'] end,
						param_bindings = false,
					}),
				},
				Text = T(128075964429, --[[ModItemStoryBit World_War_Insect Text]] "Shoot at who you can, leave when something tries to respond"),
				param_bindings = false,
				unique_id = 17,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('SetSkillLevel', {
						Level = 10,
						Skill = "Combat",
						param_bindings = false,
					}),
					PlaceObj('SetSkillInclination', {
						Inclination = "Interested",
						Skill = "Combat",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Text = T(394429963567, --[[ModItemStoryBit World_War_Insect Text]] 'This was the closest I will ever get to that Earth saying "Shooting Fish in a Barrel"!\n\nThe Shriekers and Scissorhands didn\'t know what was killing them off!\nMy ammunition is now spent, but I feel like I will do better the next time we are attacked!\n\n<em>This colonists combat skill set to 10 and is now interested in combat.</em>'),
				Title = T(293846749365, --[[ModItemStoryBit World_War_Insect Title]] "Combat Experience"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Comment = "Aly Tame based on Farming lvl",
				CustomOutcomeText = T(133161655557, --[[ModItemStoryBit World_War_Insect CustomOutcomeText]] "Chance to gain random high tier tamed unit"),
				Text = T(630139695694, --[[ModItemStoryBit World_War_Insect Text]] "Land at a distance, and heal some of the creatures fleeing"),
				param_bindings = false,
				unique_id = 15,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Sniping_Entropy_Shielded_Shrieker')
							Aggression_down('ShriekerNest')
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Prerequisites = {
					PlaceObj('CheckAND', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Healing",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(409626888358, --[[ModItemStoryBit World_War_Insect Text]] "I found a nearby Shrieker that was extremely wounded.\nThe Scissorhand blades had sliced thin but very deep gashes in the Shriekers exoskeleton.\n\nIt was in no position to fight back and thankfully, I managed to seal the wounds to prevent further liquid loss.\n\n<em>A high tier Shrieker will be brought back from this expedition.</em>\n<em>Local Shrieker Nest aggression levels lowered.</em>\n<em>Local Scissorhand Nest aggression levels increased.</em>"),
				Title = T(717767014088, --[[ModItemStoryBit World_War_Insect Title]] "Found a wounded Shrieker!"),
				Weight = 750,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Rage_Focused_Scissorhands')
							Aggression_up('ShriekerNest')
							Aggression_down('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Prerequisites = {
					PlaceObj('CheckAND', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Healing",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(200284404991, --[[ModItemStoryBit World_War_Insect Text]] "I found a nearby Scissorhand that was extremely wounded.\nShrieker spikes and their venomous payloads easily breach the Scissorhands carapace.\n\nIt was in no position to fight back and thankfully, I managed to seal the wounds to prevent further liquid loss.\n\n<em>A high tier Scissorhands will be brought back from this expedition.</em>\n<em>Local Scissorhand Nest aggression levels lowered.</em>\n<em>Local Shrieker Nest aggression levels increased.</em>"),
				Title = T(463533421705, --[[ModItemStoryBit World_War_Insect Title]] "Found a wounded Shrieker!"),
				Weight = 750,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Brutal_Duelist_Scissorhands')
							Aggression_down('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Prerequisites = {
					PlaceObj('CheckAND', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckSkillLevel', {
								Amount = 5,
								Condition = ">=",
								Skill = "Healing",
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(904667923008, --[[ModItemStoryBit World_War_Insect Text]] "The Scissorhands are proving to be not much of a match against the Shriekers. Those thin spikes pierce right through their hard to blast shells.\n\nLuckily this means there are ample pinned Scissorhands in various stages of hurt.\n\nI kept away from one's blades and cleaned it up. After it got some food it's ready to follow me home!\n\n<em>A medium tier Scissorhands will be brought back from this expedition</em>\n<em>Local Shrieker Nest aggression levels increased.</em>\n<em>Local Scissorhands Nest aggression levels lowered.</em>"),
				Title = T(895673775962, --[[ModItemStoryBit World_War_Insect Title]] "Found a wounded Scissorhands"),
				Weight = 400,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ShriekerNest')
							Aggression_down('ScissorhandsNest')
							local current_skill = obj:GetSkillLevel('Healing')
							if current_skill < 8 then
								obj:SetSkillLevel(id,current_skill+2,'silent')
							elseif current_skill == 9 then
								obj:SetSkillLevel(id,current_skill+1,'silent')
							end
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Text = T(913912138672, --[[ModItemStoryBit World_War_Insect Text]] "There is a lot of wounded, and I could not find any stragglers that I could save.\n\nI waded my way into some of the lighter skirmishes away from the Deathflies.\nThankfully my scent was masked by the smell of death and guts, and I went largely unnoticed.\n\nI patched up both Scissorhands and Shriekers and slipped out.\n<em>Local Shrieker Nest aggression levels lowered.</em>\n<em>Local Scissorhands Nest aggression levels lowered.</em>\n<em>Colonists Healing Skill increased by 2</em>"),
				Title = T(850355051619, --[[ModItemStoryBit World_War_Insect Title]] "Found a wounded Scissorhands"),
				Weight = 50,
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Comment = "Raise Intellegence + Personal Dodge chance",
				Text = T(776607328794, --[[ModItemStoryBit World_War_Insect Text]] "Observe the war from a distance"),
				param_bindings = false,
				unique_id = 18,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveTrait', {
						Trait = "war_observer",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Text = T(579234739056, --[[ModItemStoryBit World_War_Insect Text]] "You ever watch those old war TV shows?\nI did once or twice, and what I see on the ground looks.... eerily similar.\n\nBlocks of insects are moving together.\nNot as individuals, but like a military squad.\n\nTheir spitting, slicing, and shooting are all little blurs from this high. But I see how they are targeting now.\n\nBefore I would give the chances of me not getting hit by a Shrieker spike ~10%. But now I think I would fare much better!\n\n<em>This colonist now has a trait that gives them a +15% chance to dodge against incoming Shriekers/Scissorhands/Deathflys attacks</em>"),
				Title = T(149456348331, --[[ModItemStoryBit World_War_Insect Title]] "Found a wounded Scissorhands"),
				Weight = 50,
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Comment = "Chance to die, chance to max combat and gain combat bonuses",
				Text = T(430308561174, --[[ModItemStoryBit World_War_Insect Text]] "<style TextNegative>DANGEROUS</style> Answer the call to war! Wade in death!"),
				param_bindings = false,
				unique_id = 19,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveTrait', {
						Trait = "became_death",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 9,
								Condition = ">=",
								Skill = "Combat",
								param_bindings = false,
							}),
							PlaceObj('CheckRandom', {
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(184098389550, --[[ModItemStoryBit World_War_Insect Text]] "I do not know how. I do not know why.\nI just know that the second I touched the ground I was overcome by a red rage.\n\nNow that I am back in control, all I see around me is death.\nShriekers.... Scissorhands... Deathflies....\n\nNothing moves except me.\nThis will be a place \n\n\n<em>This colonist now has a trait that gives them a high dodge chance against Shriekers/Scissorhands/Deathflys!</em>"),
				Title = T(992211123211, --[[ModItemStoryBit World_War_Insect Title]] "I am become death!"),
				Weight = 50,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveTrait', {
						Trait = "Almost_died",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect_War.jpg",
				Text = T(757712491412, --[[ModItemStoryBit World_War_Insect Text]] "<style TextNegative>You see the balloon rise and start heading your way.\nYou have not seen or heard from the colonist who left.</style>\n\n<em>This colonist is gravely wounded, and will be permanently scarred for their attempt to join a war.</em>"),
				Title = T(753509255013, --[[ModItemStoryBit World_War_Insect Title]] "I am become death!"),
				Weight = 50,
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(242509817721, --[[ModItemStoryBit World_War_Insect Text]] "<style TextPositive>Safely</style> scavenge from a distance"),
				param_bindings = false,
				unique_id = 20,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 30000,
						Resource = "CarbonNanotubes",
						param_bindings = false,
					}),
				},
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemTech', {
			Description = T(406017788342, --[[ModItemTech Shrieker_food_scraps Description]] "Even though the samples we had where burnt beyond a crisp, we have made some progress on analyzing the foodstuff.\n\nThis stuff reacts with the unique acid in Shrieker stomachs to increase in mass and coat the stomach lining. What this means is the Shriekers stay fuller for longer!\n\nWe will include in our meals a small portion of both this and Shrieker acid to replicate this or us!\n<em>Colonists will need to eat 20% less food each day</em>\n<em>Colonists will now need to eat 20% less food each day</em>"),
			DisplayName = T(380755387109, --[[ModItemTech Shrieker_food_scraps DisplayName]] "Burnt Shrieker Scraps"),
			Icon = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/BurntFood.jpg",
			LockState = "locked",
			MinSkillLevel = 5,
			ResearchPoints = 10000,
			group = "Breakthroughs",
			id = "Shrieker_food_scraps",
			save_in = "Mod/TGkJ3Tu",
			tradable = false,
			PlaceObj('AttachEffectsToLabel', {
				Effects = {
					PlaceObj('ModifyHuman', {
						Id = "autoid4",
						mul = 800,
						prop = "EnergyUsePerDay",
					}),
				},
				Id = "autoid_TGkJ3Tu_Scov3S",
				Label = "Survivors",
			}),
		}),
		PlaceObj('ModItemTrait', {
			Description = T(123449376263, --[[ModItemTrait war_observer Description]] "This colonist has seen Scissorhands,Shriekers, & Deathflies fight en masse. Has a 15% increased dodge chance against their attacks."),
			DisplayName = T(655543368461, --[[ModItemTrait war_observer DisplayName |gender-variants]] "World War Observer"),
			id = "war_observer",
			save_in = "Mod/TGkJ3Tu",
			unit_reactions = {
				PlaceObj('UnitReaction', {
					Event = "AvoidAttackModify",
					Handler = function (self, target, hit_chance, attacker, weapon_def, attacker_dist)
						local a = get_stop(attacker)
						if  a and (a== 'Dragonfly' or a=='Shrieker' or a=='Scissor') then
							return hit_chance - 15
						else
							return hit_chance
						end
					end,
				}),
			},
		}),
		PlaceObj('ModItemTrait', {
			Description = T(879196938667, --[[ModItemTrait became_death Description]] "Ended an entire insect world war... though they are quiet to explain how. 40% harder to hit, attacks 75% faster"),
			DisplayName = T(497221506948, --[[ModItemTrait became_death DisplayName |gender-variants]] "World War Ender"),
			id = "became_death",
			save_in = "Mod/TGkJ3Tu",
			unit_reactions = {
				PlaceObj('UnitReaction', {
					Event = "AvoidAttackModify",
					Handler = function (self, target, hit_chance, attacker, weapon_def, attacker_dist)
						return hit_chance - 40
					end,
				}),
				PlaceObj('UnitReaction', {
					Event = "ModifyAttackCooldown",
					Handler = function (self, target, cooldown, weapon_def)
						return DivRound(cooldown*3,4)
					end,
				}),
			},
		}),
		PlaceObj('ModItemTrait', {
			Description = T(237010685334, --[[ModItemTrait Almost_died Description]] "Noone knows how this colonist lived on near suicide mission.... but they are now reminded of their attempt every day."),
			DisplayName = T(414856051314, --[[ModItemTrait Almost_died DisplayName |gender-variants]] "Near-Death Experience"),
			Modifiers = {
				PlaceObj('ModifyHuman', {
					Id = "autoid_TGkJ3Tu_JtASWH",
					mul = 900,
					prop = "Manipulation",
				}),
				PlaceObj('ModifyHuman', {
					Id = "",
					mul = 1300,
					prop = "RelaxationLossPerDay",
				}),
			},
			id = "Almost_died",
			save_in = "Mod/TGkJ3Tu",
		}),
		PlaceObj('ModItemTrait', {
			DisplayName = T(828366165529, --[[ModItemTrait ate_shrieker_food_bad DisplayName |gender-variants]] "Ate Shrieker Food"),
			Modifiers = {
				PlaceObj('ModifyHuman', {
					Id = "autoid_TGkJ3Tu_LTumaMc",
					mul = 800,
					prop = "EnergyUsePerDay",
				}),
				PlaceObj('ModifyHuman', {
					Id = "autoid_TGkJ3Tu_iyVXK7q",
					add = -20000,
					prop = "Movement",
				}),
			},
			id = "ate_shrieker_food_bad",
			save_in = "Mod/TGkJ3Tu",
		}),
		}),
	PlaceObj('ModItemExpeditionPreset', {
		DisplayImage = "UI/Messages/Expeditions/exp_tunnel",
		Expiration = 4800000,
		FoundByExploration = true,
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/tunnel",
		OneInstanceOnly = true,
		Prerequisites = {
			PlaceObj('CheckOR', {
				Conditions = {
					PlaceObj('CheckTech', {
						Tech = "FieldShrieker",
					}),
					PlaceObj('CheckExpression', {
						EditorViewComment = "one Scissorhand nest awoken",
						Expression = function (self, obj)
							return MapCount(true,'ScissorhandsNest', function(nest) if nest.state ~= 'inactive' then return true end end) > 0
						end,
					}),
				},
			}),
		},
		StoryBits = {
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Scissorhand_Mating_event",
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Single_Occupant_Scissor_Nest",
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "HungryPest_Start",
			}),
		},
		UILineColor = 4293083197,
		description = T(159309559536, --[[ModItemExpeditionPreset NestAwaken_Exp_Scissorhand_Nest description]] "We have triangulated localized seismic activity to a nearby tropical region."),
		id = "NestAwaken_Exp_Scissorhand_Nest",
		mod_version_major = 1,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemFolder', {
		'name', "Scisshands Nest Events/Outcomes",
		'NameColor', RGBA(187, 0, 255, 255),
	}, {
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Sage_Nest_.PNG",
			NotificationText = T(516957375298, --[[ModItemStoryBit Single_Occupant_Scissor_Nest NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			OneTime = false,
			SelectObject = false,
			Text = T(452416333956, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "We tracked the earthquake to the largest Shrieker Nest I have ever seen!\n\nMy nose was met with the stench of death.\nThe only living creature is a lone 10 ft tall Scissorhands, surrounded by dead Scissorhands.\nIt's shell is marred with.... slashes?!?\n\nWhat should I do?"),
			Title = T(110135522538, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
			id = "Single_Occupant_Scissor_Nest",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(348134983269, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "Set fire to the nest and deadly mega-creature"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 50000,
						Resource = "Silicon",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Sage_Nest_.PNG",
				Text = T(952630229771, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "I collected some kindling and started a small bonfire close to the nest.\nThankfully Scissorhand nests are flammable, and it quickly became a roaring inferno.\n\nThe Scissorhands just watched the fire approach and continued to consume it's kills. Even after it was clearly burning alive, it seemed unfazed.\nThe smoke and falling nests eventually obscured my view, but there's no way it survived.... right?\n\n<em>Local Scissorhand Nest aggression levels lowered.\nSilicon Gained</em>"),
				Title = T(317666994399, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(937138689778, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "Try to appease it and scavenge the nests"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveTrait', {
						Trait = "scissor_mentored",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							local ten_percent = DivRound(obj.MaxHealth,10)
							obj.Health=ten_percent
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Sage_Nest_.PNG",
				Text = T(423176444969, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "After catching the Scissorhands attention; I placed some of my belongings in front of me and stepped back.\nI then pointed to the giant nest behind it.\nThe Scissorhands promptly rushed and pinned me down with a stab in the leg. It then to bleed me near dry.\n\nIn my now delirious state, it then tried to finish the job!\nBut without much blood to offset my body releasing adrenaline, I found myself able to dodge better!\n\nAfter what felt like an eternity of misses, the Scissorhands abruptly went back to it's kills.\nI had to crawl back to my ride home, but I lived....\n\n<em>Colonist gains a trait granting dodge chance in close combat.</em>"),
				Title = T(874737609244, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(197408347660, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "Attempt to tame it"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Rage_Focused_Scissorhands')
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Sage_Nest_.PNG",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckRandom', {
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(925598054324, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "I managed to find some food to tame it (That wasn't it's fellow Scissorhands), and started to slowly convince it life with me was better.\n\nI was interrupted when another group of Scissorhands returned to the nest; but the betrayer (The name I gave it) killed a few and ran the rest off.\n\nIt then almost gave me a look like it was ready to go.\nI'm not sure Scissorhands aren't smarter than they initially appeared.... at least this one.\n\nBringing it on home!\n\n<em>A high tier Scissorhands will be brought back from this expedition.\nLocal Scissorhand Nest aggression levels raised.</em>"),
				Title = T(495257948772, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Sage_Nest_.PNG",
				Text = T(755280989645, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "I couldn't find anything that wasn't a Scissorhand corpse to try and tame the scissorhand with.\n\nThe Scissohand seemed pretty insulted and started getting aggressive!\nTo make matters worse, a whole group of Scissorhands showed up and interrupted the taming.\n\nI got out of their before I ended up as either groups dinner! \n\n<em>Local Scissorhand Nest aggression levels raised.</em>"),
				Title = T(283482400818, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
				Weight = 10,
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(452993994446, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "Scavenge around the site, and avoid the beast"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 50000,
						Resource = "Silicon",
						param_bindings = false,
					}),
				},
				Text = T(763948926440, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "I made sure to always avoid that big bug, and it wandered around eating it's kills.\n\nLuckily that let me break down some nest structures for some Silicon.\n\n<em>Silicon Gained</em>"),
				Title = T(658257153764, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
			NotificationText = T(266833903346, --[[ModItemStoryBit Scissorhand_Mating_event NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			SelectObject = false,
			Text = T(828743778286, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I floated over the disturbance.\nIt a Scissorhand mega-colony!\n\nAs I continued to watch, each Scissorhand would stand in the center and dance. Sometimes turning to face another Scissorhand, or always look towards one.\n\nSometimes after one finishes dancing, it will pair off.\nThis must be the mating dance and possibly even ritual they do!\n\nWhat should I do?"),
			Title = T(526098361340, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
			id = "Scissorhand_Mating_event",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(387523332031, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Observe the Insects for any insights"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('AddRemoveTrait', {
						Trait = "Scissor_Exp_Animal_tamer",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
				Text = T(555886404386, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I watched with attention as each Scissorhands came to the center, and tried my best to sketch the different forms that they paused on.\n\nMy art skills meant it was a bunch of stick people with extra arms didn't help, but I think I have what I need.\n\nIf we have nearby Scissorhands (Or are attacked by them), I think I will better chance of taming them with the help of these!\n\n<em>This colonist now has a trait giving them greater efficiency when taming Scissorhands</em>"),
				Title = T(543906784848, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Mating Dance Discovered"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(161042252208, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Start a fire and destroy the site!"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_H7Agsu5",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Brute",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "scis_2",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Brute_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_TxVfgmd",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_UnjqwHo",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Hatchling",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_bJGvoLg",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Hatchling_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_UHTVmq4",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Hatchling_Starving",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_nFfrciY",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_EjUQRe5",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Scissorhands_Brute_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_uFX5wVV",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Brutal_Duelist_Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_ofwKQY3",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Rage_Focused_Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss-final",
						ModProperty = "MaxHealth",
						Mul = 800,
						ObjectClass = "Rage_Fueled_Scissorhand_Duelist",
						param_bindings = false,
					}),
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
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
				Text = T(714448102929, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I collected some kindling nearby, and then lined up dry wood to burn towards the site.\n\nThe fire quickly spread and engulfed everything!\n\nI must have left some sort of trail, because I've spotted Scissorhands behind my trail back home!\n\n<em>All Scissorhands now have -20% Max HP.\n<style TextNegative>The consequences of this action will occur in due time</style>"),
				Title = T(748425566629, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Mating Dance Discovered"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(350747133885, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Interrupt a mating and tame them instead!"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Rage_Focused_Scissorhands')
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
				Prerequisites = {
					PlaceObj('CheckOR', {
						Conditions = {
							PlaceObj('CheckSkillLevel', {
								Amount = 8,
								Condition = ">=",
								Skill = "Farming",
								param_bindings = false,
							}),
							PlaceObj('CheckRandom', {
								param_bindings = false,
							}),
						},
						param_bindings = false,
					}),
				},
				Text = T(568620839950, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Well I did interrupt the farthest pair from the nest.\nNot sure if this is how it works for all Scissorhands, but when they noticed me, one killed the other.\n\nSomething about being started and sharp blades are in awkward positions.....\n\nRegardless, I managed to convince the last one I was a friend and not food!\n\nSo hoisting it and bringing it back home!\n\n<em>A high tier Scissorhands will be brought back from this expedition.\nLocal Scissorhand Nest aggression levels raised.</em>"),
				Title = T(403295593988, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
				Weight = 1000,
				param_bindings = false,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ScissorhandsNest')
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
				Text = T(455547906131, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I thought I picked a pair that was far away from the nest.\nWhat I did not know was that there where other pairs nearby that spotted me while I was approaching.\n\nI barely had enough distance between me and the group of mega-predators to make it back to my ride home!\n\nI'm sure the Scissorhands did not like a random human wandering in....\n\n<em>Local Scissorhand Nest aggression levels raised twice.</em>"),
				Title = T(806289281069, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
				Weight = 10,
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(874392966327, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Scavenge what you can after everyone is paired"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "Silicon",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Mating.PNG",
				Text = T(986784585722, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I waited until the festivities died down and most of the Scissorhands where resting.\nThankfully the noise of the nest did not lower, so I could be a little more aggressive breaking down some of the larger pieces of nest that had fallen off.\n\nAfter filling my bags full multiple times, I am leaving feeling pretty pleased with myself!\n\n<em>Large trove of Silicon Gained</em>"),
				Title = T(391981441246, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
				Weight = 10,
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Amush.PNG",
			NotificationText = T(331213279531, --[[ModItemStoryBit Weak_scissor_hunting_pack NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(728012514068, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "I spotted a pack of weak Scissorhands laying in wait near a mountain tunnel.\nAll other Scissorhands most likely cannot ambush hunt due to evolution warping their carapace into vibrant colors.\n\nThey are perfectly still, and look relatively underfed.\nThey would be easy marks for a well equipped colonist, or respond well to food.\n\nHow to proceed?"),
			Title = T(189024014004, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
			id = "Weak_scissor_hunting_pack",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Prerequisites = {
					PlaceObj('CheckSkillInclination', {
						Inclination = "Forbidden",
						Negate = true,
						Skill = "Combat",
						param_bindings = false,
					}),
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return not MapVarValues['nest_disaster'] end,
						param_bindings = false,
					}),
				},
				Text = T(342086451258, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Kill these weaklings!"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ScissorhandsNest')
							local current_skill = obj:GetSkillLevel('Combat')
							if current_skill < 8 then
								obj:SetSkillLevel(id,current_skill+2,'silent')
							elseif current_skill == 9 then
								obj:SetSkillLevel(id,current_skill+1,'silent')
							end
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Amush.PNG",
				Text = T(721113194455, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "It was quite easy to deal with them.\nI landed, then threw rocks to distract each one individually.\nThen repeat, repeat, repeat.\n\nUsually the buggers know where we are, and we can't really hide.\nBut in this case I had to use more stealth than I'm used too.\nAnd I think that has gotten me better at fighting in general!\n\n<em>Colonists Combat Skill increased by 2.\nLocal Scissorhands Nest aggression levels raised.</em>"),
				Title = T(807015172525, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(122220266452, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Scare some nearby Draka through the tunnel"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ScissorhandsNest')
							local current_skill = obj:GetSkillLevel('Combat')
							if current_skill < 8 then
								obj:SetSkillLevel(id,current_skill+2,'silent')
							elseif current_skill == 9 then
								obj:SetSkillLevel(id,current_skill+1,'silent')
							end
						end,
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_1",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Brute",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_jadGwTg",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Brute_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_3",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_4",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Hatchling",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_5",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Hatchling_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_6",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Hatchling_Starving",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_7",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_8",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Scissorhands_Brute_Nesting",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_9",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Brutal_Duelist_Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "sciss_Up_10",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Rage_Focused_Scissorhands",
						param_bindings = false,
					}),
					PlaceObj('ModifyObject', {
						Id = "autoid_TGkJ3Tu_sNceqbL",
						ModProperty = "MaxHealth",
						Mul = 1200,
						ObjectClass = "Rage_Fueled_Scissorhand_Duelist",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Amush.PNG",
				Text = T(562560472062, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Once in position, all the scared Drakas immediately sprinted towards the tunnel.\nWhich looked safer than a new creature that's making scary noises!\n\nI lost count of how many I sent to their fate, because this was the best fun I've had in a long time!\n\nOn my way back I did noticed a MUCH larger group moving their kills... \nI wonder what that's about?\n\n<em>Local Scissorhands Nest aggression levels lowered.\nAll Scissorhands now have 20% higher Max HP.</em>"),
				Title = T(523964104823, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(375340601818, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Observe their hunting patterns"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "hidden",
						PresetId = "scissor_ambush",
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "locked",
						PresetId = "scissor_ambush",
						param_bindings = false,
					}),
					PlaceObj('SetLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						PresetId = "scissor_ambush",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Amush.PNG",
				Text = T(111565662082, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] 'I watched closely to how the Scissorhands hunt. \nEven the little ones seem to "know" when a Draka is about to come into vision.\n\nThe more I watched.... the more I could start to send it as well.\nIt is very hard to express in words.\nBut you can tell from the way the trees and grass move.\nVery faint, but once you notice the signs it is hard not too.\n\nI will do a better write up for a researcher to put fancy names to it!\n\n<em>A special research is unlocked which will grant powerful combat bonuses.</em>'),
				Title = T(100473465854, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(528761251147, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Drop food while leaving so they follow you"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							set_expedition_tame('Rage_Focused_Scissorhands')
							Aggression_up('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Scissor_Amush.PNG",
				Text = T(780712990055, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "I then flew right over them and dropped some fresh meat from some kills I made prior.\nThe little things seemed confused why food was literally dropping from the sky.\n\nI then started flying back home, and dropped piece after piece.\nThe Scissorhands followed, and are still following me!\n\nHopefully one or two are friendly and full by the time I get back!\n\n<em>A high tier Scissorhands will be brought back from this expedition.\nLocal Scissorhand Nest aggression levels raised.</em>"),
				Title = T(121387107697, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemTrait', {
			Description = T(390084024290, --[[ModItemTrait scissor_mentored Description]] "Having survived a close ordeal with a mega-Scissorhands, this colonist has a +30% chance to dodge attacks in melee combat!"),
			DisplayName = T(181182190895, --[[ModItemTrait scissor_mentored DisplayName |gender-variants]] "Survival of the Fittest"),
			id = "scissor_mentored",
			save_in = "Mod/TGkJ3Tu",
			unit_reactions = {
				PlaceObj('UnitReaction', {
					Event = "AvoidAttackModify",
					Handler = function (self, target, hit_chance, attacker, weapon_def, attacker_dist)
						if GetDist(target, attacker) < 10 then
							return hit_chance - 30
						else
							return hit_chance
						end
					end,
				}),
			},
		}),
		PlaceObj('ModItemTrait', {
			Description = T(741269100400, --[[ModItemTrait Scissor_Exp_Animal_tamer Description]] "This colonist has gained a better understanding of mating rituals on this planet, and is better at taming creatures."),
			DisplayName = T(436358241914, --[[ModItemTrait Scissor_Exp_Animal_tamer DisplayName |gender-variants]] "Animal Dance Interpretor"),
			id = "Scissor_Exp_Animal_tamer",
			save_in = "Mod/TGkJ3Tu",
			unit_reactions = {
				PlaceObj('UnitReaction', {
					Event = "ModifyActivityEfficiency",
					Handler = function (self, target, efficiency, activity_id, activity_obj, skill_level)
						if activity_id == 'Ranching' then
							return efficiency * 10
						end
					end,
				}),
			},
		}),
		PlaceObj('ModItemTech', {
			Description = T(221381325388, --[[ModItemTech scissor_ambush Description]] "A survivor watched how Scissorhands hunt, and the Scissorhands don't need to see their enemy to act. This lets them land hits right as the enemy walks into sight.\n\nLet's start practicing this!\n\n<em>Researching this will grant all colonists 1.2x times vision range and 20% added accuracy to attacks.</em>"),
			DisplayName = T(383868277397, --[[ModItemTech scissor_ambush DisplayName]] "Ambush Fire"),
			LockState = "hidden",
			ResearchPoints = 30000,
			group = "Breakthroughs",
			id = "scissor_ambush",
			save_in = "Mod/TGkJ3Tu",
			tradable = false,
			PlaceObj('AttachEffectsToLabel', {
				Effects = {
					PlaceObj('ModifyHuman', {
						Id = "",
						mul = 1200,
						prop = "SightRange",
					}),
					PlaceObj('ModifyHuman', {
						Id = "autoid5",
						add = 20,
						prop = "hit_chance_bonus",
					}),
				},
				Id = "scissor_ambush_bonus",
				Label = "Survivors",
			}),
		}),
		}),
	PlaceObj('ModItemExpeditionPreset', {
		DisplayImage = "UI/Messages/Expeditions/exp_dogfight",
		Expiration = 4800000,
		FoundByExploration = true,
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/dogfight_site",
		OneInstanceOnly = true,
		Prerequisites = {
			PlaceObj('CheckExpression', {
				EditorViewComment = "DLC loaded",
				Expression = function (self, obj) return Is_DLC_Present() end,
			}),
		},
		StoryBits = {
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Robot_Degraded_Prefab",
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Robot_Diplo_Miscomm",
			}),
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "Robot_Fake_Settlement",
			}),
		},
		UILineColor = 4293083197,
		description = T(449459407683, --[[ModItemExpeditionPreset NA_Exped_Robot_Nest description]] "An escape pod with flashing hazard lights landed nearby!"),
		display_name = T(307155733989, --[[ModItemExpeditionPreset NA_Exped_Robot_Nest display_name]] "An escape pod!"),
		id = "NA_Exped_Robot_Nest",
		mod_version_major = 1,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemFolder', {
		'name', "Robot Nest Events/Outcomes",
		'NameColor', RGBA(32, 181, 211, 255),
	}, {
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
			NotificationText = T(801489114182, --[[ModItemStoryBit Robot_Degraded_Prefab NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(613753515045, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "I landed and found a group of tattered Consortium buildings.\nBite, claw, and acid burns are on everything.\nRobots with missing arms and limbs are trying to fell trees and break nearby stone.\n\nThis looks like a small automated mining base, and I see a drop box. We can get this base back up and running... or salvage it... \n\nWhat should I do?"),
			Title = T(275666857275, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
			id = "Robot_Degraded_Prefab",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(467832956904, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "Break and Salvage these clankers!"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "Silicon",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_up('ConsortiumNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(507494139370, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "I stomped on what robots were still moving.\nThe buildings where so broken down a single solid kick toppled them.\n\nThere are a lot of blinking red lights that I couldn't break though.\nNot sure what that's about, but I'm coming back with quite a haul!\n\n<em>Local Consortium Nest aggression levels raised.\nLarge trove of Silicon Gained</em>\n"),
				Title = T(702156236008, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(516413203378, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "Get this base some resources!"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ConsortiumNest')
							local current_skill = obj:GetSkillLevel('Physical')
							if current_skill < 8 then
								obj:SetSkillLevel(id,current_skill+2,'silent')
							elseif current_skill == 9 then
								obj:SetSkillLevel(id,current_skill+1,'silent')
							end
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(949651270910, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "I broke all the nearby trees and rocks down.\nTook me the better part of a day, and I'm going to be sore for days.\n\nAfter the 3rd rock I dropped into the drop box, the building started to whir to life!\nAnd out came a brand new robot with a brand new teal pickaxe.\n\nIt glanced my way, but then went right to work picking up the rest of what I broke down. \n\nI left before the now buzzing base changed it's mind.\n\n<em>Colonists Physical Skill increased by 2.\nLocal Consortium Nest aggression levels lowered.</em>"),
				Title = T(986660128866, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(110741350059, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "Try and communicate with the base"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ConsortiumNest')
						end,
						param_bindings = false,
					}),
					PlaceObj('AttachEffectsToLabel', {
						Effects = {
							PlaceObj('ModifyHuman', {
								Id = "",
								mul = 500,
								param_bindings = false,
								prop = "WholeBodyDirtinessRate",
							}),
						},
						Id = "autoid_TGkJ3Tu_ex4rAki",
						Label = "Survivors",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(778287045052, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] 'I walked into the center of the town and said:\n"Oh man this base looks rough, I am willing to help for the right reward!"\n\nA nearby loudspeaker stated "ASSISTANCE OFFER ACCEPTED. PLEASE PLACE ALL ROBOTS TOGETHER AND RECEIVE MAINTENANCE PROTOCOLS"\n\nI did as asked, and the robots swapped parts around until there was a single functional one.\n\n<em>All survivors equipment now degrades 50% slower.\nLocal Consortium Nest aggression levels lowered.</em>'),
				Title = T(841480103934, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(444232261491, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "Sneak into the main base and explore!"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('PlaceExpeditionByTravelTime', {
						ExpeditionPreset = "Ore",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(505610405835, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] 'There is a rumor that all Consortium Tech has a self destruct button hidden away.\nAnd in the middle of the main building was a big red button labeled "SDB". \nAfter a brisk jog away from the base, I felt the explosion and saw the smoke cloud.\n\nWe need to wait for it to cool down.\nBut after can strip that site of its metal!\n\n<em>This site becomes a repeatable metal expedition.</em>'),
				Title = T(618631955174, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
			NotificationText = T(541119697209, --[[ModItemStoryBit Robot_Diplo_Miscomm NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(930081331336, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'As I flew in, a Consortium drone flew up to me and said in multiple languages:\n\n"GREETINGS NATIVES, PLEASE LAND SO WE CAN DISCUSS FIRST CONTACT"\nAfter landing, the main building spat out a Robot in a fancy hat and monocle.\nIt stated "WELCOME, LET US NEGOTIATE MINING RIGHTS"\n\nShould I tell him? Or keep this charade up?'),
			Title = T(773066943050, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium First Contact"),
			id = "Robot_Diplo_Miscomm",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(479422209092, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'Play along, make a good "deal"'),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 100000000,
						Resource = "Money",
						param_bindings = false,
					}),
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							CreateGameTimeThread(function()
							if AsyncRand(100) < 20 then return end
							Sleep(hours_per_day * 300)
							ForceActivateStoryBit("ConstortiumDeceived")
							end)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(769090058911, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'It appears I have convinced them.\nEven though they wanted the full planet, I made sure to only give them this small quadrant.\n\nThey seemed quite pleased, and negotiated me down to "only" 100,000 Galacticoins!\n\n<em>500,000 Galacticoins gained</em>\n<style TextNegative>The Consortium will be upset if they ever discovers this betrayal.</style> '),
				Title = T(985336167809, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(578007899959, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] "Resolve the miscommunication without dying"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "OilVegetable",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 300000,
						Resource = "LiquidFuel",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 5000,
						Resource = "EMUmbrella",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(122637601652, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'I politely but firmly tried to explain that I and noone I know has the authority to trade away mining rights.\nAfter the 10th time, the Robots seemed to understand.\n\nThe posh Robot finally stated "IF YOU CANNOT TRADE THEN LEAVE US BE. WE SHALL GRANT YOU A STANDARD ORGANIC RATION PACK FOR WASTING YOUR TIME".\n\nWhen I got back to my ride, I only saw a bunch of oil, fat, and umbrellas.... Organic Ration pack my ***\n\n<em>Collected assorted resources</em>'),
				Title = T(678850191758, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(543771149310, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] "This is an illegal mining base!"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar("nest_disaster_species","ConsortiumNest")
							CreateGameTimeThread(function()
							local delay_days = AsyncRand(3)
							local d_dur = const.DayDuration
							Sleep(delay_hours * d_dur)
							ForceActivateStoryBit('begin_nest_disaster')
							return end)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(646013289734, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'Before I ended up on this planet, I knew that the Consortium was just a robotics company. And they certainly did not have any authority to even send space ships, let alone mine!\n\nAs I explained, I was cutoff by the robot....\n"DIPLOMATIC COMMUNICATIONS HAVE BROKEN DOWN. LEAVE THE PREMISES BEFORE YOUR DIPLOMATIC IMMUNITY IS NULL AND VOID, AND ALERT YOUR CIVILIZATION WE DECLARE WAR."\n\n<style TextNegative>The consequences of this action will occur in due time</style>'),
				Title = T(117855560734, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(512022465446, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] "Stall the talks and sabotage the base"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar("nest_disaster_species","ShriekerNest")
							CreateGameTimeThread(function()
							local delay_days = AsyncRand(3)
							local d_dur = const.DayDuration
							Sleep(delay_hours * d_dur)
							ForceActivateStoryBit('begin_nest_disaster')
							return end)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(673450905611, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] "I asked to see a tour before we started to negotiate to 'make sure their stuff was top quality'.\n\nI also made sure to stress how culturally, I must \"bless\" everything that sparks with water.\nAnd those buckets of bolts just let me..... like their self-preservation code got turned off!\n\nNo sooner had I toured 2 buildings than everything was shorting, and a few fires broke out!\nNeedless to say, I got to pick what I wanted to bring home from the negotiations!\n\n<em>Hoard of silicon and metal acquired.\nLocal Consortium Aggression increased</em>"),
				Title = T(966655008822, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Category = "Expedition",
			Enabled = true,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
			NotificationText = T(624375902685, --[[ModItemStoryBit Robot_Fake_Settlement NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(400841303990, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'I landed in a "town" called "TOTALLYHUMANVILLE" according to its giant banner.\nClearly Consortium Robots in tattered clothes are standing still saying "I need to file my taxes this year".\nCages with animals (some dead, some alive) are all stacked on top each. With a giant sign above it reading "PLEASE AWW AT OUR PETS".\n\nOne of the Robots eventually wanders up and says "HELLO, WE NEED TO TEST YOU TO MAKE SURE YOUR NOT A ROBOT. PLEAS ANSWER OUR QUESTIONS"'),
			Title = T(139755321033, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] A totally human settlement"),
			id = "Robot_Fake_Settlement",
			max_reply_id = 4,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(609619301121, --[[ModItemStoryBit Robot_Fake_Settlement Text]] "Save those animals!"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							local anim = {'Rage_Focused_Scissorhand','Camel_T5','Ulfen_T5',''}
							local give = AsyncRand(#anim)
							set_expedition_tame(anim[give])
							Aggression_up('ConsortiumNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(781495852780, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'Through a combination of trickery, flattery, and acting like I believed the robots, I managed to break some cages.\nThe animals that were healthy enough started to rampage across the "town".\nThe animal whose cage I opened first seemed to take a liking to me, and it seems to want to come home with me.\n\n<em>High Tier animal will be brought back from this expedition.\nLocal Consortium Aggression levels increased.</em>'),
				Title = T(608221526455, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(699209724742, --[[ModItemStoryBit Robot_Fake_Settlement Text]] "Ask to trade your sheep for their wood, you need to build a road"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ConsortiumNest')
						end,
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 500000,
						Resource = "Wood",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(177283289978, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'The robots seemed almost happy that their "disguise" is working.\nThey quickly placed buckets of wood on my vehicle, and seemed to forget that I offered them anything at all.\n\n<em>Hoard of wood acquired.\nLocal Consortium Aggression levels lowered.</em>'),
				Title = T(313243747144, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(446566193510, --[[ModItemStoryBit Robot_Fake_Settlement Text]] "Try and get them to break character"),
				param_bindings = false,
				unique_id = 4,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "ScrapMetal",
						param_bindings = false,
					}),
					PlaceObj('GiveExpeditionRewardToSurvivor', {
						Amount = 200000,
						Resource = "Silicon",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(252610986332, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'I politely informed the "humans" that I need no test, because I\'m bad at math!\nI told them to ask me one, and they gave me an exponential calculus that I couldn\'t even do it regularly....\n\nI then asked them what 2 + 2 is, and I could literally hear their computers try and not answer correctly.\nLuckily they kept whirring until every single bot short circuited.\nLeaving me free to loot the place!\n\n<em>Hoard of metal and silicon.\nLocal Consortium Aggression levels unchanged.</em>'),
				Title = T(514021971038, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(557173702604, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'Offer to help their "town"'),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "hidden",
						PresetId = "NA_consort_power_efficiency",
						param_bindings = false,
					}),
					PlaceObj('RemoveLockedState', {
						Class = "Tech",
						Group = "Breakthroughs",
						LockState = "locked",
						PresetId = "NA_consort_power_efficiency",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
				Text = T(559411836035, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'After passing their "test" (drinking water), I offered to help them with their lives.\nI said I could cook, hunt, do research.....\n\nWhile still speaking my language, they discussed how they should respond. \nThey mentioned how a Consortium signal is beaming them most of the energy they need, and they don\'t need help really.\n\nAt that point, I decided to leave before they realized what they just told me.\n\n<em>Technology unlocked granting powerful benefits.</em>'),
				Title = T(715332642423, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						Aggression_up('ConsortiumNest')
						Aggression_up('ConsortiumNest')
						Aggression_up('ConsortiumNest')
						Aggression_up('ConsortiumNest')
						Aggression_up('ConsortiumNest')
						ForceActivateStoryBit("RobotAttack_Single_EarlyGame")
					end,
					param_bindings = false,
				}),
			},
			HasNotification = false,
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/temporary.png",
			Text = T(515394180803, --[[ModItemStoryBit ConstortiumDeceived Text]] 'A large airship flies above your base. \nAfter stabilizing, it announces:\n\n"WE HAVE FINALLY LOCATED YOU, THE DECEIVERS!\nWE WILL NOW COMMENCE OUR REVENGE FOR THE FINANCIAL PENALTIES WE SUFFERED BECAUSE OF OUR FALSIFIED MINING RIGHTS!"\n\n<style TextNegative>Local Consortium Nest aggression levels increased 5x.\nThe Consortium will also send an attack.</style>'),
			Title = T(888103019740, --[[ModItemStoryBit ConstortiumDeceived Title]] "Consortium Deception Discovered"),
			id = "ConstortiumDeceived",
			save_in = "Mod/TGkJ3Tu",
		}),
		PlaceObj('ModItemTech', {
			Description = T(498459637401, --[[ModItemTech NA_consort_power_efficiency Description]] "An expedition to a Consortium mining base has revealed a secret frequency that the Consortium is beaming power through!\n\nLet's hack into this signal, and learn how to harness it for our own purposes!\n\n<em>All buildings consume 25% less power</em>"),
			DisplayName = T(756256372571, --[[ModItemTech NA_consort_power_efficiency DisplayName]] "Consortium Power Beaming"),
			LockState = "hidden",
			group = "Breakthroughs",
			id = "NA_consort_power_efficiency",
			save_in = "Mod/TGkJ3Tu",
			tradable = false,
			PlaceObj('AttachEffectsToBuildings', {
				Effects = {
					PlaceObj('ModifyObject', {
						Id = "autoid9",
						ModProperty = "PowerConsumption",
						Mul = 750,
						ObjectClass = "PowerComponent",
					}),
				},
				Id = "autoid_TGkJ3Tu_RriFNjh",
				Label = "PowerSources",
			}),
		}),
		}),
	PlaceObj('ModItemExpeditionPreset', {
		DisplayImage = "UI/Messages/Expeditions/exp_5_tall_stones",
		Expiration = 4800000,
		FoundByExploration = true,
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/5_tall_stones",
		OneTime = true,
		StoryBits = {
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "NA_Ritual_Site",
			}),
		},
		comment = "Disaster Species pick",
		description = T(189159299236, --[[ModItemExpeditionPreset NestAwaken_Exp_Ritual_Site description]] "A meteorite fell in this area."),
		id = "NestAwaken_Exp_Ritual_Site",
		mod_version_major = 1,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemFolder', {
		'name', "Ritual Site",
		'NameColor', RGBA(239, 17, 17, 255),
	}, {
		PlaceObj('ModItemTrait', {
			Description = T(745960059960, --[[ModItemTrait NA_DoomSelecter Description]] "This colonists sleep is plagued with nightmares of <disaster_species>. THey think it is a portent of doom, and need more sleep."),
			DisplayName = T(788927740183, --[[ModItemTrait NA_DoomSelecter DisplayName |gender-variants]] "Doombringer"),
			Modifiers = {
				PlaceObj('ModifyHuman', {
					Id = "autoid_TGkJ3Tu_XWNmfvh",
					mul = 1500,
					prop = "MaxSleepTime",
				}),
			},
			id = "NA_DoomSelecter",
			save_in = "Mod/TGkJ3Tu",
		}),
		PlaceObj('ModItemStoryBit', {
			Image = "UI/Messages/Expeditions/exp_5_tall_stones",
			NotificationText = T(790456924082, --[[ModItemStoryBit NA_Ritual_Site NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(427346054794, --[[ModItemStoryBit NA_Ritual_Site Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
			Title = T(689773556964, --[[ModItemStoryBit NA_Ritual_Site Title]] "[The Nests Awaken] Ritual Site"),
			id = "NA_Ritual_Site",
			max_reply_id = 2,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(509651737486, --[[ModItemStoryBit NA_Ritual_Site Text]] "Free one (Or all)"),
				param_bindings = false,
				unique_id = 1,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('StoryBitActivate', {
						Id = "NA_Ritual_Site_free",
						param_bindings = false,
					}),
				},
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(588416265092, --[[ModItemStoryBit NA_Ritual_Site Text]] "Throw one into the pit"),
				param_bindings = false,
				unique_id = 2,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('StoryBitActivate', {
						Id = "NA_Ritual_Site_throw",
						param_bindings = false,
					}),
				},
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Free_ritual.jpg",
			NotificationText = T(131050927229, --[[ModItemStoryBit NA_Ritual_Site_free NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(301381575679, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
			Title = T(461204223176, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
			id = "NA_Ritual_Site_free",
			max_reply_id = 8,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(896837737328, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "Free the Shrieker"),
				param_bindings = false,
				unique_id = 3,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
							Aggression_down('ShriekerNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Free_ritual.jpg",
				Text = T(804506643042, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "I took the Shrieker down, it was too weak to even fight back.\n\nAs I started to try and drag it back to the entrance, the body turned to dust within 5 seconds! \nWhen I glanced back to the other creatures, they were also nowhere to be seen...\n\nWhat does this mean?\n\n<em>Local Shrieker Nests aggression lowered 10x.</em>"),
				Title = T(647915288024, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(734574143654, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "Free the Scissorhands!"),
				param_bindings = false,
				unique_id = 5,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
							Aggression_down('ScissorhandsNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Free_ritual.jpg",
				Text = T(884431128636, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "I took the Scissorhand down, it was too weak to even fight back.\n\nAs I started to try and drag it back to the entrance, the body turned to dust within 5 seconds! \nWhen I glanced back to the other creatures, they were also nowhere to be seen...\n\nWhat does this mean?\n\n<em>Local Scisorhands Nests aggression lowered 10x.</em>"),
				Title = T(711358804043, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				PrerequisiteText = T(768459043788, --[[ModItemStoryBit NA_Ritual_Site_free PrerequisiteText]] "Guardian DLC"),
				Prerequisites = {
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return Is_DLC_Present() end,
						param_bindings = false,
					}),
				},
				Text = T(952819764857, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "Free the Robot!"),
				param_bindings = false,
				unique_id = 6,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
							Aggression_down('ConsortiumNest')
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Free_ritual.jpg",
				Text = T(989967729384, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "I took the Robot down, it was too weak to even fight back.\n\nAs I started to try and drag it back to the entrance, the body turned to dust within 5 seconds! \nWhen I glanced back to the other creatures, they were also nowhere to be seen...\n\nWhat does this mean?\n\n<em>Local Consortium Nests aggression lowered 10x.</em>"),
				Title = T(716360395676, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(966956978298, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "Free them all!"),
				param_bindings = false,
				unique_id = 7,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							 -- true to force set them back to sleep
							End_Disaster('ShriekerNest',true)
							End_Disaster('ScissorhandsNest',true)
							End_Disaster('ConsortiumNest',true)
						end,
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Free_ritual.jpg",
				Text = T(831193755728, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "I took the Shrieker down first.\nIt didn't have the energy to even hiss at me!\n\nI quickly cut the others down.\nThe second the last one hit the floor, they all crumbled into dust...\n\nWhat does this mean?\n\n<em>All nests are no longer alert.</em>"),
				Title = T(973183624745, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(977820525654, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "Wait I changed my mind"),
				param_bindings = false,
				unique_id = 8,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('StoryBitActivate', {
						Id = "NA_Ritual_Site",
						param_bindings = false,
					}),
				},
				param_bindings = false,
			}),
		}),
		PlaceObj('ModItemStoryBit', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/throw_ritual.jpg",
			NotificationText = T(532895415046, --[[ModItemStoryBit NA_Ritual_Site_throw NotificationText]] "Expedition complete: <ExplorationSiteName>"),
			Text = T(490463520105, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
			Title = T(445367552988, --[[ModItemStoryBit NA_Ritual_Site_throw Title]] "[The Nests Awaken] Ritual Site"),
			id = "NA_Ritual_Site_throw",
			max_reply_id = 10,
			save_in = "Mod/TGkJ3Tu",
			PlaceObj('StoryBitReply', {
				Text = T(918659265639, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "Throw the Shrieker into the pit"),
				param_bindings = false,
				unique_id = 7,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar('nest_disaster_species', 'ShriekerNest')
							MapVarValues['nest_disaster_species']='ShriekerNest'
						end,
						param_bindings = false,
					}),
					PlaceObj('AddRemoveTrait', {
						Trait = "NA_DoomSelecter",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/throw_ritual.jpg",
				Text = T(543080352657, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "I bound the Shrieker with vines and cut it down.\nSlowly I dragged it closer and closer to the pit.\nWhen I glanced down into the darkness, I was instead met with tiny dots of light from far below.\n\nWith a swift kick, the body started to descend.\nI stuck around waiting to hear a thud.\n\nImagine my surprise when I saw those lights start getting bigger!\nAnd Shriekers started climbing up the pit!\n\nNeedless to say, I left immediately. \nAs I fly back it all feels like a fever dream.....\n\n<style TextNegative>You will feel the consequences of this in due time</style>\n<em>This colonist has gained a trait from this decision.</em>"),
				Title = T(918388632888, --[[ModItemStoryBit NA_Ritual_Site_throw Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(834551438719, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "Throw the Scissorhand into the pit"),
				param_bindings = false,
				unique_id = 8,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar('nest_disaster_species', 'ScissorhandsNest')
							MapVarValues['nest_disaster_species']='ScissorhandsNest'
						end,
						param_bindings = false,
					}),
					PlaceObj('AddRemoveTrait', {
						Trait = "NA_DoomSelecter",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/throw_ritual.jpg",
				Text = T(359731480412, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "I bound the Scissorhands with vines and cut it down.\nSlowly I dragged it closer and closer to the pit.\nWhen I glanced down into the darkness, I was instead met with tiny dots of light from far below.\n\nWith a swift kick, the body started to descend.\nI stuck around waiting to hear a thud.\n\nImagine my surprise when I saw those lights start getting bigger!\nAnd Scissorhands started climbing up the pit!\n\nNeedless to say, I left immediately. \nAs I fly back it all feels like a fever dream.....\n\n<style TextNegative>You will feel the consequences of this in due time</style>\n<em>This colonist has gained a trait from this decision.</em>"),
				Title = T(705703771455, --[[ModItemStoryBit NA_Ritual_Site_throw Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				PrerequisiteText = T(727391762808, --[[ModItemStoryBit NA_Ritual_Site_throw PrerequisiteText]] "Guardians DLC"),
				Prerequisites = {
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return Is_DLC_Present() end,
						param_bindings = false,
					}),
				},
				Text = T(788670638652, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "Throw the Robot into the pit"),
				param_bindings = false,
				unique_id = 9,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('ExecuteCode', {
						Code = function (self, obj)
							MapVar('nest_disaster_species', 'ConsortiumNest')
							MapVarValues['nest_disaster_species']='ConsortiumNest'
						end,
						param_bindings = false,
					}),
					PlaceObj('AddRemoveTrait', {
						Trait = "NA_DoomSelecter",
						param_bindings = false,
					}),
				},
				Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/throw_ritual.jpg",
				Text = T(614255163882, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "I bound the Robot with vines and cut it down.\nSlowly I dragged it closer and closer to the pit.\nWhen I glanced down into the darkness, I was instead met with bright red laser pointers from far below.\n\nWith a swift kick, the body started to descend.\nI stuck around waiting to hear a thud.\n\nImagine my surprise when I saw those lights start getting bigger!\nAnd Robots started climbing up the pit!\n\nNeedless to say, I left immediately. \nAs I fly back it all feels like a fever dream.....\n\n<style TextNegative>You will feel the consequences of this in due time</style>\n<em>This colonist has gained a trait from this decision.</em>"),
				Title = T(533275306483, --[[ModItemStoryBit NA_Ritual_Site_throw Title]] "[The Nests Awaken] Ritual Site"),
				param_bindings = false,
			}),
			PlaceObj('StoryBitReply', {
				Text = T(610379090772, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "Wait I changed my mind"),
				param_bindings = false,
				unique_id = 10,
			}),
			PlaceObj('StoryBitOutcome', {
				Effects = {
					PlaceObj('StoryBitActivate', {
						Id = "NA_Ritual_Site",
						param_bindings = false,
					}),
				},
				param_bindings = false,
			}),
		}),
		}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Meta",
	'NameColor', RGBA(194, 183, 100, 255),
}, {
	PlaceObj('ModItemTextStyle', {
		DisabledRolloverTextColor = 4290754479,
		DisabledTextColor = 4290754479,
		RolloverTextColor = 4293616994,
		TextColor = 4293616994,
		TextFont = T(672980932239, --[[ModItemTextStyle FinePrint TextFont]] "SchemeBk, 9"),
		id = "FinePrint",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemRobotCondition', {
		Description = T(963092369040, --[[ModItemRobotCondition FamiliarGroundRobo Description]] "This unit self-repairs and is better in combat due to it being near a base of operations"),
		DisplayName = T(359172351610, --[[ModItemRobotCondition FamiliarGroundRobo DisplayName]] "Nearby Pylon"),
		Modifiers = {
			PlaceObj('ModifyRobot', {
				Id = "autoid_TGkJ3Tu_QRkNWV7",
				add = 5000,
				param_bindings = false,
				prop = "Regeneration",
			}),
		},
		Polarity = "positive",
		ShowFloatingText = false,
		id = "FamiliarGroundRobo",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "ModifyWeaponHitChance",
				Handler = function (self, target, chance, weapon_def)
					return chance + 15
				end,
				param_bindings = false,
			}),
		},
	}),
	PlaceObj('ModItemTrait', {
		UserTags = set(),
		id = "NestsAwaken_reaction_holder",
		msg_reactions = {
			PlaceObj('MsgReaction', {
				Event = "RecipeCrafted",
				Handler = function (self, production_device, recipe, count, survivor)
					print(production_device.unfinished_item_data.used_resources)
					local tab = production_device.unfinished_item_data.used_resources
					Resource_aggression_check(tab)
				end,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "nests_awaken_notifications",
		'DisplayName', "Non-Attack Nest Event Notifications",
		'DefaultValue', "Notifications Only",
		'ChoiceList', {
			"Full Popup",
			"Notifications Only",
			"Do not Alert me (<style TextNegative>Warning Dangerous</style>)",
		},
	}),
	}),
PlaceObj('ModItemTutorialHint', {
	Hints = {
		PlaceObj('TutorialHintItem', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Insect Nest UI.jpg",
			Text = T(375361284496, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>1 of 4</em>\nThe Scissorhands and Shrieker Nests are now <style TextNegative>deadly hazards</style>!\nMeaning they will now:\n<style TextNegative>1. React to your presence\n2. Consume nearby resources.\n3. Launch scout patrols or launch their own attacks\n4. Spawn more often, and based on how you play.</style>\n\nIf you do something that Scissorhands are looking out for (or do not like), you better believe you will find some new Scissorhand Neighbors! \n(Just don't ask to borrow their scissors, they don't un-attach easily)"),
		}),
		PlaceObj('TutorialHintItem', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/angry nest.PNG",
			Text = T(283738735418, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>2 of 4</em>\nOnce alerted to your presence, the nests will go into overdrive.\nThis means they will consume nearby resources faster.\nAny units released will be sent right to your base!\n\n<style TextNegative>Beware, lest you leave the nests be.....</style>\nFor in that path lies a literal disaster.\nAnd the planet's denizens will realize and attempt to take out a \"rival\" species (YOU)!"),
		}),
		PlaceObj('TutorialHintItem', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/ConsortiumNestVariant.PNG",
			Text = T(760322908319, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>3 of 4</em>\nIf you have the Guardians DLC, there is <style TextPositive>something extra in here as well!</style>\n\n<em>The Consortium hyperactive</em>, and is hurling automated mining bases to prospective locations.\nWhat makes a prospective location you say? Good question!"),
		}),
		PlaceObj('TutorialHintItem', {
			Image = "Mod/TGkJ3Tu/Pics Or it Didn't Happen/Notifications.PNG",
			Text = T(400960854348, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>4 of 4</em>\n\nYou will also find <em>4 new Expedition Sites</em>, each with at least 3 possible outcomes!\nThese Expeditions can reward you with <style TextPositive>high tier pre-Tamed animals!</style>\nthey can also rewards you with <style TextNegative>even more new and unfriendly neighbors!</style>\nAfter the expedition, you will find your new friend right next to the Balloon!"),
		}),
	},
	Tutorial = "",
	display_name = T(204424421469, --[[ModItemTutorialHint nests_awaken_tutorial display_name]] "Nests Awaken Tutorial"),
	id = "nests_awaken_tutorial",
	mod_version_major = 1,
	msg_reactions = {
		PlaceObj('MsgReaction', {
			Event = "GameStarted",
			Handler = function (self)
				if not MapVarValues.shownNestTutorial then
					MapVar('shownNestTutorial',true)
					self:ShowNotification()
				end
			end,
		}),
		PlaceObj('MsgReaction', {
			Event = "HumanAttacked",
			Handler = function (self, human, attacker)
				if not MapVarValues.shownNestTutorial then
					MapVar('shownNestTutorial',true)
					self:ShowNotification()
				end
			end,
		}),
	},
	save_in = "Mod/TGkJ3Tu",
}),
}
