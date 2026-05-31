return {
PlaceObj('ModItemCode', {
	'name', "NA_NestExpansion",
	'CodeFileName', "Code/NA_NestExpansion.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_Consortium",
	'CodeFileName', "Code/NA_Consortium.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_Disaster",
	'CodeFileName', "Code/NA_Disaster.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_ExpeditionStuff",
	'CodeFileName', "Code/NA_ExpeditionStuff.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_Aggression",
	'CodeFileName', "Code/NA_Aggression.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_NestPreset",
	'CodeFileName', "Code/NA_NestPreset.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_Helper",
	'CodeFileName', "Code/NA_Helper.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_ShoguNest",
	'CodeFileName', "Code/NA_ShoguNest.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_Unit_Invader_Expansion",
	'CodeFileName', "Code/NA_Unit_Invader_Expansion.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_NothNest",
	'CodeFileName', "Code/NA_NothNest.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_DrakaNest",
	'CodeFileName', "Code/NA_DrakaNest.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_DeathflyNest",
	'CodeFileName', "Code/NA_DeathflyNest.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_JunoNest",
	'CodeFileName', "Code/NA_JunoNest.lua",
}),
PlaceObj('ModItemCode', {
	'name', "NA_GlutchNest",
	'CodeFileName', "Code/NA_GlutchNest.lua",
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
				'Translate', true,
				'Text', T(821602814761, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "An <style TextPositive>inert</style> nest, slowly growing with some patrolling defenders."),
				'HideOnEmpty', true,
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "Attack is far away",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_percent() < 90 end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(347900511203, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "Our scouts are watching the openings of this nest, and can provide a good estimate on when this nest will release it's next batch! "),
				'RolloverTitle', T(706440093934, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack timing"),
				'Id', "idNestAttackTimeBar",
				'BindTo', "ui_attack_percent",
				'BarColor', RGBA(96, 116, 127, 255),
				'Text', T(133904546142, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Time until attack<right><percent(value)>"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "An attack is close to happening",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_percent() > 90 end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(439859567286, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "Our scouts are watching the openings of this nest, and can provide a good estimate on when this nest will release it's next batch! "),
				'RolloverTitle', T(867262788940, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack timing"),
				'Id', "idNestAttackTimeBar",
				'Progress', 100,
				'BarColor', RGBA(183, 85, 85, 255),
				'Text', T(812598884528, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "IMMINENT"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "Under 100% attack strength next",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_strength() <= 100 end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(177622343318, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How strong this nests next attack will be!\nThe <em>arrow over the bar</em> indicates the current maximum strength this nest can attack with.\nThis maximum strength will increase as more nests of this species wake up and the longer this nest stays alive!"),
				'RolloverTitle', T(887730983296, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Strength"),
				'Id', "idNestAttackStrBar",
				'BindTo', "ui_attack_strength",
				'BarColor', RGBA(96, 116, 127, 255),
				'Text', T(640556952688, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Attack strength vs our defenses<right><percent(value)>"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "Above 100% attack strength next",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_strength() > 100 end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(828707890863, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How strong this nests next attack will be!\nThe <em>arrow over the bar</em> indicates the current maximum strength this nest can attack with.\nThis maximum strength will increase as more nests of this species wake up and the longer this nest stays alive!"),
				'RolloverTitle', T(974540735024, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Strength"),
				'Id', "idNestAttackStrBar",
				'BindTo', "ui_attack_strength",
				'BarColor', RGBA(235, 13, 13, 255),
				'Text', T(514131723970, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "This nests attack will overwhelm us!"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_cap()  ~= context:calculate_attack_strength('player') end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(190081229485, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How strong this nests next attack will be!\nThe <em>arrow over the bar</em> indicates the current maximum strength this nest can attack with.\nThis maximum strength will increase as more nests of this species wake up and the longer this nest stays alive!"),
				'RolloverTitle', T(115596171582, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Strength"),
				'Id', "idNestAttackCapBar",
				'BindTo', "ui_attack_cap",
				'BarColor', RGBA(96, 116, 127, 255),
				'Text', T(628825576765, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Attack strength vs Max strength possible <right><percent(value)>"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context:Getui_attack_cap()  == context:calculate_attack_strength('player') end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(349056940582, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How strong this nests next attack will be!\nThe <em>arrow over the bar</em> indicates the current maximum strength this nest can attack with.\nThis maximum strength will increase as more nests of this species wake up and the longer this nest stays alive!"),
				'RolloverTitle', T(880572893284, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Strength"),
				'Id', "idNestAttackCapBar",
				'BindTo', "ui_attack_cap",
				'BarColor', RGBA(216, 7, 36, 255),
				'Text', T(130129034622, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Nest Attacking with Max Strength!"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "How close to evolving",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context.hatchling_class ~= Find_evolution(g_Classes[context.hatchling_class]) end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(667468555901, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How much biomass is in deep storage, presumably to evolve the units it produces!"),
				'RolloverTitle', T(355662986259, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Evolution"),
				'Id', "idNestEvoBar",
				'BindTo', "ui_evo",
				'BarColor', RGBA(118, 122, 124, 255),
				'Text', T(829117815020, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Progress until Evolution <right><percent(value)>"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			PlaceObj('XTemplateWindow', {
				'comment', "How close to evolving",
				'__context_of_kind', "EnhancedTerritorialNest",
				'__condition', function (parent, context) return context.hatchling_class == Find_evolution(g_Classes[context.hatchling_class]) end,
				'__class', "UIBar",
				'RolloverTemplate', "Rollover",
				'RolloverText', T(923171248379, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverText]] "How much biomass is in deep storage, presumably to evolve the units it produces!"),
				'RolloverTitle', T(554662230116, --[[ModItemXTemplate tabOverview_200_BuildingHealth RolloverTitle]] "Attack Evolution"),
				'Id', "idNestEvoBar",
				'Progress', 100,
				'BarColor', RGBA(216, 7, 36, 255),
				'Text', T(972022516966, --[[ModItemXTemplate tabOverview_200_BuildingHealth Text]] "Nest has fully evolved!"),
				'AddTargetTickMark', false,
				'ShowTargetArrows', false,
				'MarkerAfterSeperatorImage', "UI/Hud/bar_marker_breakdown",
			}),
			}),
	}),
	PlaceObj('ModItemAttachedUIPreset', {
		SortKey = 31,
		id = "NestRoleFar",
		max_cam_dist_m = 120,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAttachedUIPreset', {
		SortKey = 31,
		id = "NestRoleClose",
		max_cam_dist_m = 20,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAttachedUIPreset', {
		SortKey = 31,
		id = "NestRolePermanent",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemXTemplate', {
		__is_kind_of = "XDialog",
		group = "Stranded",
		id = "NestRoleHighZoom",
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('XTemplateWindow', {
			'__class', "XDrawCacheDialog",
			'HAlign', "left",
			'VAlign', "top",
			'UseClipBox', false,
			'FocusOnOpen', "",
		}, {
			PlaceObj('XTemplateWindow', {
				'__class', "XContextWindow",
				'Margins', box(-75, -45, 0, 0),
				'OnLayoutComplete', function (self)
					XContextWindow.OnLayoutComplete(self)
					local width = MulDivRound(self.box:sizex(), 1000, self.scale:x())
					local height = MulDivRound(self.box:sizey(), 1000, self.scale:y())
					self:SetMargins(box((-width / 2), -height + 1, 0, 0))
				end,
				'LayoutMethod', "VList",
				'UseClipBox', false,
			}, {
				PlaceObj('XTemplateWindow', {
					'__class', "XText",
					'Clip', false,
					'UseClipBox', false,
					'FoldWhenHidden', true,
					'TextStyle', "HUDText",
					'Translate', true,
					'Text', T(742581644233, --[[ModItemXTemplate NestRoleHighZoom Text]] "<UIRole>"),
					'HideOnEmpty', true,
					'TextHAlign', "center",
				}),
				}),
			}),
	}),
	PlaceObj('ModItemXTemplate', {
		__is_kind_of = "XDialog",
		group = "Stranded",
		id = "NestRoleMediumZoom",
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('XTemplateWindow', {
			'__class', "XDrawCacheDialog",
			'HAlign', "left",
			'VAlign', "top",
			'UseClipBox', false,
			'FocusOnOpen', "",
		}, {
			PlaceObj('XTemplateWindow', {
				'__class', "XContextWindow",
				'Margins', box(-75, -45, 0, 0),
				'OnLayoutComplete', function (self)
					XContextWindow.OnLayoutComplete(self)
					local width = MulDivRound(self.box:sizex(), 1000, self.scale:x())
					local height = MulDivRound(self.box:sizey(), 1000, self.scale:y())
					self:SetMargins(box((-width / 2), -height + 1, 0, 0))
				end,
				'LayoutMethod', "VList",
				'UseClipBox', false,
			}, {
				PlaceObj('XTemplateWindow', {
					'__class', "XText",
					'Clip', false,
					'UseClipBox', false,
					'FoldWhenHidden', true,
					'TextStyle', "HUDText",
					'Translate', true,
					'Text', T(961128649087, --[[ModItemXTemplate NestRoleMediumZoom Text]] "<UIRole>"),
					'HideOnEmpty', true,
					'TextHAlign', "center",
				}),
				}),
			}),
	}),
	PlaceObj('ModItemXTemplate', {
		__is_kind_of = "XDialog",
		group = "Stranded",
		id = "NestRolePermanent",
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('XTemplateWindow', {
			'__class', "XDrawCacheDialog",
			'Margins', box(0, -100, 0, 0),
			'HAlign', "left",
			'VAlign', "top",
			'UseClipBox', false,
			'FocusOnOpen', "",
		}, {
			PlaceObj('XTemplateWindow', {
				'__class', "XContextWindow",
				'Margins', box(-75, -45, 0, 0),
				'Padding', box(0, 10, 0, 0),
				'OnLayoutComplete', function (self)
					XContextWindow.OnLayoutComplete(self)
					local width = MulDivRound(self.box:sizex(), 1000, self.scale:x())
					local height = MulDivRound(self.box:sizey(), 1000, self.scale:y())
					local model_height = self:GetContext():GetHeight() or 0
					self:SetMargins(box((-width / 2), 1 - height, 0, 0))
				end,
				'LayoutMethod', "VList",
				'UseClipBox', false,
			}, {
				PlaceObj('XTemplateWindow', {
					'__class', "XText",
					'Clip', false,
					'UseClipBox', false,
					'FoldWhenHidden', true,
					'TextStyle', "HUDText",
					'Translate', true,
					'Text', T(463168741115, --[[ModItemXTemplate NestRolePermanent Text]] "<UIRole>"),
					'HideOnEmpty', true,
					'TextHAlign', "center",
				}),
				}),
			}),
	}),
	PlaceObj('ModItemFolder', {
		'name', "Notifications",
		'NameColor', RGBA(0, 144, 201, 255),
	}, {
		PlaceObj('ModItemStoryBit', {
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/sleepy_insect.jpg",
			NotificationText = T(433873099185, --[[ModItemStoryBit back_to_sleep NotificationText]] "A nest has become inactive"),
			NotificationTitle = T(501042144899, --[[ModItemStoryBit back_to_sleep NotificationTitle]] "A nest has become inactive"),
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/AlarmClock.jpeg",
			NotificationText = T(126554022751, --[[ModItemStoryBit waking_up NotificationText]] "A nest has activated!"),
			NotificationTitle = T(568019442711, --[[ModItemStoryBit waking_up NotificationTitle]] "A nest has activated!"),
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Evolution.jpg",
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
		PlaceObj('ModItemNotificationPreset', {
			CanChangeGameSpeed = function (self) return GetAccountStorageOptionValue("AnimalAttackEffect") < 3 end,
			CanChangeGameSpeedLimit = function (self) return GetAccountStorageOptionValue("AnimalAttackEffect") == 1 end,
			comment = "-- Overrode the FX/music that plays when attacked due to how many attacks the player gets with this mod",
			dismissable = false,
			game_speed = "normal",
			game_speed_limit = "fast",
			game_speed_limit_duration = 40000,
			id = "AnimalAttack",
			msg_reactions = {
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorAssign",
					Handler = function (self, animal, new_behavior)
						if IsKindOfClasses(new_behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") and not animal:IsDead() and not animal.forced_pacification then
							if animal:IsKindOf("UnitAnimal") then
								NotificationObjRem("AnimalAttack_Spawned", animal)
								if self:AddObject(animal) then
									Msg("AnimalAttackCountChanged", self.id)
								end
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorExpire",
					Handler = function (self, animal, behavior)
						if not IsKindOfClasses(behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") or animal:IsDead() or animal.forced_pacification then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitChangeAttackTarget",
					Handler = function (self, unit, target, old_target)
						-- This msg handles an animal's transfer between Aggressive animals and Animal attack notifications.
						if unit:IsKindOf("UnitAnimal") then
						
							-- The animal is attacking any human combat group target
							-- => remove it from Aggressive animals and add it to Animal attack
							local human_group = Human.CombatGroup
							if IsValid(target) and target.CombatGroup == human_group and unit.CombatGroup ~= human_group then
								NotificationObjRem("AnimalAttack_Spawned", unit)
								if self:AddObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
								
							-- The animal is not attacking any human target (anymore) but it will somewhen become aggressive
							-- => send it back to Aggressive animals notification
							elseif table.findfirst(unit.invader_behaviours, function(_, behaviour) return IsKindOfClasses(behaviour, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") end) then 
								NotificationObjAdd("AnimalAttack_Spawned", unit)
								if self:RemoveObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
								
							-- The animal is not attacking any human target and will not become aggressive and IS NOT aggressive anymore
							-- => just remove (will be removed from everywhere)
							elseif (unit.forced_aggression_until or 0) < GameTime() or unit.forced_pacification or (unit:IsTamed() and not target) then
								if self:RemoveObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitDied",
					Handler = function (self, unit)
						if IsValid(unit) then
							if self:RemoveObject(unit) then
								Msg("AnimalAttackCountChanged", self.id) 
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalDone",
					Handler = function (self, animal)
						if IsValid(animal) then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalTamed",
					Handler = function (self, unit, animal, success, reason)
						if success and IsValid(animal) then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
			},
			priority = "AnimalAlert",
			remove_invalid_objs = true,
			rollover_text = T(561515660398, --[[ModItemNotificationPreset AnimalAttack rollover_text]] "The following animals are exhibiting hostile behavior towards the camp and its inhabitants.<newline><newline><notif_list_units('AnimalAttack', false, 'by_class_id')>"),
			rollover_title = T(638488043624, --[[ModItemNotificationPreset AnimalAttack rollover_title]] "Animal attacks"),
			save_in = "Mod/TGkJ3Tu",
			suppressable = false,
			text = T(967680094442, --[[ModItemNotificationPreset AnimalAttack text]] "Animal attack: <em><notif_list_units('AnimalAttack', 'count only')></em>"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			dismissable = false,
			group = "Default",
			id = "AnimalAttack_Spawned",
			msg_reactions = {
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorEnqueued",
					Handler = function (self, animal, behavior)
						if IsValid(animal) and IsKindOfClasses(behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") then
							if animal:IsKindOf("UnitAnimal") then
								self:AddObject(animal)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorAssign",
					Handler = function (self, animal, new_behavior)
						if IsKindOfClasses(new_behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") then
							self:RemoveObject(animal)
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitDied",
					Handler = function (self, unit)
						if IsValid(unit) then
							self:RemoveObject(unit)
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalTamed",
					Handler = function (self, unit, animal, success, reason)
						if success and IsValid(animal) then
							self:RemoveObject(animal)
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalDone",
					Handler = function (self, animal)
						if IsValid(animal) then
							self:RemoveObject(animal)
						end
					end,
				}),
			},
			priority = "AnimalAlert",
			remove_invalid_objs = true,
			rollover_text = T(244905598533, --[[ModItemNotificationPreset AnimalAttack_Spawned rollover_text]] "The following animals have noticed the camp and are preparing to attack in several hours.<newline><newline><notif_list_units('AnimalAttack_Spawned', false, 'by_class_id')>"),
			rollover_title = T(900684981804, --[[ModItemNotificationPreset AnimalAttack_Spawned rollover_title]] "Aggressive animals"),
			save_in = "Mod/TGkJ3Tu",
			suppressable = false,
			text = T(473127939178, --[[ModItemNotificationPreset AnimalAttack_Spawned text]] "Aggressive animals: <em><notif_list_units('AnimalAttack_Spawned', 'count only')></em>"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			CanChangeGameSpeed = function (self) return GetAccountStorageOptionValue("AnimalAttackEffect") < 3 end,
			CanChangeGameSpeedLimit = function (self) return GetAccountStorageOptionValue("AnimalAttackEffect") == 1 end,
			dismissable = false,
			game_speed = "normal",
			game_speed_limit = "fast",
			game_speed_limit_duration = 40000,
			group = "Default",
			id = "RobotAttack",
			msg_reactions = {
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorAssign",
					Handler = function (self, animal, new_behavior)
						if not animal:IsKindOf("Robot") then return end
						 
						if IsKindOfClasses(new_behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") and not animal:IsDead() and not animal.forced_pacification then
							NotificationObjRem("RobotAttack_Spawned", animal)
							if self:AddObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorExpire",
					Handler = function (self, animal, behavior)
						if not IsKindOfClasses(behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") or animal:IsDead() or animal.forced_pacification then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitChangeAttackTarget",
					Handler = function (self, unit, target, old_target)
						-- This msg handles a robot's transfer between Search party landed and Consortium attack notifications.
						if unit:IsKindOf("Robot") then
						
							-- The robot is attacking any human combat group target
							-- => remove it from Search party landed and add it to  Consortium attack
							local human_group = Human.CombatGroup
							if IsValid(target) and target.CombatGroup == human_group and unit.CombatGroup ~= human_group then
								NotificationObjRem("RobotAttack_Spawned", unit)
								if self:AddObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
								
							-- The robot is not attacking any human target (anymore) but it will somewhen become aggressive
							-- => send it back to Search party landed notification
							elseif table.findfirst(unit.invader_behaviours, function(_, behaviour) return IsKindOfClasses(behaviour, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") end) then 
								NotificationObjAdd("RobotAttack_Spawned", unit)
								if self:RemoveObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
								
							-- The robot is not attacking any human target and will not become aggressive and IS NOT aggressive anymore
							-- => just remove (will be removed from everywhere)
							elseif (unit.forced_aggression_until or 0) < GameTime() or unit.forced_pacification then
								if self:RemoveObject(unit) then
									Msg("AnimalAttackCountChanged", self.id)
								end
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitDied",
					Handler = function (self, unit)
						if IsValid(unit) then
							if self:RemoveObject(unit) then
								Msg("AnimalAttackCountChanged", self.id) 
							end
						end
					end,
				}),
			},
			priority = "AnimalAlert",
			remove_invalid_objs = true,
			rollover_text = T(156872672493, --[[ModItemNotificationPreset RobotAttack rollover_text]] "The following automated consortium assault robots have been tasked to destroy Hope and everything that stays on their way.<newline><newline><notif_list_units('RobotAttack', false, 'by_class_id')>"),
			rollover_title = T(636154201211, --[[ModItemNotificationPreset RobotAttack rollover_title]] "Consortium attack"),
			save_in = "Mod/TGkJ3Tu",
			suppressable = false,
			text = T(815574955109, --[[ModItemNotificationPreset RobotAttack text]] "Consortium attack: <em><notif_list_units('RobotAttack', 'count only')></em>"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			dismissable = false,
			group = "Default",
			id = "RobotAttack_Spawned",
			msg_reactions = {
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorEnqueued",
					Handler = function (self, animal, behavior)
						if not animal:IsKindOf("Robot") then return end
						
						if IsValid(animal) and IsKindOfClasses(behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") then
							self:AddObject(animal)
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorAssign",
					Handler = function (self, animal, new_behavior)
						if IsKindOfClasses(new_behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") then
							self:RemoveObject(animal)
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitDied",
					Handler = function (self, unit)
						if IsValid(unit) then
							self:RemoveObject(unit)
						end
					end,
				}),
			},
			priority = "AnimalAlert",
			remove_invalid_objs = true,
			rollover_text = T(197694743001, --[[ModItemNotificationPreset RobotAttack_Spawned rollover_text]] "The following automated consortium assault robots have detected us and are preparing to attack in several hours.<newline><newline><notif_list_units('RobotAttack_Spawned', false, 'by_class_id')>"),
			rollover_title = T(202493608080, --[[ModItemNotificationPreset RobotAttack_Spawned rollover_title]] "Search party"),
			save_in = "Mod/TGkJ3Tu",
			suppressable = false,
			text = T(715728216572, --[[ModItemNotificationPreset RobotAttack_Spawned text]] "Search party landed: <em><notif_list_units('RobotAttack_Spawned', 'count only')></em>"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			CanChangeGameSpeedLimit = function (self) return GetAccountStorageOptionValue("AnimalAttackEffect") == 1 end,
			dismissable = false,
			fx_action = "UINotificationAnimalAttack",
			game_speed = "normal",
			id = "UnitsScouting",
			msg_reactions = {
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorAssign",
					Handler = function (self, animal, new_behavior)
						if IsKindOfClasses(new_behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") and not animal:IsDead() and not animal.forced_pacification then
							if animal:IsKindOf("UnitAnimal") then
								NotificationObjRem("AnimalAttack_Spawned", animal)
								if self:AddObject(animal) then
									Msg("AnimalAttackCountChanged", self.id)
								end
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "InvaderBehaviorExpire",
					Handler = function (self, animal, behavior)
						if not IsKindOfClasses(behavior, "InvaderBehaviourAggressive", "InvaderBehaviourBerserk") or animal:IsDead() or animal.forced_pacification then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "UnitDied",
					Handler = function (self, unit)
						if IsValid(unit) then
							if self:RemoveObject(unit) then
								Msg("AnimalAttackCountChanged", self.id) 
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalDone",
					Handler = function (self, animal)
						if IsValid(animal) then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
				PlaceObj('MsgReaction', {
					Event = "AnimalTamed",
					Handler = function (self, unit, animal, success, reason)
						if success and IsValid(animal) then
							if self:RemoveObject(animal) then
								Msg("AnimalAttackCountChanged", self.id)
							end
						end
					end,
				}),
			},
			priority = "AnimalAlert",
			remove_invalid_objs = true,
			rollover_text = T(405116275636, --[[ModItemNotificationPreset UnitsScouting rollover_text]] "The following animals are alone and scouting the nearby area.<newline>Kill them before returning to their home and report what they find!<newline><newline><notif_list_units('UnitsScouting', false, 'by_class_id')>"),
			rollover_title = T(163183732848, --[[ModItemNotificationPreset UnitsScouting rollover_title]] "Nests are scouting!"),
			save_in = "Mod/TGkJ3Tu",
			suppressable = false,
			text = T(578516300472, --[[ModItemNotificationPreset UnitsScouting text]] "Animal attack: <em><notif_list_units('UnitsScouting', 'count only')></em>"),
		}),
		PlaceObj('ModItemStoryBit', {
			NotificationPriority = "Critical",
			NotificationTitle = T(182342563992, --[[ModItemStoryBit unable_to_scout NotificationTitle]] "NA Code Alert"),
			Text = T(414523202193, --[[ModItemStoryBit unable_to_scout Text]] 'The Lua code in "The Nests Awaken!" mod has soft failed.\nA nest tried to send a unit to scout a specific area of the map, but failed to find a point to go to.\nIn order for me to improve the code in this mod, please go to the steam/nexus forums and tell me the following:\n\n<ScoutFailed()>'),
			Title = T(795131068782, --[[ModItemStoryBit unable_to_scout Title]] "Nest Awaken Failure"),
			id = "unable_to_scout",
			save_in = "Mod/TGkJ3Tu",
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "DrakaNestSpawned",
			rollover_text = T(753812064855, --[[ModItemNotificationPreset DrakaNestSpawned rollover_text]] "A group of crystals has breached the earth near us"),
			rollover_title = T(863979633496, --[[ModItemNotificationPreset DrakaNestSpawned rollover_title]] "New Draka Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(986925361504, --[[ModItemNotificationPreset DrakaNestSpawned text]] "New Crystal Structures observed!"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "ShoguNestSpawned",
			rollover_text = T(984181902160, --[[ModItemNotificationPreset ShoguNestSpawned rollover_text]] "A concentrated area is now afflicted by a massive blight!"),
			rollover_title = T(616614314552, --[[ModItemNotificationPreset ShoguNestSpawned rollover_title]] "New Shogu Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(578859029100, --[[ModItemNotificationPreset ShoguNestSpawned text]] "Death, Disease, and Doom!"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "DeathflyNestSpawned",
			rollover_text = T(157678601320, --[[ModItemNotificationPreset DeathflyNestSpawned rollover_text]] "We have detected a rock cliff that has a large Hummingfly populattion"),
			rollover_title = T(194979347062, --[[ModItemNotificationPreset DeathflyNestSpawned rollover_title]] "New Deathfly Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(578772512520, --[[ModItemNotificationPreset DeathflyNestSpawned text]] "The air fills with buzzing "),
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "GlutchNestSpawned",
			rollover_text = T(590152504714, --[[ModItemNotificationPreset GlutchNestSpawned rollover_text]] "The smell is coming from this direction!"),
			rollover_title = T(652545019840, --[[ModItemNotificationPreset GlutchNestSpawned rollover_title]] "New Glutch Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(316070871639, --[[ModItemNotificationPreset GlutchNestSpawned text]] "What's that smell in the air?"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "JunoNestSpawned",
			rollover_text = T(132479633385, --[[ModItemNotificationPreset JunoNestSpawned rollover_text]] "A nest has twisted and morphed into a Juno nest!"),
			rollover_title = T(253480175100, --[[ModItemNotificationPreset JunoNestSpawned rollover_title]] "New Juno Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(790350405960, --[[ModItemNotificationPreset JunoNestSpawned text]] "A nest has violently changed!"),
		}),
		PlaceObj('ModItemNotificationPreset', {
			expiration = 480000,
			fx_action = "UINotificationImportant",
			game_time = true,
			id = "NothNestSpawned",
			rollover_text = T(608350033794, --[[ModItemNotificationPreset NothNestSpawned rollover_text]] "Based on scouting, the debris seems to still retain its structural integrity. Meaning pure metal, not scrap!"),
			rollover_title = T(215311316484, --[[ModItemNotificationPreset NothNestSpawned rollover_title]] "New Noth Nest"),
			save_in = "Mod/TGkJ3Tu",
			text = T(992516573479, --[[ModItemNotificationPreset NothNestSpawned text]] "Copious Orbital debris detected!"),
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
		PlaceObj('ModItemNotificationPreset', {
			expiration = 60000,
			expiration_bar = true,
			fx_action = "UINotificationAnimalAttack",
			id = "nests_disgorged",
			rollover_text = T(337902645815, --[[ModItemNotificationPreset nests_disgorged rollover_text]] "A nearby nest has created too many creatures and let some loose!"),
			save_in = "Mod/TGkJ3Tu",
			text = T(818323081200, --[[ModItemNotificationPreset nests_disgorged text]] "A nest has released roaming units!"),
		}),
		}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Nest Agnostic",
	'NameColor', RGBA(255, 232, 45, 255),
}, {
	PlaceObj('ModItemHealthCondition', {
		AffectableBodyParts = {
			PlaceObj('HealthConditionBodyParts', {
				param_bindings = false,
			}),
		},
		Description = T(911023712614, --[[ModItemHealthCondition nest_attack_speed Description]] "This unit has been given faster movement to ensure that an attack hits."),
		DisplayName = T(207697159669, --[[ModItemHealthCondition nest_attack_speed DisplayName]] "Nitrus Stim"),
		FloatingTextType = "Icon only",
		MovementModifier = 50000,
		StackLimit = 5,
		Type = "Buff",
		UnitTags = set( "Animal" ),
		id = "nest_attack_speed",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "OnObjUpdate",
				Handler = function (self, target, time, update_interval)
					decay_speed(target)
				end,
				param_bindings = false,
			}),
		},
	}),
	PlaceObj('ModItemRobotCondition', {
		Description = T(232340131393, --[[ModItemRobotCondition nest_attack_speed_robot Description]] "A statistically significant amount of WD-40 has been applied to this units appendages."),
		DisplayName = T(603190182564, --[[ModItemRobotCondition nest_attack_speed_robot DisplayName]] "Ni7rus Infus3d 4pp3nd4g3s"),
		Modifiers = {
			PlaceObj('ModifyRobot', {
				Id = "autoid_TGkJ3Tu_cpAMuKn",
				add = 50000,
				param_bindings = false,
				prop = "Movement",
			}),
		},
		StackLimit = 5,
		id = "nest_attack_speed_robot",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "OnObjUpdate",
				Handler = function (self, target, time, update_interval)
					decay_speed(target)
				end,
				param_bindings = false,
			}),
		},
	}),
	PlaceObj('ModItemRobotCondition', {
		Description = T(177828090740, --[[ModItemRobotCondition scouting_sight_buff_robot Description]] "We are detecting increased power usage in the visual receptors of this unit.\nIt will be difficult to sneak past this clunker!"),
		DisplayName = T(718554350451, --[[ModItemRobotCondition scouting_sight_buff_robot DisplayName]] "Enhanced Sight"),
		OnAdd = function (self, owner, ...)
			owner.old_sight_range = owner.SightRange
			owner.SightRange = 30 * guim
		end,
		OnRemove = function (self, owner, ...)
			owner.SightRange = owner.old_sight_range
		end,
		id = "scouting_sight_buff_robot",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemHealthCondition', {
		AffectableBodyParts = {
			PlaceObj('HealthConditionBodyParts', {
				BodyPart = "All",
				param_bindings = false,
			}),
		},
		Description = T(113780200993, --[[ModItemHealthCondition scouting_sight_buff_animal Description]] "This units eyes are in the highest percentile.\nIt must have a purpose for them!"),
		DisplayName = T(890372951801, --[[ModItemHealthCondition scouting_sight_buff_animal DisplayName]] "Enhanced Sight"),
		FloatingTextType = "Display name",
		OnAdd = function (self, owner, ...)
			owner.old_sight_range = owner.SightRange
			owner.SightRange = 30 * guim
		end,
		OnRemove = function (self, owner, ...)
			owner.SightRange = owner.old_sight_range
		end,
		Type = "Buff",
		id = "scouting_sight_buff_animal",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemSpawnDef', {
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_spawn_fake(self, spawn_class, target,context)
		end,
		PostSpawn = function (self, obj, target, context)
			obj.CombatHostile = false
			if IsKindOf(obj,'Robot') then
				obj:SetInvader(true)
			end
			give_nest_speed_effect(obj,self.nest.proximity)
		end,
		SpawnClass = "Shrieker_Hatchling",
		SpawnTimeLimit = false,
		TargetFilter = function (obj) return not obj:IsVirtual() end,
		id = "nest_overflow",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Cond = function (self, target, context, progress)
			if self.location then return true else return false end
		end,
		FindSpawnLoc = function (self, spawn_class, target, context)
			local def = spawn_class and g_Classes[spawn_class]
			print('The input spawn_class was: ',spawn_class.class,' which resolved too: ', def)
			print("The actual spawn class is: ",self:ResolveSpawnClass().class)
			local center = self.location
			print(center)
			local pfclass = def.pfclass
			local radius = self.radius
			print(radius)
			local pos = terrain.FindPassableTile(center, const.tfpPassClass, pfclass)
			local target_retry = 4
			for i=1,target_retry do
				local x, y = GetRandomPlayablePos(pos, radius, guim, self.location:RandSeed("SpawnNestMember"), pfclass, def.radius)
				if x then
					print("Found a spot!")
					print(point(x,y))
					return point(x, y)
				end
			end
		end,
		PostSpawn = function (self, obj, target, context)
			obj:SetInvader(true)
			print("In mod editors post spawn!")
			if Hope then
				obj:Face(Hope)
			end
			Msg("SpawnedAnimalThreat", obj)
		end,
		SpawnClass = "LightHostileRobot_LVL1",
		id = "single_spawn_around_loc",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Behaviours = {
			PlaceObj('InvaderBehaviourSupport', {
				'Duration', 0,
				'ArrivalDistance', 5000,
			}),
		},
		CheckConnectivity = true,
		ClearArea = 256,
		ClearRadius = 1000,
		DistFromOthers = 1000,
		EnabledInTutorial = true,
		EnabledWithoutSurvivors = false,
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_attack_spawn(self,spawn_class, target, context)
		end,
		SpawnAsGroup = true,
		SpawnClass = "Scissorhands_T5",
		SurvivorDistMax = -1000,
		SurvivorSpawnDistMin = 75000,
		TargetClass = "Human",
		TargetDistMax = 150000,
		TargetDistMin = 75000,
		TargetFilter = function (obj) return not obj:IsVirtual() end,
		TargetStartPosOnMissingTarget = true,
		group = "Attacks_Insects_NEW",
		id = "Support_same_species_passive",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Behaviours = {
			PlaceObj('InvaderBehaviourPassiveMove', {
				'complex_targeting', true,
				'targeting_function', function (self, invader, progress)
					local nest_class = invader:GetNestClass()
					local map = MapFindNearest(true, true, nest_class, function(nest)
						if nest:IsAsleep() then
							return true
						end
					end)
					return map
				end,
				'on_arrival', function (invader, target, progress)
					target:support_arrived()
					RemoveAttachedUIToObject(invader, 'NestRolePermanent')
					RemoveAttachedUIToObject(invader, 'NestRoleClose')
					RemoveAttachedUIToObject(invader, 'NestRoleFar')
					invader:SetCommand("CmdDespawn")
					return true
				end,
				'proximity', 5000,
			}),
		},
		CheckConnectivity = true,
		ClearArea = 256,
		ClearRadius = 1000,
		DistFromOthers = 1000,
		EnabledInTutorial = true,
		EnabledWithoutSurvivors = false,
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_attack_spawn(self,spawn_class, target, context)
		end,
		SpawnAsGroup = true,
		SpawnClass = "Scissorhands_T5",
		SurvivorDistMax = -1000,
		SurvivorSpawnDistMin = 75000,
		TargetClass = "Human",
		TargetDistMax = 150000,
		TargetDistMin = 75000,
		TargetFilter = function (obj) return not obj:IsVirtual() end,
		TargetStartPosOnMissingTarget = true,
		group = "Attacks_Insects_NEW",
		id = "Nest_wakeup_alarm_passive",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Behaviours = {
			PlaceObj('InvaderBehaviourNestScout', {
				'Duration', 960000,
				'RandomDuration', 960000,
				'NoSleep', false,
				'log_classes', {
					"TerritorialNest",
				},
				'distance_points', 15000,
				'SearchLabels', {},
			}),
			PlaceObj('InvaderBehaviourPassiveMove', {
				'Duration', 0,
				'complex_targeting', true,
				'targeting_function', function (self, invader, progress) return invader.from_nest end,
				'on_arrival', function (invader, target, progress)
					local quad_no = invader.target_quadrant
					local species = invader.from_nest.nest_species
					local objects_to_report = invader.observed_objects
					local player_found = invader.player_found
					local nest = invader.from_nest
					ReportScoutingResults(quad_no,species,objects_to_report,player_found,nest)
					invader:SetCommand("CmdDespawn")
					return true
				end,
			}),
		},
		CheckConnectivity = true,
		ClearArea = 256,
		ClearRadius = 1000,
		DistFromOthers = 1000,
		EnabledInTutorial = true,
		EnabledWithoutSurvivors = false,
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_attack_spawn(self,spawn_class, target, context)
		end,
		PostSpawn = function (self, obj, target, context)
			obj.from_nest = self.location
		end,
		SpawnAsGroup = true,
		SpawnClass = "Scissorhands_T5",
		SurvivorDistMax = -1000,
		SurvivorSpawnDistMin = 75000,
		TargetClass = "Human",
		TargetDistMax = 150000,
		TargetDistMin = 75000,
		TargetFilter = function (obj) return not obj:IsVirtual() end,
		TargetStartPosOnMissingTarget = true,
		group = "Attacks_Insects_NEW",
		id = "Nest_scout_passive",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemAnimalSpawnDef', {
		Behaviours = {
			PlaceObj('InvaderBehaviourNestScout', {
				'Duration', 960000,
				'RandomDuration', 960000,
				'NoSleep', false,
				'map_hack', true,
				'log_classes', {
					"TerritorialNest",
				},
				'distance_points', 15000,
				'SearchLabels', {},
			}),
			PlaceObj('InvaderBehaviourPassiveMove', {
				'Duration', 0,
				'complex_targeting', true,
				'targeting_function', function (self, invader, progress) return invader.from_nest end,
				'on_arrival', function (invader, target, progress)
					local quad_no = invader.target_quadrant
					local species = invader.from_nest.nest_species
					local objects_to_report = invader.observed_objects
					local player_found = invader.player_found
					local nest = invader.from_nest
					ReportScoutingResults(quad_no,species,objects_to_report,player_found,nest)
					invader:SetCommand("CmdDespawn")
					return true
				end,
			}),
		},
		CheckConnectivity = true,
		ClearArea = 256,
		ClearRadius = 1000,
		DistFromOthers = 1000,
		EnabledInTutorial = true,
		EnabledWithoutSurvivors = false,
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_attack_spawn(self,spawn_class, target, context)
		end,
		PostSpawn = function (self, obj, target, context)
			obj.from_nest = self.location
		end,
		SpawnAsGroup = true,
		SpawnClass = "Scissorhands_T5",
		SurvivorDistMax = -1000,
		SurvivorSpawnDistMin = 75000,
		TargetClass = "Human",
		TargetDistMax = 150000,
		TargetDistMin = 75000,
		TargetFilter = function (obj) return not obj:IsVirtual() end,
		TargetStartPosOnMissingTarget = true,
		group = "Attacks_Insects_NEW",
		id = "Nest_scout_passive_map_hacks",
		save_in = "Mod/TGkJ3Tu",
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
		EnabledWithoutSurvivors = false,
		FindSpawnLoc = function (self, spawn_class, target, context)
			return nest_find_attack_spawn(self,spawn_class, target, context)
		end,
		PostSpawn = function (self, obj, target, context)
			obj.CombatHostile = true
			if IsKindOf(obj,'Robot') then
				obj:SetInvader(true)
			end
			give_nest_speed_effect(obj,self.nest.proximity)
			Msg("SpawnedAnimalThreat", obj)
		end,
		SpawnAsGroup = true,
		SpawnClass = "Skarabei_Manhunting",
		SurvivorDistMax = -1000,
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
		MaxSurfRadius2D = 16419,
		ModEditor = true,
		NetHash = 6462337141065913116,
		ObjectsHash = -6804332748817026938,
		OrgLuaRevision = 373414,
		TerrainHash = 4333834435235192014,
		group = "PrefabMap",
		id = "nest_prefab_holder",
		markers = {
			PlaceObj('Marker', {
				'name', "Prefab.Any.DeathflyNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1013387562,
				'pos', point(112800, 7200),
				'data', 'return {name="DeathflyNest_1",marker={handle = 1013387562,map = "nest_prefab_holder"},hash=135155036285599059,revision=29397,tags=set( "deathfly_nest" ),poi_type="deathfly_prefab_POI",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=7823967666307924114,type_names={Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=9669,obj_max_radius=18117,obj_avg_radius=13640,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.DeathflyNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1404260631,
				'pos', point(158400, 14400),
				'data', 'return {name="DeathflyNest_2",marker={handle = 1404260631,map = "nest_prefab_holder"},hash=6632860962453397847,revision=29397,tags=set( "deathfly_nest" ),poi_type="deathfly_prefab_POI",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=7823967666307924114,type_names={Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=6,obj_min_radius=9669,obj_max_radius=18117,obj_avg_radius=14386,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.DeathflyNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1352949102,
				'pos', point(211200, 7200),
				'data', 'return {name="DeathflyNest_3",marker={handle = 1352949102,map = "nest_prefab_holder"},hash=6303509568111995613,revision=29397,tags=set( "deathfly_nest" ),poi_type="deathfly_prefab_POI",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=7823967666307924114,type_names={Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=9669,obj_max_radius=17045,obj_avg_radius=11299,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.DrakaNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1577367090,
				'pos', point(86400, 153600),
				'data', 'return {name="DrakaNest_1",marker={handle = 1577367090,map = "nest_prefab_holder"},hash=8374742566722619209,revision=29397,tags=set( "draka_nest" ),poi_type="draka_prefab_POI",poi_area="Default",size=point(38400, 36000),height_hash=-3728813377058611528,height_offset=-1380,min=point(18, 0, 0),max=point(19, 0, 0),type_hash=-5139052757907770137,type_names={Sand_01 = 0},grass_hash=-7706353853377573960,mask_hash=-6286075657234199774,total_area=3341,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=5777,obj_max_radius=9788,obj_avg_radius=7559,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.DrakaNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1271768253,
				'pos', point(127200, 153600),
				'data', 'return {name="DrakaNest_2",marker={handle = 1271768253,map = "nest_prefab_holder"},hash=-1948620672027865257,revision=29397,tags=set( "draka_nest" ),poi_type="draka_prefab_POI",poi_area="Default",size=point(40800, 38400),height_hash=-7953869838558056685,height_offset=-1380,min=point(25, 0, 0),max=point(26, 0, 0),type_hash=-8286268467544983987,type_names={Sand_01 = 0},grass_hash=3000296992726779196,mask_hash=7748238865320147437,total_area=3480,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=5777,obj_max_radius=9788,obj_avg_radius=7559,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.DrakaNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1203850354,
				'pos', point(180000, 153600),
				'data', 'return {name="DrakaNest_3",marker={handle = 1203850354,map = "nest_prefab_holder"},hash=-3915254795876775120,revision=29397,tags=set( "draka_nest" ),poi_type="draka_prefab_POI",poi_area="Default",size=point(40800, 38400),height_hash=-7953869838558056685,height_offset=-1380,min=point(25, 0, 0),max=point(26, 0, 0),type_hash=-8286268467544983987,type_names={Sand_01 = 0},grass_hash=3000296992726779196,mask_hash=7748238865320147437,total_area=3480,min_radius=33,max_radius=33,obj_count=9,obj_min_radius=7766,obj_max_radius=9788,obj_avg_radius=8268,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.GlutchNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1211193707,
				'pos', point(124800, 117600),
				'data', 'return {name="GlutchNest_1",marker={handle = 1211193707,map = "nest_prefab_holder"},hash=4339673577767762315,revision=29397,tags=set( "glutch_nest" ),poi_type="glutch_prefab_POI",poi_area="Default",size=point(36000, 33600),height_hash=6143602635854926162,height_offset=-1380,min=point(12, 0, 0),max=point(13, 0, 0),type_hash=-8333799106890059670,type_names={Sand_01 = 0},grass_hash=-1077138140842274167,mask_hash=-2325952025988458901,total_area=3111,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=6063,obj_max_radius=9480,obj_avg_radius=6789,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.GlutchNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1737024683,
				'pos', point(160800, 117600),
				'data', 'return {name="GlutchNest_2",marker={handle = 1737024683,map = "nest_prefab_holder"},hash=-5615833062888629902,revision=29397,tags=set( "glutch_nest" ),poi_type="glutch_prefab_POI",poi_area="Default",size=point(38400, 36000),height_hash=-3728813377058611528,height_offset=-1380,min=point(18, 0, 0),max=point(19, 0, 0),type_hash=-5139052757907770137,type_names={Sand_01 = 0},grass_hash=-7706353853377573960,mask_hash=-6286075657234199774,total_area=3341,min_radius=33,max_radius=33,obj_count=10,obj_min_radius=6063,obj_max_radius=9480,obj_avg_radius=6737,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.GlutchNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1893536629,
				'pos', point(204000, 117600),
				'data', 'return {name="GlutchNest_3",marker={handle = 1893536629,map = "nest_prefab_holder"},hash=9157779191047929978,revision=29397,tags=set( "glutch_nest" ),poi_type="glutch_prefab_POI",poi_area="Default",size=point(31200, 28800),height_hash=-248886648011861244,height_offset=-1380,min=point(3, 0, 0),max=point(4, 0, 0),type_hash=2001221726883916425,type_names={Sand_01 = 0},mask_hash=-5311499434744909019,total_area=2483,min_radius=33,max_radius=33,obj_count=8,obj_min_radius=6063,obj_max_radius=9480,obj_avg_radius=6802,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.JunoNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1795474988,
				'pos', point(261600, 72000),
				'data', 'return {name="JunoNest_1",marker={handle = 1795474988,map = "nest_prefab_holder"},hash=-48953567680203679,revision=29397,tags=set( "juno_nest" ),poi_type="juno_prefab_POI",poi_area="Default",size=point(31200, 28800),height_hash=-248886648011861244,height_offset=-1380,min=point(3, 0, 0),max=point(4, 0, 0),type_hash=2001221726883916425,type_names={Sand_01 = 0},mask_hash=-5311499434744909019,total_area=2483,min_radius=33,max_radius=33,obj_count=11,obj_min_radius=1632,obj_max_radius=16361,obj_avg_radius=3685,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.JunoNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1823835206,
				'pos', point(264000, 38400),
				'data', 'return {name="JunoNest_2",marker={handle = 1823835206,map = "nest_prefab_holder"},hash=-8484542572144654014,revision=29397,tags=set( "juno_nest" ),poi_type="juno_prefab_POI",poi_area="Default",size=point(36000, 31200),height_hash=-7012718594217010565,height_offset=-1380,min=point(9, 0, 0),max=point(10, 0, 0),type_hash=-3628522840939498031,type_names={Sand_01 = 0},grass_hash=-5100044955091474218,mask_hash=4399537818667326791,total_area=2953,min_radius=33,max_radius=33,obj_count=12,obj_min_radius=1632,obj_max_radius=16361,obj_avg_radius=3548,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.JunoNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1675415579,
				'pos', point(261600, 2400),
				'data', 'return {name="JunoNest_3",marker={handle = 1675415579,map = "nest_prefab_holder"},hash=-2808288468863089603,revision=29397,tags=set( "juno_nest" ),poi_type="juno_prefab_POI",poi_area="Default",size=point(36000, 31200),height_hash=-7012718594217010565,height_offset=-1380,min=point(9, 0, 0),max=point(10, 0, 0),type_hash=-3628522840939498031,type_names={Sand_01 = 0},grass_hash=-5100044955091474218,mask_hash=4399537818667326791,total_area=2953,min_radius=33,max_radius=33,obj_count=14,obj_min_radius=1632,obj_max_radius=16361,obj_avg_radius=3083,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.NothNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1580665493,
				'pos', point(273600, 112800),
				'data', 'return {name="NothNest_1",marker={handle = 1893536629,map = "nest_prefab_holder"},hash=8908233822329379118,revision=29397,tags={noth_nest = true},poi_type="noth_prefab_POI",poi_area="Default",size=point(33600, 31200),height_hash=5956781812321257378,height_offset=-1380,min=point(7, 0, 0),max=point(8, 0, 0),type_hash=-2622297160058893600,type_names={Sand_01 = 0},grass_hash=-315783998437808945,mask_hash=1740846206681711898,total_area=2821,min_radius=33,max_radius=33,obj_count=4,obj_min_radius=9783,obj_max_radius=22891,obj_avg_radius=15114,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.NothNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1658623959,
				'pos', point(237600, 112800),
				'data', 'return {name="NothNest_2",marker={handle = 1893536629,map = "nest_prefab_holder"},hash=6983266379184442540,revision=29397,tags={noth_nest = true},poi_type="noth_prefab_POI",poi_area="Default",size=point(36000, 33600),height_hash=6143602635854926162,height_offset=-1380,min=point(12, 0, 0),max=point(13, 0, 0),type_hash=-8333799106890059670,type_names={Sand_01 = 0},grass_hash=-1077138140842274167,mask_hash=-2325952025988458901,total_area=3111,min_radius=33,max_radius=33,obj_count=4,obj_min_radius=9783,obj_max_radius=26648,obj_avg_radius=16053,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.NothNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1388475990,
				'pos', point(232800, 146400),
				'data', 'return {name="NothNest_3",marker={handle = 1893536629,map = "nest_prefab_holder"},hash=4645230315982543691,revision=29397,tags={noth_nest = true},poi_type="noth_prefab_POI",poi_area="Default",size=point(45600, 38400),height_hash=-6549386369235014482,height_offset=-1380,min=point(29, 0, 0),max=point(30, 0, 0),type_hash=4063681269166082260,type_names={Sand_01 = 0},grass_hash=5212561961266167142,mask_hash=691182317215739379,total_area=3480,min_radius=33,max_radius=33,obj_count=4,obj_min_radius=9783,obj_max_radius=26648,obj_avg_radius=18303,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.ShoguNest_1",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1453647788,
				'pos', point(16800, 108000),
				'data', 'return {name="ShoguNest_1",marker={handle = 1453647788,map = "nest_prefab_holder"},hash=-6941156582252333101,revision=29397,tags=set( "shogu_nest" ),poi_type="shogu_prefab_POI",poi_area="Default",size=point(31200, 33600),height_hash=1902113982775383388,height_offset=-1380,min=point(8, 0, 0),max=point(9, 0, 0),type_hash=2925692936579879992,type_names={J_Moss_02 = 76,J_Mud_Wet_01_C2 = 128,J_RottenDebris = 130,Sand_01 = 0},grass_hash=-6026276753270001954,mask_hash=4262202329953289337,total_area=2821,min_radius=33,max_radius=33,obj_count=7,obj_min_radius=3348,obj_max_radius=11114,obj_avg_radius=6802,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.ShoguNest_2",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1780854719,
				'pos', point(43200, 146400),
				'data', 'return {name="ShoguNest_2",marker={handle = 1780854719,map = "nest_prefab_holder"},hash=7373634782575465288,revision=29397,tags=set( "shogu_nest" ),poi_type="shogu_prefab_POI",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=4775245814782822181,type_names={J_Moss_02 = 76,J_RottenDebris = 130,Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=6,obj_min_radius=3348,obj_max_radius=11114,obj_avg_radius=9109,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.ShoguNest_3",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1281200655,
				'pos', point(69600, 100800),
				'data', 'return {name="ShoguNest_3",marker={handle = 1281200655,map = "nest_prefab_holder"},hash=9127421368563366498,revision=29397,tags=set( "shogu_nest" ),poi_type="shogu_prefab_POI",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=-1472319479703434153,type_names={J_Moss_02 = 76,J_RottenDebris = 130,Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=3348,obj_max_radius=9480,obj_avg_radius=6630,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_01",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1354319414,
				'pos', point(55200, 14400),
				'data', 'return {name="SpawnConsortiumNest_01",marker={handle = 1354319414,map = "nest_prefab_holder"},hash=-2835052706437093650,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=2577293333366477412,type_names={Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=9682,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_02",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1353441996,
				'pos', point(14400, 55200),
				'data', 'return {name="SpawnConsortiumNest_02",marker={handle = 1353441996,map = "nest_prefab_holder"},hash=-5784223780377171972,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(43200, 43200),height_hash=-6554566506273212218,height_offset=-1380,min=point(31, 3, 0),max=point(32, 3, 0),type_hash=7823967666307924114,type_names={Sand_01 = 0},grass_hash=-7711233824600437866,mask_hash=941958136439644175,total_area=3513,min_radius=33,max_radius=33,obj_count=5,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=10929,}',
				'data_version', "1",
			}),
			PlaceObj('Marker', {
				'name', "Prefab.Any.SpawnConsortiumNest_03",
				'type', "Prefab",
				'map', "nest_prefab_holder",
				'handle', 1725445525,
				'pos', point(14400, 14400),
				'data', 'return {name="SpawnConsortiumNest_03",marker={handle = 1725445525,map = "nest_prefab_holder"},hash=3041846299786586056,revision=29265,tags=set( "ConsortiumNest" ),poi_type="ConsortiumNest",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=2577293333366477412,type_names={Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=6,obj_min_radius=7806,obj_max_radius=17187,obj_avg_radius=11448,}',
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
				'pos', point(115200, 69600),
				'data', 'return {name="SpawnScissorNest_3",marker={handle = 1854838865,map = "nest_prefab_holder"},hash=-8965496017074680859,revision=29265,tags=set( "scissorhands_nest" ),poi_type="scissor_prefab_POI",poi_area="Default",size=point(40800, 40800),height_hash=-2928276238898405165,height_offset=-1380,min=point(29, 1, 0),max=point(30, 1, 0),type_hash=2577293333366477412,type_names={Sand_01 = 0},grass_hash=3102784033714780765,mask_hash=-4434506287469529529,total_area=3521,min_radius=33,max_radius=33,obj_count=12,obj_min_radius=1455,obj_max_radius=9680,obj_avg_radius=3666,}',
				'data_version', "1",
			}),
		},
		save_in = "Mod/TGkJ3Tu",
	}),
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
		Category = "Exploration",
		Enabled = true,
		Image = "UI/Messages/Expeditions/exp_5_tall_stones",
		NotificationText = T(790456924082, --[[ModItemStoryBit NA_Ritual_Site NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(427346054794, --[[ModItemStoryBit NA_Ritual_Site Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
		Title = T(689773556964, --[[ModItemStoryBit NA_Ritual_Site Title]] "[The Nests Awaken] Ritual Site"),
		group = "Expedition_FollowUP",
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
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/throw_ritual.jpg",
		NotificationText = T(131050927229, --[[ModItemStoryBit NA_Ritual_Site_free NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(301381575679, --[[ModItemStoryBit NA_Ritual_Site_free Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
		Title = T(461204223176, --[[ModItemStoryBit NA_Ritual_Site_free Title]] "[The Nests Awaken] Ritual Site"),
		group = "Expedition_FollowUP",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Free_ritual.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Free_ritual.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Free_ritual.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Free_ritual.jpg",
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
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/throw_ritual.jpg",
		NotificationText = T(532895415046, --[[ModItemStoryBit NA_Ritual_Site_throw NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(490463520105, --[[ModItemStoryBit NA_Ritual_Site_throw Text]] "In the middle of all the pillars was a giant circular hewn staircase going down into the earth.\n\nI cautiously ventured down, and at the bottom was a grueling sight.\n\nA Shrieker, a Scissorhand, and a Robot have vines growing through them.\nThey are all weak and bleeding (or leaking) into a dark pit in the middle of the room.\n\nWhat should I do?"),
		Title = T(445367552988, --[[ModItemStoryBit NA_Ritual_Site_throw Title]] "[The Nests Awaken] Ritual Site"),
		group = "Expedition_FollowUP",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/throw_ritual.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/throw_ritual.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/throw_ritual.jpg",
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
PlaceObj('ModItemExpeditionPreset', {
	DisplayImage = "UI/Messages/Expeditions/exp_5_tall_stones",
	Expiration = 4800000,
	FoundByExplorationWeight = 30,
	Icon = "UI/Icons/Expeditions/5_tall_stones",
	Obsolete = true,
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
	'name', "Meta",
	'NameColor', RGBA(194, 183, 100, 255),
}, {
	PlaceObj('ModItemTutorialHint', {
		Hints = {
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/NestUI.JPG",
				Text = T(375361284496, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>1 of 6</em>\nThe Nests of this world are now <em>more complex</em>, <style TextNegative>deadly</style>, and can work together!\n\nEach species is very in tune with <em>certain resources</em>.\nAnd when you use them, that species will deploy scouts to try and find out who is messing with their favorite things."),
			}),
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/AngryNest.PNG",
				Text = T(283738735418, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>2 of 6</em>\nOnce a nest is alerted to you (Or another enemy species), a nest will become active.\nAn active nest will constantly perform one of the following actions:\n#1. Consume nearby resources.\n#2. Deploy attack waves at a random enemy (If it is the closest nest to said enemy)\n#3. Send supporting units to the closest nest to a random enemy (If not closest nest to the enemy)\n#4. Deploy more & faster scouts, to find more enemies.\n#6. Send supporting units to un-alerted nests of it's own species.\n\n<style TextNegative>Nests will grow stronger with time.</style>\nBecause the nests are constantly evolve their defending units, and the units they attack with."),
			}),
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/nesting_icons.JPG",
				Text = T(467697453699, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>3 of 6</em>\n\nThis mod has enemy units not just attacking you, with scouting & supporting behaviors currently added.\nTo help you determine how much a thing needs to die, there is a mod option that allows the game to display a units icon/role.\nWith the mod options defining the distance you need to zoom in to see the icons (if at all).\nThe following icons, from left to right, mean:\n- The unit is guarding a nearby nest\n- The unit is going to a nearby friendly nest, and on arrival will grant a boon to said nest\n- The unit is scouting a specific part of the map, looking for it's species enemies\n- The unit is scouting, and has found you!\n\nNote: In general <em>if</em> you manage to stop a non-attacking unit from reaching it's source nest, the nest will not gain the benefit.\n(Which includes knowledge about you!)"),
			}),
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ConsortiumNestVariant.PNG",
				Text = T(760322908319, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>4 of 6</em>\n\nBut there are only Shrieker and Scissorhands nests in the game?\n<style TextNegative>WRONG!</style>\n\nThis mod has also taught the following units how to build & defend a nest.\nGlutches, Draka, Shogu, Noth, Dragonfly, Juno, & The Consortium\n* Consortium Nests only allowed if you have the Robots DLC.\n\nEach nest has conditions on when it will start to spawn; and each species has unique resources they care about.\nGood luck meeting all the new neighbors!"),
			}),
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/notifications.PNG",
				Text = T(400960854348, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>5 of 6</em>\n\nFor each nest species (All 9!) there is a new expedition site! With each site containing 3 unique vignettes.\nThe rewards can be, but are not limited to:\n-- High tier Tamed animals, forcing nests to go back to sleep, massive resource hoards, and some treats I won't spoilt etc...\n<style TextNegative>But there are consequences</style> that can be, but are not limited to:\n-- Many nests spawning awake and angry, immediate multiple attacks, entire species permanently becoming hostile.\n\nIf an outcome grants a major bonus, this will usually also incur a major downside.\nAnd outcomes with small benefits have no downside."),
			}),
			PlaceObj('TutorialHintItem', {
				Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
				Text = T(864350757194, --[[ModItemTutorialHint nests_awaken_tutorial Text]] "<em>6 of 6</em>\n\nIf you see this in any images from this mod (Or in any other mod I built/maintain) or by itself....\nConsider it an <em>active commission</em> to make a Stranded Alien Dawn version of the image.\nI am not a graphic artist or artistic in any way, and have had to resort to AI images or already made ones.\nWhich can really mess with my immersion.\n\nYou can reach out to me on the Git repo, Steam mod page, or Nexus mods. And let me know what image you would like to replace and your fee for use in the mod."),
			}),
		},
		Tutorial = "",
		display_name = T(204424421469, --[[ModItemTutorialHint nests_awaken_tutorial display_name]] "3.0 Nests Awaken Tutorial"),
		id = "nests_awaken_tutorial",
		mod_version_major = 1,
		msg_reactions = {
			PlaceObj('MsgReaction', {
				Event = "GameStarted",
				Handler = function (self)
					NA_tutorial()
				end,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
	}),
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
		Description = T(963092369040, --[[ModItemRobotCondition FamiliarGroundRobo Description]] "A nearby Pylon is granting this unit a temporary shield giving <style TextPositive>50% damage reduction</style> and regeneration.\nThis shield lasts for 1 day after combat starts and takes 7 days to recharge."),
		DisplayName = T(359172351610, --[[ModItemRobotCondition FamiliarGroundRobo DisplayName]] "Nearby Pylon"),
		Modifiers = {
			PlaceObj('ModifyRobot', {
				Id = "autoid_TGkJ3Tu_QRkNWV7",
				add = 10000,
				param_bindings = false,
				prop = "Regeneration",
			}),
		},
		OnAdd = function (self, owner, ...)
			self.shield_gone = 0
			self.shield_refresh = 0
		end,
		Polarity = "positive",
		ShowFloatingText = false,
		StackLimit = 1,
		id = "FamiliarGroundRobo",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "ModifyDamageReceived",
				Handler = function (self, target, damage, weapon_def, attacker)
					local deflect = false
					if self.shield_gone == 0 or self.shield_refresh < GameTime() or self.shield_gone > GameTime() then
						self.shield_gone = GameTime() + const.DayDuration
						self.shield_refresh = GameTime() + (const.DayDuration*7)
						deflect = true
					end
					if deflect then
						return DivRound(damage,2)
					else
					    return damage
					end
				end,
				param_bindings = false,
			}),
		},
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
	PlaceObj('ModItemOptionNumber', {
		'name', "max_global_nests",
		'DisplayName', "Max Nests on Map",
		'Help', "More total nests allowed == worse performance",
		'DefaultValue', 20,
		'MinValue', 10,
		'MaxValue', 50,
	}),
	PlaceObj('ModItemOptionNumber', {
		'name', "max_nest",
		'DisplayName', "Max nests (Per Species)",
		'Help', "How many nests a single species can have on the map, the higher the nest count the deadlier to you (And your PC)!",
		'DefaultValue', 13,
		'MinValue', 8,
		'MaxValue', 20,
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "NA_Visuals",
		'DisplayName', "Nest Role Visuals",
		'Help', "Nesting units will show their role via an icon floating above their head. This setting changes how zoomed in before they appear.",
		'OnApply', function (self, value, prev_value)
			Msg("UpdateNestRoleVisuals")
		end,
		'DefaultValue', "Far (~80 meters)",
		'ChoiceList', {
			"Close (Same as Resource Piles) (~20 meters)",
			"Far (~80 meters)",
			"Always on",
			"Always off",
		},
	}),
	PlaceObj('ModItemOptionToggle', {
		'name', "NA_show_name",
		'DisplayName', "NA Roles with Names",
		'Help', "Toggle on to show icon & name of enemy unit",
		'OnApply', function (self, value, prev_value)
			Msg("UpdateNestRoleVisuals")
		end,
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "Nest Content: Shogu",
}, {
	PlaceObj('ModItemRobotCondition', {
		Description = T(664187819182, --[[ModItemRobotCondition shogu_nest_robo_decay Description]] "A nearby Shogu nest is nullifying my integrity."),
		DisplayName = T(273325155640, --[[ModItemRobotCondition shogu_nest_robo_decay DisplayName]] "CORROSION DETECTED"),
		Modifiers = {
			PlaceObj('ModifyRobot', {
				Id = "autoid_TGkJ3Tu_FNvmd5m",
				add = -5000,
				param_bindings = false,
				prop = "Regeneration",
			}),
		},
		Polarity = "negative",
		StackLimit = 1,
		id = "shogu_nest_robo_decay",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "OnObjUpdate",
				Handler = function (self, target, time, update_interval)
					local nearest_shogu = MapFindNearest(target,true,'ShoguNest')
					if not nearest_shogu then
						target:RemoveHealthCondition(self)
					elseif not IsCloser2D(target, nearest_shogu, nearest_shogu.territorial_range) then
						target:RemoveHealthCondition(self)
					end
				end,
				param_bindings = false,
			}),
		},
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("ShoguNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"shogu_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "ShoguNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(109886000401, --[[ModItemTech FieldShoguSpore Description]] "The air smells sickly sweet, and we suspect that our olfactory senses are missing things.\nOur conclusion is as follows:\nDo not go anywhere near these structures without <em>massive</em> precautionary measures are taken.\nThese pustule entrance any nearby wildlife, causing them to rub themselves against these structures.\nThe hidden parasites and the potent bacteria just below the structures surface immediately start to eat the creature alive.\nLarger animals get pressed against the rock by what's left of a nearby \"Shogu\"."),
		DisplayName = T(994565061301, --[[ModItemTech FieldShoguSpore DisplayName]] "Parasitic Pustule"),
		DisplayNamePl = T(329773819227, --[[ModItemTech FieldShoguSpore DisplayNamePl]] "Parasitic Pustules"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShoguNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldShoguSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemHealthCondition', {
		AffectableBodyParts = {
			PlaceObj('HealthConditionBodyParts', {
				BodyPart = "All",
				param_bindings = false,
			}),
		},
		BleedingModifier = 5000,
		Description = T(889322338635, --[[ModItemHealthCondition shogu_nest_bio_decay Description]] "A nearby Shogu nest is poisoning me!"),
		DisplayName = T(152148294754, --[[ModItemHealthCondition shogu_nest_bio_decay DisplayName]] "Blighted Land"),
		StackLimit = 1,
		Type = "UntreatedDisease",
		VomitChance = 20,
		Vomiting = true,
		id = "shogu_nest_bio_decay",
		save_in = "Mod/TGkJ3Tu",
		unit_reactions = {
			PlaceObj('UnitReaction', {
				Event = "OnObjUpdate",
				Handler = function (self, target, time, update_interval)
					local nearest_shogu = MapFindNearest(target,true,'ShoguNest')
					if not nearest_shogu then
						target:RemoveHealthCondition(self)
					elseif not IsCloser2D(target, nearest_shogu, nearest_shogu.territorial_range) then
						target:RemoveHealthCondition(self)
					end
				end,
				param_bindings = false,
			}),
		},
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ShoguNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_shogu')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(350988880615, --[[ModItemStoryBit new_nest_shogu NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(898228788625, --[[ModItemStoryBit new_nest_shogu NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(319726521854, --[[ModItemStoryBit new_nest_shogu Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(975870355206, --[[ModItemStoryBit new_nest_shogu Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_shogu",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			shogu_nest = true,
		},
		id = "nesting_shogu",
		nest_class = "ShoguNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "FuelManure",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "SmokeleafDry",
				'amount', 10000,
			}),
			PlaceObj('ResAmount', {
				'resource', "SmokeleafRaw",
				'amount', 10000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawnable = false,
		spawner_storybit = "new_nest_shogu",
		spore_buildings = "ShoguSporeDeposit",
		unit_species = "species_shogu",
	}),
	PlaceObj('ModItemPrefabType', {
		'Id', "shogu_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "shogu_nest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "shogu_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "shogu_nest" ),
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
		'Id', "shogu_nest",
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
	}),
PlaceObj('ModItemFolder', {
	'name', "Nest Content: Juno",
}, {
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(544361423556, --[[ModItemTech FieldJunoSpore Description]] "Much like how Human body cells tend to randomly become cancerous... it appears that something similar is occurring at a planet wide level.\nWhat was once another species has been taken over by... the Juno Cancer?\n\nRegardless, all prior nest structures are now single-celled muscles.\nThey react and spasm to the slightest chance, even when the wind changes speed."),
		DisplayName = T(994055036347, --[[ModItemTech FieldJunoSpore DisplayName]] "Macro-Cancer Cell"),
		DisplayNamePl = T(643029103333, --[[ModItemTech FieldJunoSpore DisplayNamePl]] "Macro-Cancer Cells"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/JunoNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldJunoSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("JunoNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"juno_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		comment = "Special Juno spawning",
		group = "StoryBits",
		id = "JunoNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Midnight",
		Effects = {
			PlaceObj('StoryBitActivate', {
				ForcePopup = false,
				Id = "new_nest_juno_actual",
				param_bindings = false,
			}),
			PlaceObj('SetCooldownEffect', {
				Cooldown = "juno_cancer",
				TimeScale = "months",
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(426534389094, --[[ModItemStoryBit new_nest_juno_trigger NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(248666482877, --[[ModItemStoryBit new_nest_juno_trigger NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		Prerequisites = {
			PlaceObj('CheckCooldown', {
				Cooldown = "juno_cancer",
				param_bindings = false,
			}),
		},
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(985386679829, --[[ModItemStoryBit new_nest_juno_trigger Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(597265661220, --[[ModItemStoryBit new_nest_juno_trigger Title]] "A meteor is landing nearby"),
		Trigger = "Midnight",
		group = "Default",
		id = "new_nest_juno_trigger",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Midnight",
		Effects = {
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					local converted_nest = Juno_Cancer(force)
					AddGameNotification("JunoNestSpawned", nil, nil, {converted_nest})
					mark_spawned_nest('nesting_juno')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(487636351064, --[[ModItemStoryBit new_nest_juno_actual NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(594898957822, --[[ModItemStoryBit new_nest_juno_actual NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		Prerequisites = {
			PlaceObj('CheckRandom', {
				Chance = 5,
				param_bindings = false,
			}),
			PlaceObj('CheckExpression', {
				Expression = function (self, obj)
					local nest_convertible = MapCount(true,'TerritorialNest',function(nest)
					if nest.class ~= 'JunoNest' and nest.spawned_on + const.Scale.years < GameTime() then
						return true
					end 
					end)
					return nest_convertible > 0
				end,
				param_bindings = false,
			}),
		},
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(705328008759, --[[ModItemStoryBit new_nest_juno_actual Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(548712859034, --[[ModItemStoryBit new_nest_juno_actual Title]] "A meteor is landing nearby"),
		Trigger = "Midnight",
		group = "Default",
		id = "new_nest_juno_actual",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			juno_nest = true,
		},
		comment = "Has no resources, spawns a special way",
		id = "nesting_juno",
		nest_class = "JunoNest",
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_juno_actual",
		spore_buildings = "JunoSporeDeposit",
		unit_species = "species_juno",
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "juno_nest",
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
		'Id', "juno_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "juno_nest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "juno_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "juno_nest" ),
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
	PlaceObj('ModItemCooldownDef', {
		DisplayName = T(474218699172, --[[ModItemCooldownDef juno_cancer DisplayName]] "Juno Cancer"),
		MaxTime = 92160000,
		TimeMax = 92160000,
		TimeMin = 23040000,
		TimeScale = "months",
		id = "juno_cancer",
		save_in = "Mod/TGkJ3Tu",
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "New Content: Glutch",
}, {
	PlaceObj('ModItemHealthCondition', {
		AffectedArea = "outline",
		ConsciousnessModifier = -10000,
		Coughing = true,
		Description = T(661142601070, --[[ModItemHealthCondition glutch_fumes Description]] "The air has some very light fog every morning.\nIt is noticeably harder to breath, sleep, work, and harder to stay comfortable...\nIt all started when those weird trees bloomed, the ones Glutches seem to love.\n<em>Respirator based tools will remove this.<em>"),
		DisplayName = T(102721215106, --[[ModItemHealthCondition glutch_fumes DisplayName]] "Something is in the air"),
		IsCompatible = function (self, owner, ...) return not (self:HasValidSurvivalTool("RespiratorMask") or self:HasValidSurvivalTool("TacticalMaskPX")) end,
		Modifiers = {
			PlaceObj('ModifyHuman', {
				Id = "autoid_TGkJ3Tu_RhcVdm6",
				mul = 1050,
				param_bindings = false,
				prop = "EnergyUsePerDay",
			}),
			PlaceObj('ModifyHuman', {
				Id = "autoid_TGkJ3Tu_jMjTde",
				add = -5000,
				param_bindings = false,
				prop = "TemperatureHigh",
			}),
			PlaceObj('ModifyHuman', {
				Id = "",
				add = 5000,
				param_bindings = false,
				prop = "TemperatureLow",
			}),
		},
		PainModifier = 10000,
		StackLimit = 15,
		Type = "Buff",
		UnitTags = set( "Animal", "Human" ),
		id = "glutch_fumes",
		msg_reactions = {
			PlaceObj('MsgReaction', {
				Event = "UnitUpdate",
				Handler = function (self, unit, time, update_interval)
					if not IsKindOf(unit, "Human") then return end
					if time / 10000 == (time + update_interval) / 10000 then
						return
					end
					local glutch_nests = MapCount(true,'GlutchNest')
					if not glutch_nests or glutch_nests == 0 then return end
					--unit:SetColorModifier(RandColor())
					local stacks = count_effects_by_id(unit,self.id)
					if (unit:HasValidSurvivalTool("RespiratorMask") or unit:HasValidSurvivalTool("TacticalMaskPX")) or not unit:IsOutside() then
						unit:RemoveHealthConditions(self.id, 'condition not applicable')
					elseif stacks > glutch_nests then
						local remove = stacks - glutch_nests
						for i=1,1,remove do
							unit:RemoveHealthCondition(self.id,'less glutch nests')
						end
					elseif stacks < glutch_nests then
							unit:AddHealthCondition(self.id)
					end
				end,
				param_bindings = false,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(645621011088, --[[ModItemTech FieldGlutchSpore Description]] "These hollowed out trees, newly named Gipe, generate a methane-like gas!\nTheir trunks are hollow, and resemble industrial grade pipes back on earth.\nThis gas must be the cause of the recent hallucinogenic episodes we have experienced.\n\nThe nearby Glutch can be seen sucking(?) on a branch, and that must be their favorite meal"),
		DisplayName = T(799299459119, --[[ModItemTech FieldGlutchSpore DisplayName]] "Gipe Trees"),
		DisplayNamePl = T(661318137505, --[[ModItemTech FieldGlutchSpore DisplayNamePl]] "Gipe Trees"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/GlutchNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldGlutchSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("GlutchNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"glutch_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "GlutchNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "GlutchNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesing_glutch')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(541641436971, --[[ModItemStoryBit new_nest_glutch NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(504538267993, --[[ModItemStoryBit new_nest_glutch NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(756744237257, --[[ModItemStoryBit new_nest_glutch Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(979015077197, --[[ModItemStoryBit new_nest_glutch Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_glutch",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			glutch_nest = true,
		},
		aggressive = false,
		id = "nesting_glutch",
		nest_class = "GlutchNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "LiquidFuel",
				'amount', 50000,
			}),
			PlaceObj('ResAmount', {
				'resource', "PurpleLeaf",
				'amount', 30000,
			}),
			PlaceObj('ResAmount', {
				'resource', "PayahBark",
				'amount', 50000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_glutch",
		spore_buildings = "GlutchSporeDeposit",
		unit_species = "species_glutch",
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "glutch_nest",
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
		'Id', "glutch_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "glutch_nest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "glutch_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "glutch_nest" ),
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
	}),
PlaceObj('ModItemFolder', {
	'name', "New Content: Noth",
}, {
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(958888258506, --[[ModItemTech FieldNothSpore Description]] "The higher evolved Noth seem drawn to the debris that didn't land hard against this planet.\nThe higher quality metal seem to be used as food.\nAlthough early observations claimed that the Noth would... absorb the metal just by rubbing against it...."),
		DisplayName = T(634571905234, --[[ModItemTech FieldNothSpore DisplayName]] "High Quality Debris"),
		DisplayNamePl = T(188861337660, --[[ModItemTech FieldNothSpore DisplayNamePl]] "High Quality Debris"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/NothNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldNothSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("NothNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"noth_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "NothNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemEntity', {
		'name', "noth_anvil",
		'class_parent', "Deposition,NothSporeDeposit",
		'ClassParents', {
			"Deposition",
			"NothSporeDeposit",
		},
		'entity_name', "Noth_Anvil",
		'material', {
			"Noth_Anvil_Noth_Anvil",
		},
		'mesh', {
			"Noth_Anvil_Noth_Anvil.m",
		},
		'texture', {
			"7010000",
			"7010002",
			"7010003",
		},
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "NothNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_noth')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(140089047880, --[[ModItemStoryBit new_nest_noth NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(597141047859, --[[ModItemStoryBit new_nest_noth NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(696782011354, --[[ModItemStoryBit new_nest_noth Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(879463957682, --[[ModItemStoryBit new_nest_noth Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_noth",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			noth_nest = true,
		},
		aggressive = false,
		id = "nesting_metal_boar",
		nest_class = "NothNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "Brick",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "Concrete",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "Metal",
				'amount', 100000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_shogu",
		spore_buildings = "NothSporeDeposit",
		unit_species = "species_noth",
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "noth_nest",
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
	PlaceObj('ModItemPrefabPOI', {
		'Id', "noth_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "noth_nest" ),
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
		'Id', "NothNest",
		'OnObjOverlap', 3,
		'Tags', set( "noth_nest" ),
	}),
	}),
PlaceObj('ModItemFolder', {
	'name', "New Content: Draka",
}, {
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(502037061529, --[[ModItemTech FieldDrakaSpore Description]] "These crystal outcroppings are somehow..... alive?\nClose inspection reveals small consistent growth, almost like branches on a tree.\nWhen any Draka move near, shards fly out and latch themselves to its exoskeleton.\n\nThis must be at least partially responsible for the Draka's species evolutions!\n"),
		DisplayName = T(391497886521, --[[ModItemTech FieldDrakaSpore DisplayName]] "Draka Crystals"),
		DisplayNamePl = T(722344111941, --[[ModItemTech FieldDrakaSpore DisplayNamePl]] "Draka Crystals"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/DrakaNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldDrakaSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("DrakaNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"draka_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "DrakaNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "DrakaNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_draka')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(236489551736, --[[ModItemStoryBit new_nest_draka NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(633753453556, --[[ModItemStoryBit new_nest_draka NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(470958532767, --[[ModItemStoryBit new_nest_draka Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(448258832581, --[[ModItemStoryBit new_nest_draka Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_draka",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			draka_nest = true,
		},
		aggressive = false,
		id = "nesting_draka",
		nest_class = "DrakaNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "EnergyCrystals",
				'amount', 50000,
			}),
			PlaceObj('ResAmount', {
				'resource', "BuzzShroom",
				'amount', 10000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_draka",
		spore_buildings = "DrakaSporeDeposit",
		unit_species = "species_draka",
	}),
	PlaceObj('ModItemPrefabTag', {
		'Id', "draka_nest",
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
		'Id', "draka_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "draka_nest" ),
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "draka_prefab_POI",
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
	}),
PlaceObj('ModItemFolder', {
	'name', "New Content: Deathfly",
}, {
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(646892311086, --[[ModItemTech FieldDeathflySpore Description]] "These rocks are more like an incredibly sturdy and fast growing tree.\nWith an immediate growth spurt once enough energy has been stored.\nThis... species? have many small holes in its surface.\n\nWhich seem to be a natural fit for the wasp like Deathflys.\nTheir acid lengthens these tunnels, and that's where Deathflys strengthen their brood,"),
		DisplayName = T(855109380784, --[[ModItemTech FieldDeathflySpore DisplayName]] "Deathfly Cliff"),
		DisplayNamePl = T(436149707631, --[[ModItemTech FieldDeathflySpore DisplayNamePl]] "Deathfly Cliff"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/DeathflyNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldDeathflySpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
	}),
	PlaceObj('ModItemSpawnDef', {
		Cond = return_true,
		FindSpawnLoc = function (self, spawn_class, target)
			return self:ResolveTarget()
		end,
		PostSpawn = function (self, obj, target, context)
			AddGameNotification("DeathflyNestSpawned", nil, nil, {obj})
		end,
		Spawn = function (self, target, spawn_class)
			return SpawnNestInsideMap(target,nil,"deathfly_nest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "DeathflyNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "DeathflyNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_deathfly')
				end,
				param_bindings = false,
			}),
		},
		Enabled = true,
		HasNotification = false,
		HasPopup = false,
		NotificationPriority = "Important",
		NotificationText = T(667168308905, --[[ModItemStoryBit new_nest_deathfly NotificationText]] "A meteor is landing nearby"),
		NotificationTitle = T(787368822463, --[[ModItemStoryBit new_nest_deathfly NotificationTitle]] "A meteor is landing nearby"),
		OneTime = false,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(663260679498, --[[ModItemStoryBit new_nest_deathfly Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(316659300035, --[[ModItemStoryBit new_nest_deathfly Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_deathfly",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			deathfly_nest = true,
		},
		id = "nesting_deathfly",
		nest_class = "DeathflyNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "OilAnimal",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "Oil",
				'amount', 100000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_deathfly",
		spore_buildings = "DeathflySporeDeposit",
		unit_species = "species_dragonfly",
	}),
	PlaceObj('ModItemPrefabPOI', {
		'Id', "deathfly_prefab_POI",
		'SortKey', 66,
		'PlaceModel', "terrain",
		'RadiusEstim', "bestfit",
		'FillRadius', 8000,
		'MaxCount', 0,
		'Tags', set( "deathfly_nest" ),
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
		'Id', "deathfly_nest",
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
		'Id', "deathfly_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "deathfly_nest" ),
	}),
	PlaceObj('ModItemExpeditionPreset', {
		DisableList = {
			PlaceObj('Explanation', {
				'Conditions', {
					PlaceObj('CheckExpression', {
						Expression = function (self, obj) return false end,
					}),
				},
			}),
		},
		DisplayImage = "UI/Messages/Expeditions/exp_5_tall_stones",
		Expiration = 4800000,
		FoundByExplorationDisplayText = T(241929342418, --[[ModItemExpeditionPreset NA_Exped_Deathfly_Nest_3 FoundByExplorationDisplayText]] "Nest_Species_Savegame_Stats['DeathflyNest']['spawnflag'] = true"),
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/5_tall_stones",
		Obsolete = true,
		OneTime = true,
		RelevantSkills = set( "Farming", "Healing" ),
		StoryBits = {
			PlaceObj('ExpeditionStoryBitWeight', {
				'StoryBit', "NA_deathfly_exp_1",
			}),
		},
		UILineColor = 4293083197,
		description = T(234587525360, --[[ModItemExpeditionPreset NA_Exped_Deathfly_Nest_3 description]] "A thick column of smoke is rising from this area."),
		display_name = T(650882215927, --[[ModItemExpeditionPreset NA_Exped_Deathfly_Nest_3 display_name]] "Thick smoke"),
		id = "NA_Exped_Deathfly_Nest_3",
		mod_version_major = 3,
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Expedition",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/DragonflySwarm.PNG",
		NotificationText = T(160772523165, --[[ModItemStoryBit NA_deathfly_exp_1 NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(230111664251, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Well good news there isn't a brush fire.\nBad news, it's a dust devil made by a swarm of Dragonfly's headed this way!\n\nSuddenly being in a very flammable, slow, and big vehicle isn't very appealing...\nWhat should I do?"),
		Title = T(985850948102, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
		comment = "Flying swarm attack",
		group = "Expedition_FollowUP",
		id = "NA_deathfly_exp_1",
		max_reply_id = 3,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(520691799291, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Fly you fool!"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveTrait', {
					Trait = "Dragonfly_watcher",
					param_bindings = false,
				}),
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Construction",
					param_bindings = false,
				}),
			},
			Text = T(540877573297, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "I had to break down some of the carriage and use it as fuel.\nBut that gave the balloon a boost in both height and speed.\n\nThe Dragonflys didn't notice me hovering above, and I figured I would watch what they where doing.\nThe min-tornado stripped the topsoil and started to dig a hole into the earth itself!\nWhat was left was a large rock, and the Dragonflys collectively picked it up.\nThis was a fascinating display, and I took some notes on some of the more interesting parts.\n\n<em>Local dragonfly nests will now spawn.\nColonist gains a trait improving observation/research efficiency.\n</em>"),
			Title = T(889465807215, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(641775203562, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Fight your way out!"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ModifySkill', {
					Id = "autoid_TGkJ3Tu_bnmfqt3",
					Level = 2,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 2,
					Condition = ">=",
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('CheckExpression', {
					Expression = function (self, obj) return obj:HasRangedAttack() end,
					param_bindings = false,
				}),
			},
			Text = T(808980217950, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Well turns out Dragonfly's do not really like it when another flying thing is attacking them at range!\nTheir instincts must be more like prey against other sky creatures.....\n\nSetting that horrifying realization aside, I shot some down and landed to collect their meat.\nHopefully the Dragonfly's don't realize who started shooting at them....\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests can now spawn.\nDragonfly nests are going to be inherently hostile!\nColonist gains combat experience.\n</em>"),
			Title = T(330953351478, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveTrait', {
					Trait = "Dragonfly_watcher",
					param_bindings = false,
				}),
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 10000,
					Resource = "ChefsSteak",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Construction",
					param_bindings = false,
				}),
			},
			Text = T(607374492344, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "I had to break down most of the carriage.\nI then cranked up the heat lamp to it's maximum output, and shoved all that wood into the fuel.\n\nTurns out when something from above started spewing hot fire, Dragonfly's don't stick around to see if they can fight that off.\nThis means I have some cooked meat to collect.\n\nWhen I landed, I noticed a small rock that was half-exposed by the tornado.\nI took a piece from it to bring home as well!\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nColonist gains cooked meals.\nUnlock research investigating the special rock of the Dragonfly's.\n</em>"),
			Title = T(633835020765, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						obj:EjectAndStrand()
					end,
					param_bindings = false,
				}),
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Text = T(375208463852, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "<style TextNegative>MAYDAY MAYDAY WE ARE GOING DOWN.\nTHE DAMN DEATHFLYS PUT HOLES INTO THE BALLOON.</style>\n\nI don't have many places for a soft landing, let alone a landing zone without critters.....\nThis may be my last transmission.....\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\n<style TextNegative>\nDragonfly nests are now inherently hostile!\nColonist missing in action</style>"),
			Title = T(957136341347, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
			Weight = 20,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(552791266267, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Fly casual and stay the course"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ExecuteCode', {
					Code = function (self, obj)
						PlaceRandomExplorationSites(obj)
						PlaceRandomExplorationSites(obj)
						PlaceRandomExplorationSites(obj)
					end,
					param_bindings = false,
				}),
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Text = T(879432358752, --[[ModItemStoryBit NA_deathfly_exp_1 Text]] "Well turns out Deathfly's are still naturally passive creatures.\nSo the balloon didn't pop and leave me falling to my death, so that's nice.\n\nIt was a roller coaster, as I was caught in the tornado they summoned.\nAfter what felt like an eternity, the entire balloon was flung unceremoniously away.\n\nI stabilized my ride, but was well off course.\nI'm heading home, and I will mark down any new spots of interest I find.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\n3 new expedition sites discovered.\n</em>"),
			Title = T(421797323522, --[[ModItemStoryBit NA_deathfly_exp_1 Title]] "[The Nests Awaken] Deathfly Swarm"),
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Expedition",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/DeathflyMatriarch.PNG",
		NotificationText = T(169415572709, --[[ModItemStoryBit NA_deathfly_exp_2 NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(856899456860, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "Well the smoke was coming from a steam spewing cave.\nAs I got closer, a single gigantic Deathfly was laying inside.\n\nThere where dozens of eggs laid in weird protruding rocks.\nI can only assume this is a broodmother, preparing clutches to spread.\n\nI'm certain any movement I make towards the cave would result in the Deathfly to react defensively.\nWhat should I do?"),
		Title = T(349702585332, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
		comment = "Matriarch",
		group = "Expedition_FollowUP",
		id = "NA_deathfly_exp_2",
		max_reply_id = 4,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(102819202843, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "Try to communicate with it, that we are friendly"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 7,
					Condition = ">=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(319870924889, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "I placed a collection of rations and nearby food at the mouth of the cave and then backed away slowly.\nNot all of the food I had collected, and the Deathfly could still smell food on me.\n\nShe slowly waddled up and ate the food, then returned back to her spot.\nWith a blast of her wings, she rolled a rock to me. \nIt didn't have any eggs in it, and it was filled with pockmarks and holes.\n\nIt must mean something to them, and we can research it when I'm back.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nA research has unlocked to learn about the Deathfly rock.\n</em>"),
			Title = T(175900218427, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(861968247259, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "I put the food down and sat down next to it.\nEven made some cooing noises and mocked scratches with my hands.\nThe Deathfly didn't seem that impressed.... and didn't leave her spot.\n\nFrustration got the better of me, and I started to shout...\nShe did not like that one bit, and with a blast from her wings, I was pushed back into the balloon!\nSome smaller Deathfly's then flew up and pushed the balloon farther and farther away!\n\nHonestly, I am grateful they only did this and didn't just attack.\nIt also gave me some ideas on how to make balloon travel even better....\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nNew research available regarding expedition travel.</em>"),
			Title = T(625793983073, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Text = T(803153682592, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "The Matriarch did not appreciate my many many gestures of goodwill!\nStupid animals, unable to recognize tokens of friendship!\n\nI may or may not have sustained some acid burns, and based on the smaller Deathfly's I had to fight off to get back to the Balloon.... I'm not sure they will be friendly in the future.\nBut let the record show I tried!\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.</em>\n<style TextNegative>Dragonfly nests are now inherently hostile!</style>"),
			Title = T(543653203542, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(485113079625, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "Sneak in and grab an egg/rock"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Intellectual",
					param_bindings = false,
				}),
			},
			Text = T(457868723074, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "It may not have the most moral thing to do, but I wounded some smaller creatures and left them tied nearby.\n\nThis was too enticing of an offer for the nearby Deathflies and they proceeded to have a feast.\n\nI grabbed a rock with eggs and didn't stick around!\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nNew research available to examine the brood clutch.</em>"),
			Title = T(836946825417, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Text = T(484092531577, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "I explored nearby, looking for a suitably large rock to roll towards the cave.\nThankfully, there was one nearby, and I got it rolling.\n\nBut instead of rolling past the cave and spooking them away.....\nIt rolled directly into the cave, and the Deathfly stood her ground.\n\nGood news, I'm coming back with a lot of meat.\nBad news, that cave is now closed for business.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nColonist gained Construction skill level.\nColonist gains moderate amount of meat.</em>\n<style TextNegative>Dragonfly nests are now inherently hostile!</em>"),
			Title = T(143472997446, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			Weight = 20,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(325832019682, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "Try and scare it off"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Prerequisites = {
				PlaceObj('CheckOR', {
					Conditions = {
						PlaceObj('CheckIsAndroid', {
							param_bindings = false,
						}),
						PlaceObj('CheckSkillLevel', {
							Amount = 6,
							Condition = ">=",
							Skill = "Combat",
							param_bindings = false,
						}),
						PlaceObj('CheckTrait', {
							Trait = "became_death",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
			},
			Text = T(243114945982, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "I started to prepare for the worst.\nGot all my weapons in order, ammo to restock them, checked my armor.\n\nThe Deathfly Matriarch must has somehow recognized what I was doing.\nBecause it made an odd noise, and other Deathflys started to carry away the rock/eggs.\n\nI hastened my preparation and when I started walking towards the cave, the Deathfly's stopped taking the eggs away.\nI grabbed one and left before they collectively realized they could take me on!\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nColonist gained Construction skill level.\nNew research available to examine the brood clutch.</em>"),
			Title = T(457690605978, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('StoryBitActivate', {
					Id = "new_nest_deathfly",
					param_bindings = false,
				}),
			},
			Text = T(263663659407, --[[ModItemStoryBit NA_deathfly_exp_2 Text]] "I ran up and started shouting and banging my chest.\nThis.... did not go over well.\nWith a blast from the Matriarchs wings, I was pushed back into the balloon!\nSome smaller Deathfly's then flew up and pushed the balloon farther and farther away!\n\nHonestly, I am grateful they only did this and didn't just attack.\nIt also gave me some ideas on how to make balloon travel even better....\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nNew research available regarding expedition travel.</em>"),
			Title = T(873436179274, --[[ModItemStoryBit NA_deathfly_exp_2 Title]] "[The Nests Awaken] Deathfly Matriarch Cave"),
			Weight = 20,
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Expedition",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/brand_new_deathfly_nest.PNG",
		NotificationText = T(312390709618, --[[ModItemStoryBit NA_deathfly_exp_3 NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(104094270601, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "Well the smoke was a small object being carried by a group of Deathfly's.\nThey where flying low to the ground, seemingly wandering.\nOne would occasionally break off from the pack, fly nearby, then return.\n\nAfter a half dozen break offs, the group start hovering above a flat clearing.\nAnd the one carrying the smoking... rock(?) just dropped it.\n\nLo and behold, the second that thing landed, a sheer rock cliff grew from seemingly nothing!\nAnd out of the cliff came crawling baby Deathflys!\n\nI MUST get a sample of this cliff, but it may be dangerous...."),
		Title = T(394422715878, --[[ModItemStoryBit NA_deathfly_exp_3 Title]] "[The Nests Awaken] Deathfly Insta-cliff"),
		comment = "It's a cliff in a box",
		group = "Expedition_FollowUP",
		id = "NA_deathfly_exp_3",
		max_reply_id = 4,
		save_in = "Mod/TGkJ3Tu",
		PlaceObj('StoryBitReply', {
			Text = T(966515534093, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "Distract the main group and chisel a small piece"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(831263858786, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "I set up traps in preparation, and then sharpened my survival tools.\nThe traps caught some smaller prey, and I slaughtered just enough of them for their smell to waft towards the nest.\n\nOne by one, what looked like the entire group left to get a free meal.\nGiving me plenty of time to get a good sample.\n\nThe rock doesn't feel alive, and it's very porous.\nBut further inspection at base will give us more info.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nA research has unlocked to learn about the Deathfly rock.\n</em>"),
			Title = T(239614198996, --[[ModItemStoryBit NA_deathfly_exp_3 Title]] "[The Nests Awaken] Deathfly Insta-cliff"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Construction",
					param_bindings = false,
				}),
			},
			Text = T(237365953875, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "I took some of the food I had and left if nearby.\nI didn't know how much time that would buy me, but all those years of mining paid off.\nBecause I was able to knock a chunk loose in one hit.\n\nThe Deathfly rock is easier to break than the stone on the planet.\nBut further inspection at base will give us more info.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nA research has unlocked to learn about the Deathfly rock.\n</em>"),
			Title = T(748844352164, --[[ModItemStoryBit NA_deathfly_exp_3 Title]] "[The Nests Awaken] Deathfly Insta-cliff"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Text = T(711362572730, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "I took some of the food I had and left if nearby.\nBut a scouting Deathfly saw me right as I started to head to the nest...\n\nI didn't want to back out now, so I sprinted to the rock and carved a piece off.\nThe Deathflys of course did not take too kindly too this, and I'm a bit singed from their spit.\n\nThankfully once I sprinted off, they did not chase.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nA research has unlocked to learn about the Deathfly rock.\n</em>"),
			Title = T(605175457632, --[[ModItemStoryBit NA_deathfly_exp_3 Title]] "[The Nests Awaken] Deathfly Insta-cliff"),
			Weight = 20,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(515046751280, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "Observe the brand new cliff"),
			param_bindings = false,
			unique_id = 3,
		}),
		PlaceObj('StoryBitOutcome', {
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Construction",
					param_bindings = false,
				}),
			},
			Text = T(173559535498, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "The newly hatched Deathfly's are fully functional.\nI watched as packs split off and started to hunt the nearby wildlife.\n\n<em>A local dragonfly nest has spawned.\nDragonfly nests will now spawn.\nA research has unlocked to learn about the Deathfly rock.\n</em>"),
			Title = T(395442296810, --[[ModItemStoryBit NA_deathfly_exp_3 Title]] "[The Nests Awaken] Deathfly Insta-cliff"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(580803645001, --[[ModItemStoryBit NA_deathfly_exp_3 Text]] "Pick off lone Deathfly's to dwindle their numbers"),
			param_bindings = false,
			unique_id = 4,
		}),
	}),
	PlaceObj('ModItemTrait', {
		Description = T(948055913191, --[[ModItemTrait Dragonfly_watcher Description]] "Having survived a close ordeal with a mega-Scissorhands, this colonist has a +30% chance to dodge attacks in melee combat!"),
		DisplayName = T(887074351609, --[[ModItemTrait Dragonfly_watcher DisplayName |gender-variants]] "Survival of the Fittest"),
		id = "Dragonfly_watcher",
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
	}),
PlaceObj('ModItemFolder', {
	'name', "New Content: Consortium (Mining)",
}, {
	PlaceObj('ModItemTech', {
		Activity = "FieldResearch",
		Description = T(971095329043, --[[ModItemTech FieldConsortiumSpore Description]] "Based on what landed, this seems to be the Consortium's R.E.P.O. (Resource Extraction Prefab Objects) package.\n\nFrom their advertisement channel:\n<style TextPositive>Ever want to collect and hoard rare minerals but too lazy to leave your planet? Look no further! The R.E.P.O. prefab is a self-replicating automatazapalooza that can strip a planet dry within a decade!</style>\n<style FinePrint>Terms and conditions apply, The Consortium does not guarantee minimum efficiency of prefabs. To see the full disclaimer list, please visit the Consortium Headquarters during it's visitor hours on Mondays between 8 and 9 am.</style>"),
		DisplayName = T(919872346092, --[[ModItemTech FieldConsortiumSpore DisplayName]] "Consortium Prefab"),
		DisplayNamePl = T(553422873878, --[[ModItemTech FieldConsortiumSpore DisplayNamePl]] "Consortium Prefabs"),
		FieldResearchCategory = "Fauna",
		FieldResearchTemplateExpression = function (self) return ShriekerSporeDeposit end,
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/ConsortiumNestResearch.PNG",
		ResearchPoints = 4000,
		group = "Field",
		id = "FieldConsortiumSpore",
		money_value = 50000000,
		save_in = "Mod/TGkJ3Tu",
		tradable = false,
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
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "ConsortiumNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ConsortiumNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_consortium')
				end,
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
		Sets = set( "Negative" ),
		Text = T(485076708155, --[[ModItemStoryBit new_nest_consortium Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(992773234973, --[[ModItemStoryBit new_nest_consortium Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_consortium",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			ConsortiumNest = true,
		},
		id = "nesting_consortium",
		nest_class = "ConsortiumNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "Silicon",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "Synthetics",
				'amount', 100000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_consortium",
		spore_buildings = "ConsortiumSporeDeposit",
		unit_species = "species_consortium",
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
	PlaceObj('ModItemPrefabType', {
		'Id', "ConsortiumNest",
		'OnObjOverlap', 3,
		'Tags', set( "ConsortiumNest" ),
	}),
	PlaceObj('ModItemExpeditionPreset', {
		DisplayImage = "UI/Messages/Expeditions/exp_dogfight",
		Expiration = 4800000,
		FoundByExploration = true,
		FoundByExplorationWeight = 30,
		Icon = "UI/Icons/Expeditions/dogfight_site",
		OneInstanceOnly = true,
		OneTime = true,
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
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
		NotificationText = T(801489114182, --[[ModItemStoryBit Robot_Degraded_Prefab NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(613753515045, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] "I landed and found a group of tattered Consortium buildings.\nBite, claw, and acid burns are on everything.\nRobots with missing arms and limbs are trying to fell trees and break nearby stone.\n\nThis looks like a small automated mining base, and I see a drop box. We can get this base back up and running... or salvage it... \n\nWhat should I do?"),
		Title = T(275666857275, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
		group = "Expedition_FollowUP",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_consortium",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(505610405835, --[[ModItemStoryBit Robot_Degraded_Prefab Text]] 'There is a rumor that all Consortium Tech has a self destruct button hidden away.\nAnd in the middle of the main building was a big red button labeled "SDB". \nAfter a brisk jog away from the base, I felt the explosion and saw the smoke cloud.\n\nWe need to wait for it to cool down.\nBut after can strip that site of its metal!\n\n<em>This site becomes a repeatable metal expedition.</em>'),
			Title = T(618631955174, --[[ModItemStoryBit Robot_Degraded_Prefab Title]] "[The Nests Awaken] Consortium Mining Site"),
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
		NotificationText = T(541119697209, --[[ModItemStoryBit Robot_Diplo_Miscomm NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(930081331336, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'As I flew in, a Consortium drone flew up to me and said in multiple languages:\n\n"GREETINGS NATIVES, PLEASE LAND SO WE CAN DISCUSS FIRST CONTACT"\nAfter landing, the main building spat out a Robot in a fancy hat and monocle.\nIt stated "WELCOME, LET US NEGOTIATE MINING RIGHTS"\n\nShould I tell him? Or keep this charade up?'),
		Title = T(773066943050, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium First Contact"),
		group = "Expedition_FollowUP",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(646013289734, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] 'Before I ended up on this planet, I knew that the Consortium was just a robotics company. And they certainly did not have any authority to even send space ships, let alone mine!\n\nAs I explained, I was cutoff by the robot....\n"DIPLOMATIC COMMUNICATIONS HAVE BROKEN DOWN. LEAVE THE PREMISES BEFORE YOUR DIPLOMATIC IMMUNITY IS NULL AND VOID, AND ALERT YOUR CIVILIZATION WE DECLARE WAR."\n\n\n<em>Local Consortium Nest aggression levels raised.</em>'),
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(673450905611, --[[ModItemStoryBit Robot_Diplo_Miscomm Text]] "I asked to see a tour before we started to negotiate to 'make sure their stuff was top quality'.\n\nI also made sure to stress how culturally, I must \"bless\" everything that sparks with water.\nAnd those buckets of bolts just let me..... like their self-preservation code got turned off!\n\nNo sooner had I toured 2 buildings than everything was shorting, and a few fires broke out!\nNeedless to say, I got to pick what I wanted to bring home from the negotiations!\n\n<em>Hoard of silicon and metal acquired.\nLocal Consortium Aggression increased</em>"),
			Title = T(966655008822, --[[ModItemStoryBit Robot_Diplo_Miscomm Title]] "[The Nests Awaken] Consortium Mining Site"),
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
		NotificationText = T(624375902685, --[[ModItemStoryBit Robot_Fake_Settlement NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(400841303990, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'I landed in a "town" called "TOTALLYHUMANVILLE" according to its giant banner.\nClearly Consortium Robots in tattered clothes are standing still saying "I need to file my taxes this year".\nCages with animals (some dead, some alive) are all stacked on top each. With a giant sign above it reading "PLEASE AWW AT OUR PETS".\n\nOne of the Robots eventually wanders up and says "HELLO, WE NEED TO TEST YOU TO MAKE SURE YOUR NOT A ROBOT. PLEAS ANSWER OUR QUESTIONS"'),
		Title = T(139755321033, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] A totally human settlement"),
		group = "Expedition_FollowUP",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_T5",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(781495852780, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'Through a combination of trickery, flattery, and acting like I believed the robots, I managed to break some cages.\nThe animals that were healthy enough started to rampage across the "town".\nThe animal whose cage I opened first seemed to take a liking to me, and it seems to want to come home with me.\n\n<em>High Tier animal will be brought back from this expedition.\nLocal Consortium Aggression levels increased.</em>'),
			Title = T(608221526455, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel_T5",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(283543309898, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'Through a combination of trickery, flattery, and acting like I believed the robots, I managed to break some cages.\nThe animals that were healthy enough started to rampage across the "town".\nThe animal whose cage I opened first seemed to take a liking to me, and it seems to want to come home with me.\n\n<em>High Tier animal will be brought back from this expedition.\nLocal Consortium Aggression levels increased.</em>'),
			Title = T(610497723071, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Ulfen_T5",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_consortium",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
			Text = T(713255838775, --[[ModItemStoryBit Robot_Fake_Settlement Text]] 'Through a combination of trickery, flattery, and acting like I believed the robots, I managed to break some cages.\nThe animals that were healthy enough started to rampage across the "town".\nThe animal whose cage I opened first seemed to take a liking to me, and it seems to want to come home with me.\n\n<em>High Tier animal will be brought back from this expedition.\nLocal Consortium Aggression levels increased.</em>'),
			Title = T(982790465498, --[[ModItemStoryBit Robot_Fake_Settlement Title]] "[The Nests Awaken] Consortium Mining Site"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Text = T(699209724742, --[[ModItemStoryBit Robot_Fake_Settlement Text]] "Ask to trade your sheep for their wood, you need to build a road"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_consortium",
				}),
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 150000,
					Resource = "Wood",
					param_bindings = false,
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
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
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/temporary.png",
		Text = T(515394180803, --[[ModItemStoryBit ConstortiumDeceived Text]] 'A large airship flies above your base. \nAfter stabilizing, it announces:\n\n"WE HAVE FINALLY LOCATED YOU, THE DECEIVERS!\nWE WILL NOW COMMENCE OUR REVENGE FOR THE FINANCIAL PENALTIES WE SUFFERED BECAUSE OF OUR FALSIFIED MINING RIGHTS!"\n\n<style TextNegative>Local Consortium Nest aggression levels increased 5x.\nThe Consortium will also send an attack.</style>'),
		Title = T(888103019740, --[[ModItemStoryBit ConstortiumDeceived Title]] "Consortium Deception Discovered"),
		id = "ConstortiumDeceived",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemTech', {
		Description = T(498459637401, --[[ModItemTech NA_consort_power_efficiency Description]] "An expedition to a Consortium mining base has revealed a secret frequency that the Consortium is beaming power through!\n\nLet's hack into this signal, and learn how to harness it for our own purposes!\n\n<em>All buildings consume 25% less power</em>"),
		DisplayName = T(756256372571, --[[ModItemTech NA_consort_power_efficiency DisplayName]] "Consortium Power Beaming"),
		LockState = "hidden",
		StartingBreakthrough = false,
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
PlaceObj('ModItemFolder', {
	'name', "Repurposed Content: Shrieker",
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
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		comment = "Overriding of base\nNote to self: SpawnNestInsideMap takes the prefab tag, not nest class or species name",
		id = "ShriekerNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ShriekerNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_shriekers')
				end,
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
		Sets = set( "Negative" ),
		Text = T(480862517656, --[[ModItemStoryBit new_nest_shrieker Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(744697671524, --[[ModItemStoryBit new_nest_shrieker Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_shrieker",
		max_reply_id = 2,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			shrieker_fall = true,
		},
		id = "nesting_shriekers",
		nest_class = "ShriekerNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "RawMeatInsect",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "CarbonNanotubes",
				'amount', 100000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "NewShriekerNest",
		spore_buildings = "ShriekerSporeDeposit",
		unit_species = "species_shrieker",
	}),
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
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Delay = 4000,
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
			Text = T(329248656624, --[[ModItemStoryBit Broken_Shrieker_Nest Text]] "I tried to damage the pillars with what I had...\nBut these pillars are made of stern stuff!\n\nWorse still, the pillars are now vibrating so loud it is starting to hurt.\nI'm getting out of here before I start to go deaf!\n<em>Local Shrieker Nest aggression levels raised 3x.</em>"),
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_T4",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_T3",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/ShriekerHorns.jpg",
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
		Category = "Exploration",
		Delay = 4000,
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
				PlaceObj('ModifySkill', {
					Id = "autoid_TGkJ3Tu_i5rxdkF",
					Level = 1,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "",
					Level = 1,
					Skill = "Construction",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "",
					Level = 1,
					Skill = "Cooking",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "",
					Level = 1,
					Skill = "Crafting",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "",
					Level = 1,
					Skill = "Farming",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "",
					Level = 1,
					Skill = "Healing",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "autoid_TGkJ3Tu_meWXpmh",
					Level = 1,
					Skill = "Intellectual",
					param_bindings = false,
				}),
				PlaceObj('ModifySkill', {
					Id = "autoid_TGkJ3Tu_S7m6CE5",
					Level = 1,
					Skill = "Physical",
					param_bindings = false,
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
				nil,
				nil,
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_T4",
					param_bindings = false,
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_shriekers",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/pileoffood.jpg",
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
		Category = "Exploration",
		Delay = 4000,
		Enabled = true,
		FxAction = "UINotificationExpedition",
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				nil,
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_T4",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				nil,
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_T4",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
				PlaceObj('ModifySkill', {
					Id = "autoid_TGkJ3Tu_d3MaSv",
					Level = 2,
					Skill = "Healing",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_shriekers",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Insect_War.jpg",
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
		Icon = "Mod/TGkJ3Tu/PicsOritDidntHappen/BurntFood.jpg",
		LockState = "hidden",
		MinSkillLevel = 5,
		ResearchPoints = 10000,
		StartingBreakthrough = false,
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
	}),
PlaceObj('ModItemFolder', {
	'name', "Repurposed Content: Scissorhands",
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
			return SpawnNestInsideMap(target,nil,"ScissorhandsNest")
		end,
		SpawnTimeLimit = false,
		SurvivorDistMin = 250000,
		TargetClass = "FallingDebrisMarker",
		TargetFilter = function (obj) return 0 == MapCount(obj, obj.MaxPrefabRadius, "ScavengeableDebris", "FallingDebris", "Building", "Human", "TerritorialNest") end,
		group = "StoryBits",
		id = "ScissorhandNest",
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Tick",
		Effects = {
			PlaceObj('ActivateSpawnDef', {
				SpawnDefId = "ScissorhandNest",
				param_bindings = false,
			}),
			PlaceObj('ExecuteCode', {
				Code = function (self, obj)
					mark_spawned_nest('nesting_scissorhands')
				end,
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
		Sets = set( "Negative" ),
		Text = T(150518945986, --[[ModItemStoryBit new_nest_scissorhand Text]] "There is a meteor on course to land close to us.\nOur calculations note that it is too small to cause more than a small earthquake, so thank goodness for that!\n\nWe can't make out what it is composed of...\nBut it must have some rare minerals inside of it!"),
		Title = T(206941887720, --[[ModItemStoryBit new_nest_scissorhand Title]] "A meteor is landing nearby"),
		group = "Default",
		id = "new_nest_scissorhand",
		max_reply_id = 3,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Lina on 2020-Oct-26\nModified by Lina on 2021-Jan-12\nModified by Ivan on 2021-Feb-05\nModified by Ivan on 2021-Feb-24\nModified by Gaby on 2021-Mar-02\nModified by Ivan on 2021-Mar-02\nModified by Ivan on 2021-Mar-22\nModified by Gaby on 2021-Mar-25\nModified by Bobby on 2021-Aug-02\nModified by Ivan on 2021-Sep-20\nModified by Ivan on 2021-Nov-04\nModified by Xaerial on 2022-Sep-05\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/TGkJ3Tu",
	}),
	PlaceObj('ModItemNestingSpeciesPreset', {
		PrefabTags = {
			scissorhands_nest = true,
		},
		id = "nesting_scissorhands",
		nest_class = "ScissorhandsNest",
		resource_list = {
			PlaceObj('ResAmount', {
				'resource', "Ore",
				'amount', 100000,
			}),
			PlaceObj('ResAmount', {
				'resource', "RawMeat",
				'amount', 100000,
			}),
		},
		save_in = "Mod/TGkJ3Tu",
		spawner_storybit = "new_nest_scissorhand",
		spore_buildings = "ScissorhandSporeDeposit",
		unit_species = "species_scissorhand",
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
		'Id', "scissor_prefab_type",
		'OnObjOverlap', 3,
		'Tags', set( "scissorhands_nest" ),
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
						Tech = "FieldScissorhands",
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
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Sage_Nest_.PNG",
		NotificationText = T(516957375298, --[[ModItemStoryBit Single_Occupant_Scissor_Nest NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		SelectObject = false,
		Text = T(452416333956, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Text]] "We tracked the earthquake to the largest Shrieker Nest I have ever seen!\n\nMy nose was met with the stench of death.\nThe only living creature is a lone 10 ft tall Scissorhands, surrounded by dead Scissorhands.\nIt's shell is marred with.... slashes?!?\n\nWhat should I do?"),
		Title = T(110135522538, --[[ModItemStoryBit Single_Occupant_Scissor_Nest Title]] "[The Nests Awaken] A Betrayer"),
		group = "Expedition_FollowUP",
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
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 50000,
					Resource = "Silicon",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Sage_Nest_.PNG",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Sage_Nest_.PNG",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_T5",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionChange', {
					new_aggressive = true,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionChange', {
					new_aggressive = true,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Sage_Nest_.PNG",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Sage_Nest_.PNG",
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
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
		NotificationText = T(266833903346, --[[ModItemStoryBit Scissorhand_Mating_event NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		SelectObject = false,
		Text = T(828743778286, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I floated over the disturbance.\nIt a Scissorhand mega-colony!\n\nAs I continued to watch, each Scissorhand would stand in the center and dance. Sometimes turning to face another Scissorhand, or always look towards one.\n\nSometimes after one finishes dancing, it will pair off.\nThis must be the mating dance and possibly even ritual they do!\n\nWhat should I do?"),
		Title = T(526098361340, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
		group = "Expedition_FollowUP",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
			Text = T(555886404386, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I watched with attention as each Scissorhands came to the center, and tried my best to sketch the different forms that they paused on.\n\nMy art skills meant it was a bunch of stick people with extra arms didn't help, but I think I have what I need.\n\nIf we have nearby Scissorhands (Or are attacked by them), I think I will better chance of taming them with the help of these!\n\n<em>This colonist now has a trait giving them greater efficiency when taming Scissorhands</em>"),
			Title = T(543906784848, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Mating Dance Discovered"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Comment = "Readd granting of All Scissorhands now have -20% Max HP.",
			Text = T(161042252208, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "Start a fire and destroy the site!"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
			Text = T(714448102929, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I collected some kindling nearby, and then lined up dry wood to burn towards the site.\n\nThe fire quickly spread and engulfed everything!\n\nI must have left some sort of trail, because I've spotted Scissorhands behind my trail back home!\n\n<em>Local Scissorhand Nest aggression levels raised.</em>"),
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_T4",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Mating.PNG",
			Text = T(986784585722, --[[ModItemStoryBit Scissorhand_Mating_event Text]] "I waited until the festivities died down and most of the Scissorhands where resting.\nThankfully the noise of the nest did not lower, so I could be a little more aggressive breaking down some of the larger pieces of nest that had fallen off.\n\nAfter filling my bags full multiple times, I am leaving feeling pretty pleased with myself!\n\n<em>Large trove of Silicon Gained</em>"),
			Title = T(391981441246, --[[ModItemStoryBit Scissorhand_Mating_event Title]] "[The Nests Awaken] Scissorhand Mating Site"),
			Weight = 10,
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Amush.PNG",
		NotificationText = T(331213279531, --[[ModItemStoryBit Weak_scissor_hunting_pack NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		Text = T(728012514068, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "I spotted a pack of weak Scissorhands laying in wait near a mountain tunnel.\nAll other Scissorhands most likely cannot ambush hunt due to evolution warping their carapace into vibrant colors.\n\nThey are perfectly still, and look relatively underfed.\nThey would be easy marks for a well equipped colonist, or respond well to food.\n\nHow to proceed?"),
		Title = T(189024014004, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
		group = "Expedition_FollowUP",
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
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Amush.PNG",
			Text = T(721113194455, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "It was quite easy to deal with them.\nI landed, then threw rocks to distract each one individually.\nThen repeat, repeat, repeat.\n\nUsually the buggers know where we are, and we can't really hide.\nBut in this case I had to use more stealth than I'm used too.\nAnd I think that has gotten me better at fighting in general!\n\n<em>Colonists Combat Skill increased by 2.\nLocal Scissorhands Nest aggression levels raised.</em>"),
			Title = T(807015172525, --[[ModItemStoryBit Weak_scissor_hunting_pack Title]] "[The Nests Awaken] Scissorhand Ambush Site"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			Comment = "Need to re-add giving all Scissorhands now have 20% higher Max HP.",
			Text = T(122220266452, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Scare some nearby Draka through the tunnel"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('NestingSpeciesAggressionEvent', {
					aggression_up = false,
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Amush.PNG",
			Text = T(562560472062, --[[ModItemStoryBit Weak_scissor_hunting_pack Text]] "Once in position, all the scared Drakas immediately sprinted towards the tunnel.\nWhich looked safer than a new creature that's making scary noises!\n\nI lost count of how many I sent to their fate, because this was the best fun I've had in a long time!\n\nOn my way back I did noticed a MUCH larger group moving their kills... \nI wonder what that's about?\n\n<em>Local Scissorhands Nest aggression levels lowered.</em>"),
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
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Amush.PNG",
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
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_T4",
					param_bindings = false,
				}),
				PlaceObj('NestingSpeciesAggressionEvent', {
					param_bindings = false,
					species = "nesting_scissorhands",
				}),
			},
			Image = "Mod/TGkJ3Tu/PicsOritDidntHappen/Scissor_Amush.PNG",
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
		StartingBreakthrough = false,
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
PlaceObj('ModItemTrait', {
	Description = T(978016247668, --[[ModItemTrait NA_balloon_ejected_1 Description]] "Was stranded on an expedition and had to survive in the wilderness, on a horse with no name.<newline>But after 9 days, they let the horse run free.... Wait there are horses?!?!?<newline>Granted +1 farming skill, interested in farming."),
	DisplayName = T(380286860366, --[[ModItemTrait NA_balloon_ejected_1 DisplayName |gender-variants]] "On a horse with no name"),
	Modifiers = {
		PlaceObj('ModifySkill', {
			Id = "autoid_TGkJ3Tu_PHmJyCv",
			Inclination = "Interested",
			Level = 1,
			Skill = "Farming",
		}),
		PlaceObj('ModifyUnitActivity', {
			Action = "allow",
			Activity = "Ranching",
			FilterBy = "Farming",
			Id = "autoid_TGkJ3Tu_Q5TWWfe",
			Reason = "Survived with help of horse to get back to base",
		}),
		PlaceObj('ModifyUnitActivity', {
			Action = "allow",
			Activity = "TrainAnimal",
			FilterBy = "Farming",
			Id = "",
			Reason = "Survived with help of horse to get back to base",
		}),
	},
	id = "NA_balloon_ejected_1",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemTrait', {
	id = "NA_balloon_ejected_2",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemTrait', {
	id = "NA_balloon_ejected_3",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemTrait', {
	Description = T(453061281043, --[[ModItemTrait NA_balloon_ejected_4 Description]] "Was left stranded and far away from the base, and bonded with an animal pair on a journey worthy of a Major Blockbuster Movie. Alas, the only ones who will hear this tale are us...<newline>Granted a tame-able animal, and a bond with it."),
	DisplayName = T(118054580707, --[[ModItemTrait NA_balloon_ejected_4 DisplayName |gender-variants]] "Trauma Bonded"),
	OnAddTrait = function (self, unit)
		unit:TraumaBond()
	end,
	id = "NA_balloon_ejected_4",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemStoryBit', {
	NotificationTitle = T(814693783701, --[[ModItemStoryBit NA_ExpeditionStranded NotificationTitle]] "A stranded expedition colonist has returned!"),
	Text = T(377731686815, --[[ModItemStoryBit NA_ExpeditionStranded Text]] "I... managed.... to make it back....\nI'm still far away from where I lay my head normally, but you can finally hear me!\nPlease help me make it the rest of the way, who knows what creatures are nearby and on red alert from my \n\n<em>This colonist is now back on the game map and are controllable again.\nThey now have a trait to commemorate their adventure... misadventure?</em>\n<c"),
	Title = T(694245894653, --[[ModItemStoryBit NA_ExpeditionStranded Title]] "A lost colonist has managed to return safely"),
	UseObjectImage = true,
	id = "NA_ExpeditionStranded",
	save_in = "Mod/TGkJ3Tu",
}),
PlaceObj('ModItemTech', {
	Description = T(334510904470, --[[ModItemTech Deathfly_balloon_speed Description]] "People are using the hot air balloons inefficiently. Let's sketch up instructions how the fuel burner should be used and stick them in each balloon. With proper instructions people will use half of the currently required fuel.\n\n<style TechSubtitleBlue>Unlocks</style>\n<tabulator><em>Halves the fuel consumed by Hot air balloons during expeditions</em>"),
	DisplayName = T(656724038380, --[[ModItemTech Deathfly_balloon_speed DisplayName]] "Balloon optimization"),
	Icon = "UI/Icons/Research/hot_air_balloon_optimization",
	LockPrerequisites = {
		PlaceObj('CheckTech', {
			Tech = "LongDistanceTravel",
		}),
	},
	LockState = "hidden",
	OnTechResearched = function (self, player)
		for _, balloon in ipairs(player.labels.HotairBalloon) do
			balloon:DropExcessFuel()
			ObjModified(balloon)
		end
	end,
	ResearchPoints = 144000,
	SortKey = 204,
	TradePrerequisites = {
		PlaceObj('CheckTech', {
			Tech = "LongDistanceTravel",
		}),
	},
	id = "Deathfly_balloon_speed",
	money_value = 250000000,
	save_in = "Mod/TGkJ3Tu",
	PlaceObj('AttachEffectsToBuildings', {
		Effects = {
			PlaceObj('ModifyObject', {
				Id = "HotairBalloonOptimization",
				ModProperty = "fuel_amount",
				Mul = 500,
				ObjectClass = "HotairBalloon",
			}),
		},
		Id = "HotairBalloonOptimization",
		Label = "HotairBalloon",
	}),
}),
}
