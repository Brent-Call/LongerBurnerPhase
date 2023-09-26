require( "util" )

--The name of the top-level LuaGuiElement for the scoring GUI:
SCORING_GUI_TOP_LEVEL_NAME = "MilitarySupply:scoring"
STARTER_PACKAGE_GUI_TOP_LEVEL_NAME = "MilitarySupply:starter-package"
SHOP_GUI_TOP_LEVEL_NAME = "MilitarySupply:shop"
CLOSE_BUTTON_FOR_SCORING_GUI = "totally-unique-string-{a9b462b5-836e-4d5e-ae5a-37bdf046450a}"
CLOSE_BUTTON_FOR_STARTER_PACKAGE_GUI = "totally-unique-string-{5fda0d85-2c0b-4aaa-aaf2-0aebca71c47a}"
CLOSE_BUTTON_FOR_SHOP_GUI = "totally-unique-string-{5f9e3bc6-d1f7-43df-907b-04e35b941bb5}"
BUTTON_TO_OPEN_STARTER_PACKAGE_GUI = "totally-unique-string-{a2cbb4d2-e432-4b0e-97ee-08b6c061e6fd}"
BUTTON_TO_SELECT_STARTER_PACKAGE = "totally-unique-string-{92b44beb-c1c9-4a35-9406-1499bf4a235d}"
BUTTON_TO_DESELECT_STARTER_PACKAGE = "totally-unique-string-{b52bdf0b-161e-4edd-ac41-734cba2e519d}"
BUTTON_TO_CONFIRM_STARTER_PACKAGE = "totally-unique-string-{2fb84d06-9dd0-4602-a25f-6b61cc533bc3}"
BUTTON_TO_TOGGLE_GOALS_GUI = "totally-unique-string-{9ded18ac-e28d-497d-9f92-8994bff5a7f7}"
BUTTON_TO_TOGGLE_SHOP_GUI = "totally-unique-string-{2182c4e3-b829-49f2-ad61-fcfd3a37d157}"
BUTTON_TO_TOGGLE_SCORE_GUI = "totally-unique-string-{18489e7a-57f1-44ec-8869-5d9fac2905d2}"

--Initializes the main GUI for the MilitarySupply scenario.
--Call this only once per player.
--@param player	The LuaPlayer to act on.
function create_main_GUI( player )
	local msGUI = player.gui.left.add({ type = "frame", name = "MilitarySupply:main", direction = "vertical", caption = { "military-supply-scenario-gui.title1" }, style = "non_draggable_frame" })
	msGUI.style.maximal_width = 480
	msGUI.add({ type = "frame", name = "inner", direction = "vertical", style = "Q-LongerBurnerPhase:inside_shallow_frame_with_padding_and_spacing" })
	msGUI.inner.add({ type = "label", name = "info-goes-here", caption = { "military-supply-scenario-gui.description1" }})
	msGUI.inner[ "info-goes-here" ].style.single_line = false
end

--Sets up the main GUI to instruct the player to choose a starter package.
--@param player	The LuaPlayer to act on.
function update_main_GUI_for_starter_bonus( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	msGUI.caption = { "military-supply-scenario-gui.title2" }
	local inner = msGUI.inner
	inner[ "info-goes-here" ].caption = { "military-supply-scenario-gui.description2" } 
	inner.add({ type = "button", name = BUTTON_TO_OPEN_STARTER_PACKAGE_GUI, caption = { "military-supply-scenario-gui.choose-starter-package" }})
end

--Sets up the main GUI to show the objective & buttons to show/hide the goals & the shop.
--@param player	The LuaPlayer to act on.
function update_main_GUI_for_scenario( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	msGUI.caption = { "gui-goal-description.title" }
	local inner = msGUI.inner
	inner[ "info-goes-here" ].caption = { "military-supply-scenario-gui.main-objective" }

	--Add 3 buttons to the player's GUI, allowing them to see the goals table, the shop, & the score:
	local buttons = inner.add({ type = "flow", name = "button-flow", direction = "horizontal" })
	buttons.add({ type = "button", name = BUTTON_TO_TOGGLE_GOALS_GUI, caption = { "military-supply-scenario-gui.show-goals-button" }})
	buttons.add({ type = "button", name = BUTTON_TO_TOGGLE_SHOP_GUI, caption = { "military-supply-scenario-gui.show-shop-button" }})
	buttons.add({ type = "button", name = BUTTON_TO_TOGGLE_SCORE_GUI, caption = { "military-supply-scenario-gui.show-score-button" }})

	local tracker = msGUI.add({ type = "frame", name = "tracker", direction = "vertical", style = "Q-LongerBurnerPhase:inside_shallow_frame_with_padding_and_spacing" })
	tracker.add({ type = "flow", name = "timer", direction = "horizontal" })
	tracker.timer.add({ type = "label", name = "timer-title", caption = { "military-supply-scenario-gui.time-remaining-title" }, style = "description_title_label" })
	tracker.timer.add({ type = "label", name = "timer-value", caption = { "military-supply-scenario-gui.time-remaining-value", get_time_left_of_scenario_object( global.militarySupplyScenario )}, style = "description_value_label" })
	local numDeaths = global.militarySupplyScenario.playerDeaths
	tracker.add({ type = "label", name = "deaths-info", caption = { "military-supply-scenario-gui.deaths-info" }, style = "info_label", visible = numDeaths > 0 })
	tracker.add({ type = "flow", name = "deaths", direction = "horizontal", visible = numDeaths > 0 })
	tracker.deaths.add({ type = "label", name = "deaths-counter-title", caption = { "military-supply-scenario-gui.deaths-counter-title" }, style = "description_title_label" })
	tracker.deaths.add({ type = "label", name = "deaths-counter-value", caption = numDeaths, style = "description_value_label" })

	--Create the Goals GUI, which will be invisible.
	local goal = msGUI.add({ type = "frame", name = "goal", direction = "vertical", style = "Q-LongerBurnerPhase:inside_shallow_frame_with_padding_and_spacing", visible = false })
	local numGoalsCompleted = global.goalManager.goalsCompleted
	local moneyMulti = global.militarySupplyScenario.moneyMultiplier
	local noGoalsLeft = get_goal_count_of_goals_manager( global.goalManager ) == 0
	goal.add({ type = "flow", name = "goals-counter", direction = "horizontal", visible = numGoalsCompleted > 0 })
	goal[ "goals-counter" ].add({ type = "label", name = "goals-counter-title", caption = { "military-supply-scenario-gui.goals-counter-title" }, style = "description_title_label" })
	goal[ "goals-counter" ].add({ type = "label", name = "goals-counter-value", caption = numGoalsCompleted, style = "description_value_label" })
	goal.add({ type = "flow", name = "rewards-multiplier", direction = "horizontal", visible = moneyMulti ~= 1 })
	goal[ "rewards-multiplier" ].add({ type = "label", name = "rewards-multiplier-title", caption = { "military-supply-scenario-gui.rewards-multiplier-title" }, style = "description_title_label" })
	goal[ "rewards-multiplier" ].add({ type = "label", name = "rewards-multiplier-value", caption = { "military-supply-scenario-gui.rewards-multiplier-value", moneyMulti }, style = "description_value_label" })
	--Create a table of goals & set the column headers:
	local tableColumns = 3
	if moneyMulti ~= 1 then
		tableColumns = 4
	end
	local goalsTable = goal.add({ type = "table", name = "goals-table", column_count = tableColumns, draw_horizontal_lines = true, visible = not noGoalsLeft })
	goalsTable.style.horizontal_spacing = 8
	goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-item-name" }, style = "heading_3_label" })
	goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-item-quantity" }, style = "heading_3_label" })
	if tableColumns == 4 then
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-base" }, style = "heading_3_label" })
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-final" }, style = "heading_3_label" })
	else
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-simple" }, style = "heading_3_label" })
	end
	--Add all goals to the table:
	add_goals_to_table_of_goals_manager( global.goalManager, goalsTable )
	goal.add({ type = "label", name = "no-goals-left", caption = { "military-supply-scenario-gui.no-goals-left" }, visible = noGoalsLeft })
end

--This function only updates the clock.  That's all it does.
--@param player	The LuaPlayer whose GUI to update.
function update_scenario_timer( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if msGUI and msGUI.tracker then
		msGUI.tracker.timer[ "timer-value" ].caption = { "military-supply-scenario-gui.time-remaining-value", get_time_left_of_scenario_object( global.militarySupplyScenario )}
	end
end

--This function updates the counter that displays player deaths.
--@param player	The LuaPlayer whose GUI to update.
function update_scenario_deaths( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if msGUI and msGUI.tracker then
		local numDeaths = global.militarySupplyScenario.playerDeaths
		msGUI.tracker[ "deaths-info" ].visible = numDeaths > 0
		msGUI.tracker.deaths.visible = numDeaths > 0
		msGUI.tracker.deaths[ "deaths-counter-value" ].caption = numDeaths
	end
end

--Sets up the main GUI to display the final objective--completing this will count as a scenario win.
--@param player	The LuaPlayer to act on.
function update_main_GUI_for_final_objective( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	msGUI.caption = { "gui-goal-description.title" }
	local inner = msGUI.inner
	inner[ "info-goes-here" ].caption = { "military-supply-scenario-gui.final-objective" }
end

--Checks whether the player currently has their goals GUI open or not.
--@param player	The LuaPlayer to act on.
--@return			boolean true or false
function get_is_goals_GUI_open( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if not msGUI then
		--Main GUI doesn't exist.  That's really weird.
		return false
	end
	if msGUI.goal then
		--Goals GUI exists.  It's considered "open" if it's visible.
		return msGUI.goal.visible
	end
	--Else, goals GUI doesn't exist.
	return false
end

--Sets the Goals GUI to be visible.  If the GUI hasn't previously been created, does nothing instead.
--@param player	The LuaPlayer whose GUI to act on.
function show_goals_GUI( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if not msGUI then
		--Main GUI doesn't exist.  That's really weird.
		return
	end
	if msGUI.goal then
		msGUI.goal.visible = true
		msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_GOALS_GUI ].caption = { "military-supply-scenario-gui.hide-goals-button" }
	end
end

--This function updates everything in the goals GUI.
--If for some reason the goals GUI doesn't exist yet, does nothing instead.
--@param player	The LuaPlayer to act on.
function update_goals_GUI( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if not msGUI then
		--Main GUI doesn't exist.  That's really weird.
		return
	end
	local goal = msGUI.goal
	if not goal then
		return
	end
	--Else, the Goals GUI exists, so update it!
	local numGoalsCompleted = global.goalManager.goalsCompleted
	local moneyMulti = global.militarySupplyScenario.moneyMultiplier
	local noGoalsLeft = get_goal_count_of_goals_manager( global.goalManager ) == 0
	goal[ "goals-counter" ].visible = numGoalsCompleted > 0
	goal[ "goals-counter" ][ "goals-counter-value" ].caption = numGoalsCompleted
	goal[ "rewards-multiplier" ].visible = moneyMulti ~= 1
	goal[ "rewards-multiplier" ][ "rewards-multiplier-value" ].caption = { "military-supply-scenario-gui.rewards-multiplier-value", moneyMulti }
	--Clear the table of goals & reset the column headers.
	goal[ "goals-table" ].destroy()
	local tableColumns = 3
	if moneyMulti ~= 1 then
		tableColumns = 4
	end
	local goalsTable = goal.add({ type = "table", name = "goals-table", column_count = tableColumns, draw_horizontal_lines = true, visible = not noGoalsLeft })
	goalsTable.style.horizontal_spacing = 8
	goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-item-name" }, style = "heading_3_label" })
	goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-item-quantity" }, style = "heading_3_label" })
	if tableColumns == 4 then
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-base" }, style = "heading_3_label" })
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-final" }, style = "heading_3_label" })
	else
		goalsTable.add({ type = "label", caption = { "military-supply-scenario-gui.goals-table-header-reward-simple" }, style = "heading_3_label" })
	end
	--Add all goals to the table:
	add_goals_to_table_of_goals_manager( global.goalManager, goalsTable )
	
	--Set visibility of goals table versus "no goals left" message.
	goal[ "goals-table" ].visible = not noGoalsLeft
	goal[ "no-goals-left" ].visible = noGoalsLeft
end

--Hides the goals GUI, but doesn't destroy it entirely.
--@param player	The LuaPlayer to act on.
function hide_goals_GUI( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if not msGUI then
		--Main GUI doesn't exist.  That's really weird.
		return
	end
	local goal = msGUI.goal
	if goal then
		goal.visible = false
		msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_GOALS_GUI ].caption = { "military-supply-scenario-gui.show-goals-button" }
		return
	end
end

function fill_shop_GUI_table( upgradesTable )
	--Add the available upgrades to the list:
	for name, upgrade in pairs( global.militarySupplyScenario.upgrades ) do
		if not upgrade.purchased then
			--The cost is displayed in green if the player CAN afford it, & red if the player CANNOT afford it:
			if global.militarySupplyScenario.money >= upgrade.cost then
				upgradesTable.add({ type = "sprite-button", name = "upgrades-button"..name, sprite = upgrade.icon, tooltip = { "military-supply-scenario-shop-GUI.tooltip-can-afford" }})
				upgradesTable.add({ type = "label", name = name.."-b", caption = upgrade.description }).style.single_line = false
				upgradesTable.add({ type = "label", name = name.."-c", style = "bold_green_label", caption = { "military-supply-scenario-shop-GUI.item-cost", upgrade.cost }})
			else				
				upgradesTable.add({ type = "sprite-button", name = "upgrades-button"..name, sprite = upgrade.icon, tooltip = { "military-supply-scenario-shop-GUI.tooltip-cannot-afford" }})
				upgradesTable.add({ type = "label", name = name.."-b", caption = upgrade.description }).style.single_line = false
				upgradesTable.add({ type = "label", name = name.."-c", style = "bold_red_label", caption = { "military-supply-scenario-shop-GUI.item-cost", upgrade.cost }})
			end
		end
	end
end

--Checks whether the Shop GUI is open or not.
--@param player	The LuaPlayer to act on.
--@return			Boolean value.
function get_is_shop_GUI_open( player )
	local shopGUI = player.gui.screen[ SHOP_GUI_TOP_LEVEL_NAME ]
	if shopGUI then
		return shopGUI.visible
	end
	--Else, the Shop GUI hasn't been created.
	return false
end

--Creates the shop GUI if it hasn't been created yet, or shows it if it was hidden.
--@param player	The LuaPlayer to act on.
function show_shop_GUI( player )
	--Set the button to say "hide shop"
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	if msGUI then
		msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_SHOP_GUI ].caption = { "military-supply-scenario-gui.hide-shop-button" }
	end

	local shopGUI = player.gui.screen[ SHOP_GUI_TOP_LEVEL_NAME ]
	if shopGUI then
		shopGUI.visible = true
		player.opened = shopGUI
		shopGUI.force_auto_center()
		return
	end
	--Else, the shop GUI doesn't exist yet, so create it.
	shopGUI = player.gui.screen.add({ type = "frame", name = SHOP_GUI_TOP_LEVEL_NAME, direction = "vertical" })
	player.opened = shopGUI
	shopGUI.force_auto_center()

	local titlebar = shopGUI.add({ type = "flow", name = "shop-titlebar", direction = "horizontal" })
	titlebar.drag_target = shopGUI
	titlebar.add({ type = "label", name = "shop-titlebar-title", caption = { "military-supply-scenario-shop-GUI.money", global.militarySupplyScenario.money }, ignored_by_interaction = true, style = "frame_title" })
	titlebar.add({ type = "empty-widget", name = "shop-titlebar-draggable", ignored_by_interaction = true, style = "Q-LongerBurnerPhase:titlebar_draggable_space" })
	titlebar.add({ type = "sprite-button", name = CLOSE_BUTTON_FOR_SHOP_GUI, sprite = "utility/close_white", hovered_sprite = "utility/close_black", clicked_sprite = "utility/close_black", style = "close_button" })

	local inner = shopGUI.add({ type = "frame", name = "inner", direction = "vertical", style = "Q-LongerBurnerPhase:inside_shallow_frame_with_padding_and_spacing" })
	inner.add({ type = "flow", name = "counter", direction = "horizontal" })
	inner.counter.add({ type = "label", name = "upgrades-counter-title", caption = { "military-supply-scenario-shop-GUI.upgrades-purchased-title" }, style = "description_title_label" })
	inner.counter.add({ type = "label", name = "upgrades-counter-value", caption = global.militarySupplyScenario.purchasedUpgrades, style = "description_value_label" })
	
	local noUpgrades = global.militarySupplyScenario.availableUpgrades == 0
	inner.add({ type = "frame", name = "deep", direction = "vertical", style = "deep_frame_in_shallow_frame", visible = not noUpgrades })
	local shopTable = inner.deep.add({ type = "table", name = "available-upgrades-table", column_count = 3, draw_horizontal_lines = true, style = "Q-LongerBurnerPhase:shop-gui-table" })
	fill_shop_GUI_table( shopTable )
	inner.add({ type = "label", name = "no-more-upgrades", caption = { "military-supply-scenario-shop-GUI.no-upgrades-left" }, visible = noUpgrades })
end

--Updates everything in the shop GUI.
--@param player	The LuaPlayer whose GUI to update.
function update_shop_GUI( player )
	local shopGUI = player.gui.screen[ SHOP_GUI_TOP_LEVEL_NAME ]
	if not shopGUI then
		return
	end
	--Else, shopGUI is valid.
	shopGUI[ "shop-titlebar" ][ "shop-titlebar-title" ].caption = { "military-supply-scenario-shop-GUI.money", global.militarySupplyScenario.money }
	local inner = shopGUI.inner
	inner.counter[ "upgrades-counter-value" ].caption = global.militarySupplyScenario.purchasedUpgrades
	local noUpgrades = global.militarySupplyScenario.availableUpgrades == 0
	inner.deep.visible = not noUpgrades
	local shopTable = inner.deep[ "available-upgrades-table" ]
	shopTable.clear()
	fill_shop_GUI_table( shopTable )
	inner[ "no-more-upgrades" ].visible = noUpgrades
end

--@param player	The LuaPlayer to act on.
function hide_shop_GUI( player )
	local shopGUI = player.gui.screen[ SHOP_GUI_TOP_LEVEL_NAME ]
	if shopGUI then
		shopGUI.visible = false
		if player.opened == shopGUI then
			player.opened = nil
		end
	end
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_SHOP_GUI ].caption = { "military-supply-scenario-gui.show-shop-button" }
end

--Gets the LocalisedString to be used as the title for the scoring GUI.
--@return	A LocalisedString object with data from the most recent tick update.
function get_caption_for_scoring_GUI()
	return { "military-supply-scenario-score.current-score", string.format( "%.3f", global.scoreManager.finalScore )}
end

--Returns true if the scoring GUI is visible onscreen.
--@param player	The LuaPlayer who may or may not have the scoring GUI open.
--@return			true if the scoring GUI has been created & is visible,
--				false if it either hasn't been created or if it is hidden
function get_is_score_GUI_open( player )
	local scoringGUI = player.gui.screen[ SCORING_GUI_TOP_LEVEL_NAME ]
	if scoringGUI then
		--The scoring GUI has been created, but it might be hidden, so test for that:
		return scoringGUI.visible
	end
	--Else, the scoring GUI has not been created, meaning it's closed.
	return false
end

--Shows the scoring GUI.  Creates it if it didn't exist before.
--@param player	The LuaPlayer to act on.
function show_score_GUI( player )
	local msGUI = player.gui.left[ "MilitarySupply:main" ]
	msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_SCORE_GUI ].caption = { "military-supply-scenario-gui.hide-score-button" }
	local score = player.gui.screen[ SCORING_GUI_TOP_LEVEL_NAME ]
	if score then
		--The scoring GUI has already been created, so just show it & move it to the center of the screen:
		score.visible = true
		player.opened = score
		score.force_auto_center()
		return
	end
	--Else, this is the first time we've seen the score GUI, so we need to create all the GUI elements.
	--First, calculate the score:
	calculate_score_manager_object( global.scoreManager )
	
	score = player.gui.screen.add({ type = "frame", name = SCORING_GUI_TOP_LEVEL_NAME, direction = "vertical" })
	player.opened = score
	score.force_auto_center()

	local titlebar = score.add({ type = "flow", name = "scoring-titlebar", direction = "horizontal" })
	titlebar.drag_target = score
	titlebar.add({ type = "label", name = "scoring-titlebar-title", caption = get_caption_for_scoring_GUI(), ignored_by_interaction = true, style = "frame_title" })
	titlebar.add({ type = "empty-widget", name = "scoring-titlebar-draggable", ignored_by_interaction = true, style = "Q-LongerBurnerPhase:titlebar_draggable_space" })
	titlebar.add({ type = "sprite-button", name = CLOSE_BUTTON_FOR_SCORING_GUI, sprite = "utility/close_white", hovered_sprite = "utility/close_black", clicked_sprite = "utility/close_black", style = "close_button" })
	
	score.add({ type = "label", name = "description", caption = { "military-supply-scenario-score.description" }, style = "info_label" })

	local breakdown = score.add({ type = "flow", name = "breakdown", direction = "horizontal", style = "Q-LongerBurnerPhase:score_gui_centering_flow" })
	breakdown.add({ type = "frame", name = "subscores", direction = "vertical", style = "Q-LongerBurnerPhase:score_gui_compact_inside_frame" })
	breakdown.subscores.add({ type = "label", name = "points-from-goals", caption = { "military-supply-scenario-score.pfg", global.scoreManager.pointsFromGoals }, tooltip = { "military-supply-scenario-score.pfg-tooltip" }})
	breakdown.subscores.add({ type = "label", name = "points-from-time", caption = { "military-supply-scenario-score.pft", string.format( "%.1f", global.scoreManager.pointsFromTime )}, tooltip = { "military-supply-scenario-score.pft-tooltip" }})
	breakdown.subscores.add({ type = "label", name = "points-from-upgrades", caption = { "military-supply-scenario-score.pfu", string.format( "%.3f", global.scoreManager.pointsFromUpgrades )}, tooltip = { "military-supply-scenario-score.pfu-tooltip" }})
	breakdown.add({ type = "frame", name = "multis", direction = "vertical", style = "Q-LongerBurnerPhase:score_gui_compact_inside_frame" })
	breakdown.multis.add({ type = "label", name = "raw-total", caption = { "military-supply-scenario-score.rt", string.format( "%.3f", global.scoreManager.rawTotal )}, tooltip = { "military-supply-scenario-score.rt-tooltip" }})
	breakdown.multis.add({ type = "label", name = "divisor-from-deaths", caption = { "military-supply-scenario-score.dfd", global.scoreManager.divisorFromDeaths }, tooltip = { "military-supply-scenario-score.dfd-tooltip", global.militarySupplyScenario.playerDeaths }})
	breakdown.multis.add({ type = "label", name = "score-multiplier", caption = { "military-supply-scenario-score.sm", global.scoreManager.multiplier }, tooltip = { "military-supply-scenario-score.sm-tooltip" }})
	
	score.add({ type = "flow", name = "final-box", style = "Q-LongerBurnerPhase:score_gui_centering_flow" })
	score[ "final-box" ].add({ type = "label", name = "final", caption = get_caption_for_scoring_GUI(), style = "heading_1_label" })

	if global.goalManager.goalsCompleted >= 30 then
		breakdown.subscores[ "points-from-goals" ].tooltip = { "military-supply-scenario-score.pfg-tooltip-2" }
	end
end

--This function does NOT recalculate the score!
--@param player	The LuaPlayer whose GUI will be updated.
function update_score_GUI( player )	
	local score = player.gui.screen[ SCORING_GUI_TOP_LEVEL_NAME ]
	if score then
		local breakdown = score.breakdown
		
		score[ "scoring-titlebar" ][ "scoring-titlebar-title" ].caption = get_caption_for_scoring_GUI()
		breakdown.subscores[ "points-from-goals" ].caption = { "military-supply-scenario-score.pfg", global.scoreManager.pointsFromGoals }
		breakdown.subscores[ "points-from-time" ].caption = { "military-supply-scenario-score.pft", string.format( "%.1f", global.scoreManager.pointsFromTime )}
		breakdown.subscores[ "points-from-upgrades" ].caption = { "military-supply-scenario-score.pfu", string.format( "%.3f", global.scoreManager.pointsFromUpgrades )}
		breakdown.multis[ "raw-total" ].caption = { "military-supply-scenario-score.rt", string.format( "%.3f", global.scoreManager.rawTotal )}
		breakdown.multis[ "divisor-from-deaths" ].caption = { "military-supply-scenario-score.dfd", global.scoreManager.divisorFromDeaths }
		breakdown.multis[ "divisor-from-deaths" ].tooltip = { "military-supply-scenario-score.dfd-tooltip", global.militarySupplyScenario.playerDeaths }
		breakdown.multis[ "score-multiplier" ].caption = { "military-supply-scenario-score.sm", global.scoreManager.multiplier }
		score[ "final-box" ].final.caption = get_caption_for_scoring_GUI()
		
		if global.goalManager.goalsCompleted >= 30 then
			breakdown.subscores[ "points-from-goals" ].tooltip = { "military-supply-scenario-score.pfg-tooltip-2" }
		end
	end
end

--Hides the score GUI, but keeps it in memory until it's needed again.
--@param player	The LuaPlayer to act on.
function hide_score_GUI( player )
	--We literally make it invisible, because regenerating the entire GUI from scratch all the time is tedious.
	local score = player.gui.screen[ SCORING_GUI_TOP_LEVEL_NAME ]
	if score then
		score.visible = false
		if player.opened == score then
			player.opened = nil
		end
		local msGUI = player.gui.left[ "MilitarySupply:main" ]
		msGUI.inner[ "button-flow" ][ BUTTON_TO_TOGGLE_SCORE_GUI ].caption = { "military-supply-scenario-gui.show-score-button" }
	end
end

--This function creates the Starter Package GUI from scratch.
--If for some reason the Starter Package GUI already exists, does nothing instead.
--Also sets the button that opens the Starter Package GUI to be invisible.
--@param player	The LuaPlayer to perform the GUI operations on.
function create_starter_package_GUI( player )
	local mainGUI = player.gui.left[ "MilitarySupply:main" ]
	if mainGUI and mainGUI.inner then
		local button = mainGUI.inner[ BUTTON_TO_OPEN_STARTER_PACKAGE_GUI ]
		if button then
			button.visible = false
		end
	end

	--Don't do anything else if the GUI is already open.
	local starterPackageGUI = player.gui.screen[ STARTER_PACKAGE_GUI_TOP_LEVEL_NAME ]
	if starterPackageGUI then
		player.opened = starterPackageGUI
		starterPackageGUI.force_auto_center()
		return
	end
	--Else, the Starter Package GUI doesn't yet exist.
	starterPackageGUI = player.gui.screen.add({ type = "frame", name = STARTER_PACKAGE_GUI_TOP_LEVEL_NAME, direction = "vertical" })
	player.opened = starterPackageGUI
	starterPackageGUI.force_auto_center()
	local titlebar = starterPackageGUI.add({ type = "flow", name = "titlebar", direction = "horizontal" })
	titlebar.drag_target = starterPackageGUI
	titlebar.add({ type = "label", name = "titlebar-title", caption = { "military-supply-scenario-gui.choose-starter-package" }, ignored_by_interaction = true, style = "frame_title" })
	titlebar.add({ type = "empty-widget", name = "draggable", ignored_by_interaction = true, style = "Q-LongerBurnerPhase:titlebar_draggable_space" })
	titlebar.add({ type = "sprite-button", name = CLOSE_BUTTON_FOR_STARTER_PACKAGE_GUI, sprite = "utility/close_white", hovered_sprite = "utility/close_black", clicked_sprite = "utility/close_black", style = "close_button" })

	local list = starterPackageGUI.add({ type = "frame", name = "list-of-packages", direction = "vertical", style = "inside_shallow_frame" })

	--Loop through all starter packages & add a list entry for each:
	for i, sp in ipairs( global.starterPackages ) do
		if not game.is_valid_sprite_path( sp.sprite ) then
			error( "The sprite path of starter package "..i.." is not valid!" )
		end

		local flow = list.add({ type = "flow", name = "package-"..i, direction = "horizontal", style = "centering_horizontal_flow" })
		flow.add({ type = "sprite-button", name = BUTTON_TO_SELECT_STARTER_PACKAGE..i, sprite = sp.sprite, style = "Q-LongerBurnerPhase:slot_button_64px" })
		flow.add({ type = "label", name = "name-of-"..i, caption = sp.localisedName, style = "subheader_right_aligned_label" })
	end

	starterPackageGUI.add({ type = "frame", name = "preview", direction = "vertical", visible = false, style = "inside_shallow_frame_with_padding" })

	local footer = starterPackageGUI.add({ type = "flow", name = "footer", direction = "horizontal", style = "dialog_buttons_horizontal_flow", visible = false })
	footer.add({ type = "button", name = BUTTON_TO_DESELECT_STARTER_PACKAGE, caption = { "gui.cancel" }, style = "back_button" })
	footer.add({ type = "empty-widget", name = "draggable", style = "Q-LongerBurnerPhase:footer_draggable_space" })
	footer.draggable.drag_target = starterPackageGUI
	footer.add({ type = "button", name = BUTTON_TO_CONFIRM_STARTER_PACKAGE, caption = { "gui.confirm" }, style = "confirm_button_without_tooltip" })
end

--If the Starter Package GUI is currently open, destroys it.
--If the player's currently-opened GUI is the Starter Package GUI, sets the player's currently-opened GUI to be nil instead.
--If the button to open the Starter Package GUI exists, sets that button to be visible.
--@param player	The LuaPlayer on which to perform the GUI operations.
--@return	nil
function destroy_starter_package_GUI( player )
	--Set the button to open the Starter Package GUI to be visible (we expect it to have previously been hidden).
	local mainGUI = player.gui.left[ "MilitarySupply:main" ]
	if mainGUI and mainGUI.inner then
		local button = mainGUI.inner[ BUTTON_TO_OPEN_STARTER_PACKAGE_GUI ]
		if button then
			button.visible = true
		end
	end

	--Destroy the Starter Package GUI.
	--Sets the player's opened GUI to not be the Starter Package GUI.
	local GUI = player.gui.screen[ STARTER_PACKAGE_GUI_TOP_LEVEL_NAME ]
	if GUI then
		if player.opened == GUI then
			player.opened = nil
		end
		GUI.destroy()
	end
end

--Opens a page showing more details about the chosen starter package, or returns to the menu showing all starter packages.
--@param player	The LuaPlayer on which to perform the GUI operations.
--@param packageChosen	Number.  A value greater than zero will display the contents of a Starter Package.
--					If this is anything else, then this function returns to showing all 3 starter
--					packages so the player can choose one.
function choose_starter_package( player, packageChosen )
	local GUI = player.gui.screen[ STARTER_PACKAGE_GUI_TOP_LEVEL_NAME ]
	--If the GUI does not exist, then something has gone wrong because this function shouldn't have been called.
	if not GUI then
		return
	end

	--In older versions of this mod, packageChosen was supposed to be a string.
	--Test to make sure the new format is being followed.
	if type( packageChosen ) ~= "number" then
		error( "Paramater \"packageChosen\" was invalid.  Number expected, got "..type( packageChosen ).."." )
	end
	
	--Here we assume that the GUI and everything in it is valid.
	if packageChosen > 0 then
		local thePackage = global.starterPackages[ packageChosen ]

		--Show/hide relevant parts of the GUI:
		GUI[ "titlebar" ][ "titlebar-title" ].caption = thePackage.localisedName
		GUI[ "list-of-packages" ].visible = false
		GUI[ "footer" ].visible = true

		--Clear the preview & repopulate it from scratch:
		local preview = GUI[ "preview" ]
		preview.visible = true
		preview.clear()
		
		if type( thePackage.isChallenge ) ~= "boolean" then
			error( "Paramater \"isChallenge\" was invalid.  Boolean expected, got "..type( thePackage.isChallenge ).."." )
		end

		if thePackage.isChallenge then
			local warningText = preview.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-is-challenge" }, style = "caption_label" })
			warningText.style.single_line = false
			warningText.style.maximal_width = 250
			preview.add({ type = "line", direction = "horizontal" })
		end

		local contents = thePackage.contents
		if not contents or #contents < 1 then
			error( "The requested starter package has no contents!" )
		end

		--We populate the GUI based on the data inside the table!
		--Yay for data-based things!  Yay!  Data!  Supposed to be cleaner, better-organized code!
		for _, v in ipairs( contents ) do
			--Each separate thing in the starter package corresponds with a row in the list:
			local flow = preview.add({ type = "flow", direction = "horizontal", style = "centering_horizontal_flow" })

			if type( v.type ) ~= "string" then
				error( "Paramater \"type\" was invalid.  String expected, got "..type( v.type ).."." )
			end
			if v.type == "item" then
				if type( v.item ) ~= "string" then
					error( "Paramater \"item\" was invalid.  String expected, got "..type( v.item ).."." )
				end
				if type( v.count ) ~= "number" then
					error( "Paramater \"count\" was invalid.  Number expected, got "..type( v.count ).."." )
				end
				--Else: valid.
				--We use a sprite button to represent a quantity of an item that doesn't physically exist yet in the world.
				--Since the button is not meant to be clicked on, we set it to ignore interaction.
				--Sprite buttons are the only GUI element that supports drawing a number on it.
				flow.add({ type = "sprite-button", sprite = "item/"..v.item, number = v.count,
					ignored_by_interaction = true, style = "slot_button" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-item-qty",
					game.item_prototypes[ v.item ].localised_name, v.count }})
			elseif v.type == "crafting-speed-modifier" then
				if type( v.modifier ) ~= "number" then
					error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
				end
				--Else: valid.
				--We use the character sprite & calculate the percentage bonus.
				flow.add({ type = "sprite", sprite = "entity/character", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-crafting-bonus", 100 * v.modifier }})
			elseif v.type == "armor-with-shield" then
				--Remember, the armor & the equipment inside it are all predefined.
				flow.add({ type = "sprite", sprite = "item/modular-armor", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-armor-with-shield" }})
			elseif v.type == "armor-with-roboport" then
				--Remember, the armor & the equipment inside it are all predefined.
				flow.add({ type = "sprite", sprite = "item/modular-armor", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-armor-with-roboport" }})
			elseif v.type == "force-map-chart" then
				--Remember, the armor & the equipment inside it are all predefined.
				flow.add({ type = "sprite", sprite = "item/radar", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-force-map-chart" }})
			elseif v.type == "money-multiplier" then
				if type( v.multiplier ) ~= "number" then
					error( "Paramater \"multiplier\" was invalid.  Number expected, got "..type( v.multiplier ).."." )
				end
				flow.add({ type = "sprite", sprite = "item/coin", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-money-multiplier", v.multiplier }})
			elseif v.type == "score-multiplier" then
				if type( v.multiplier ) ~= "number" then
					error( "Paramater \"multiplier\" was invalid.  Number expected, got "..type( v.multiplier ).."." )
				end
				flow.add({ type = "sprite", sprite = "military-supply-score-multiplier", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-score-multiplier", v.multiplier }})
			elseif v.type == "richness-penalty" then
				flow.add({ type = "sprite", sprite = "military-supply-ore-richness-penalty", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-richness-penalty" }})
			elseif v.type == "worker-robots-speed-modifier" then
				if type( v.modifier ) ~= "number" then
					error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
				end
				--Else: valid.
				flow.add({ type = "sprite", sprite = "military-supply-worker-robot-speed-bonus", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-worker-robots-speed-modifier", 100 * v.modifier }})
			elseif v.type == "manual-mining-speed-penalty" then
				if type( v.modifier ) ~= "number" then
					error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
				end
				--Else: valid.
				flow.add({ type = "sprite", sprite = "military-supply-manual-mining-penalty", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-manual-mining-speed-penalty", 100 * v.modifier }})
			elseif v.type == "ghost-rebuild-timeout" then
				if type( v.hoursToTimeout ) ~= "number" then
					error( "Paramater \"hoursToTimeout\" was invalid.  Number expected, got "..type( v.hoursToTimeout ).."." )
				end
				--Else: valid.
				flow.add({ type = "sprite", sprite = "military-supply-ghost-rebuild-timeout", style = "tool_equip_equipment_image" })
				flow.add({ type = "label", caption = { "military-supply-scenario-gui.starter-package-ghost-rebuild-timeout", v.hoursToTimeout }})
			else
				error( "Parameter \"type\" was not one of the predefined valid values." )
			end
		end
	else
		--Parameter packageChosen was 0 or negative.  That means "select no package."
		GUI[ "titlebar" ][ "titlebar-title" ].caption = { "military-supply-scenario-gui.choose-starter-package" }
		GUI[ "list-of-packages" ].visible = true
		GUI[ "preview" ].visible = false
		GUI[ "footer" ].visible = false
	end
end

--Grants the player the chosen Starter Package.  If successful, destroys the Starter Package GUI afterwards.
--@param player	The LuaPlayer who will receive the chosen Starter Package.
--@param packageChosen	Number.  A value greater than zero will grant a Starter Package.
--					Any other value will perform no action.
function receive_starter_package( player, packageChosen )
	local GUI = player.gui.screen[ STARTER_PACKAGE_GUI_TOP_LEVEL_NAME ]
	--If the GUI does not exist, the player may already have chosen a Starter Package.
	--In this case, skip everything else to prevent possible errors.
	if not GUI then
		return
	end

	--In older versions of this mod, packageChosen was supposed to be a string.
	--Test to make sure the new format is being followed.
	if type( packageChosen ) ~= "number" then
		error( "Paramater \"packageChosen\" was invalid.  Number expected, got "..type( packageChosen ).."." )
	end

	if packageChosen > 0 then
		apply_bonuses_from_starter_package( player, packageChosen )
		
		set_next_message_of_scenario_object( global.militarySupplyScenario, 240, "thoughts-initial4" )
		
		--Seed the RNG based off the player's movements & the starter package chosen:
		seed_RNG( packageChosen, player )

		--Destroy the Starter Packages GUI:
		GUI.destroy()
		local msGUI = player.gui.left[ "MilitarySupply:main" ]
		msGUI.caption = { "military-supply-scenario-gui.title1" }
		msGUI.inner[ "info-goes-here" ].caption = { "military-supply-scenario-gui.description-wait" }
		msGUI.inner[ BUTTON_TO_OPEN_STARTER_PACKAGE_GUI ].destroy()
	end
end

--Determines which Starter Package the player currently is previewing in their GUI.
--@param player	The LuaPlayer whose GUI to check.
--@return			Number.  Returns the index of the currently open starter package.
--				Note that if the Starter Package GUI is open but the player isn't previewing any
--				Starter Package, then 0 is returned.  0 is also returned if the GUI isn't open.
function get_which_starter_package_is_chosen( player )
	local starterPackageGUI = player.gui.screen[ STARTER_PACKAGE_GUI_TOP_LEVEL_NAME ]
	if starterPackageGUI then
		local title = starterPackageGUI.titlebar[ "titlebar-title" ].caption
		for index, v in ipairs( global.starterPackages ) do
			--This line of code below is why we require "util" at the beginning of this file.
			if table.compare( title, v.localisedName ) then
				return index
			end
		end
	end
	--Else, the Starter Package GUI was not open at all, or the player was not previewing anything.
	return 0
end