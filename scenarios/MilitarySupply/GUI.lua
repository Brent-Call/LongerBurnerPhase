--The name of the top-level LuaGuiElement for the scoring GUI:
SCORING_GUI_TOP_LEVEL_NAME = "MilitarySupply:scoring"
CLOSE_BUTTON_FOR_SCORING_GUI = "totally-unique-string-{a9b462b5-836e-4d5e-ae5a-37bdf046450a}"

function show_goal( player )
	if not player.gui.left.goal then
		player.gui.left.add{ type = "frame", name = "goal", caption = { "military-supply-scenario-goals-GUI.goal-count", global.goalManager.goalsCompleted }, direction = "vertical" }
		local goal = player.gui.left.goal
		local mS = global.militarySupplyScenario
		
		--If there is a bonus to money from goals: show the reward bonus
		if mS.moneyMultiplier > 1 then
			goal.add{ type = "label", name = "goal-money-multiplier", caption = { "military-supply-scenario-goals-GUI.money-multiplier", mS.moneyMultiplier }}
		end
		
		if get_goal_count_of_goals_manager( global.goalManager ) > 0 then
			--Create a table of goals & set the column headers:
			goal.add{ type = "table", name = "goal-table", column_count = 3, draw_horizontal_lines = true }
			goal[ "goal-table" ].add{ type = "label", name = "goal-header1", caption = { "military-supply-scenario-goals-GUI.header1" }}
			goal[ "goal-table" ].add{ type = "label", name = "goal-header2", caption = { "military-supply-scenario-goals-GUI.header2" }}
			goal[ "goal-table" ].add{ type = "label", name = "goal-header3", caption = { "military-supply-scenario-goals-GUI.header3" }}
		
			--Add all goals to the table:
			add_goals_to_table_of_goals_manager( global.goalManager, goal[ "goal-table" ])
		else
			goal.add{ type = "label", name = "no-goals-left", caption = { "military-supply-scenario-goals-GUI.no-goals-left" }}
		end
		
		goal.add{ type = "label", name = "time-left", caption = { "military-supply-scenario-goals-GUI.time-left", get_time_left_of_scenario_object( mS )}}
		
		if mS.playerDeaths > 0 then
			goal.add{ type = "label", name = "deaths-warning", caption = { "military-supply-scenario-goals-GUI.deaths-warning", mS.playerDeaths }}
			goal[ "deaths-warning" ].style.single_line = false
		end
	end
end
--This function updates everything in the goals GUI
function update_goal( player )
	if player.gui.left.goal then
		local goal = player.gui.left.goal
		local mS = global.militarySupplyScenario
		
		--In the top of the GUI, update the display to show the correct number of completed goals:
		goal.caption = { "military-supply-scenario-goals-GUI.goal-count", global.goalManager.goalsCompleted }
		goal.clear()
		
		--If there is a bonus to money from goals: show the reward bonus
		if mS.moneyMultiplier > 1 then
			goal.add{ type = "label", name = "goal-money-multiplier", caption = { "military-supply-scenario-goals-GUI.money-multiplier", mS.moneyMultiplier }}
		end
		
		if get_goal_count_of_goals_manager( global.goalManager ) > 0 then
			--Create a table of goals & set the column headers:
			goal.add{ type = "table", name = "goal-table", column_count = 3, draw_horizontal_lines = true }
			goal[ "goal-table" ].add{ type = "label", name = "goal-header1", caption = { "military-supply-scenario-goals-GUI.header1" }}
			goal[ "goal-table" ].add{ type = "label", name = "goal-header2", caption = { "military-supply-scenario-goals-GUI.header2" }}
			goal[ "goal-table" ].add{ type = "label", name = "goal-header3", caption = { "military-supply-scenario-goals-GUI.header3" }}
		
			--Add all goals to the table:
			add_goals_to_table_of_goals_manager( global.goalManager, goal[ "goal-table" ])
		else
			goal.add{ type = "label", name = "no-goals-left", caption = { "military-supply-scenario-goals-GUI.no-goals-left" }}
		end
		
		goal.add{ type = "label", name = "time-left", caption = { "military-supply-scenario-goals-GUI.time-left", get_time_left_of_scenario_object( mS )}}
	
		if mS.playerDeaths > 0 then
			goal.add{ type = "label", name = "deaths-warning", caption = { "military-supply-scenario-goals-GUI.deaths-warning", mS.playerDeaths }}
			goal[ "deaths-warning" ].style.single_line = false
		end
	end
end
--This function only updates the clock.  That's all it does.
function update_goal_timer( player )
	if player.gui.left.goal then
		player.gui.left.goal[ "time-left" ].caption = { "military-supply-scenario-goals-GUI.time-left", get_time_left_of_scenario_object( global.militarySupplyScenario )}
	end
end

function hide_goal( player )
	if player.gui.left.goal then
		player.gui.left.goal.destroy()
	end
end

function fill_shop_GUI_table( upgradesTable )
	--Add the available upgrades to the list:
	for name, upgrade in pairs( global.militarySupplyScenario.upgrades ) do
		if not upgrade.purchased then
			--The cost is displayed in green if the player CAN afford it, & red if the player CANNOT afford it:
			if global.militarySupplyScenario.money >= upgrade.cost then
				upgradesTable.add{ type = "sprite-button", name = "upgrades-button"..name, sprite = upgrade.icon, tooltip = { "military-supply-scenario-shop-GUI.tooltip-can-afford" }}
				upgradesTable.add{ type = "label", name = name.."-b", caption = upgrade.description }.style.single_line = false
				upgradesTable.add{ type = "label", name = name.."-c", style = "bold_green_label", caption = { "military-supply-scenario-shop-GUI.item-cost", upgrade.cost }}
			else				
				upgradesTable.add{ type = "sprite-button", name = "upgrades-button"..name, sprite = upgrade.icon, tooltip = { "military-supply-scenario-shop-GUI.tooltip-cannot-afford" }}
				upgradesTable.add{ type = "label", name = name.."-b", caption = upgrade.description }.style.single_line = false
				upgradesTable.add{ type = "label", name = name.."-c", style = "bold_red_label", caption = { "military-supply-scenario-shop-GUI.item-cost", upgrade.cost }}
			end
		end
	end
end

function show_shop_GUI( player )
	local shop = player.gui.center.add{ type = "frame", name = "shop", direction = "vertical", caption = { "military-supply-scenario-shop-GUI.money", global.militarySupplyScenario.money }}
	player.opened = shop
	shop.add{ type = "label", name = "upgrades-purchased", caption = { "military-supply-scenario-shop-GUI.upgrades-purchased", global.militarySupplyScenario.purchasedUpgrades }}
	
	if global.militarySupplyScenario.availableUpgrades > 0 then
		--This line of code creates the table & then supplies it to the function fill_shop_GUI_table(...)
		fill_shop_GUI_table( shop.add{ type = "table", name = "available-upgrades-table", column_count = 3, draw_vertical_lines = true })
	else
		shop.add{ type = "label", name = "no-more-upgrades", caption = { "military-supply-scenario-shop-GUI.no-upgrades-left" }}
	end
end

function update_shop_GUI( player )
	local shop = player.gui.center.shop
	if shop then
		shop.caption = { "military-supply-scenario-shop-GUI.money", global.militarySupplyScenario.money }
		shop[ "upgrades-purchased"].caption = { "military-supply-scenario-shop-GUI.upgrades-purchased", global.militarySupplyScenario.purchasedUpgrades }
		
		if shop[ "available-upgrades-table" ] then
			shop[ "available-upgrades-table" ].destroy()
		end
		if shop[ "no-more-upgrades" ] then
			shop[ "no-more-upgrades" ].destroy()
		end
		
		if global.militarySupplyScenario.availableUpgrades > 0 then
			--This line of code creates the table & then supplies it to the function fill_shop_GUI_table(...)
			fill_shop_GUI_table( shop.add{ type = "table", name = "available-upgrades-table", column_count = 3, draw_vertical_lines = true })
		else
			shop.add{ type = "label", name = "no-more-upgrades", caption = { "military-supply-scenario-shop-GUI.no-upgrades-left" }}
		end
	end
end

function hide_shop_GUI( player )
	if player.gui.center.shop then
		player.gui.center.shop.destroy()
	end
end

--Gets the LocalisedString to be used as the title for the scoring GUI.
--@return	A LocalisedString object with data from the most recent tick update.
function get_caption_for_scoring_GUI()
	return { "military-supply-scenario-score.current-score", string.format( "%.3f", global.scoreManager.finalScore )}
end

function show_score_GUI( player )
	--First, calculate the score:
	calculate_score_manager_object( global.scoreManager )
	
	local score = player.gui.screen.add{ type = "frame", name = SCORING_GUI_TOP_LEVEL_NAME, direction = "vertical" }
	player.opened = score
	score.force_auto_center()

	local titlebar = score.add{ type = "flow", name = "scoring-titlebar", direction = "horizontal" }
	titlebar.drag_target = score
	titlebar.add{ type = "label", name = "scoring-titlebar-title", caption = get_caption_for_scoring_GUI(), ignored_by_interaction = true, style = "frame_title" }
	titlebar.add{ type = "empty-widget", name = "scoring-titlebar-draggable", ignored_by_interaction = true, style = "draggable_space_header" }
	titlebar[ "scoring-titlebar-draggable" ].style.height = 24
	titlebar[ "scoring-titlebar-draggable" ].style.horizontally_stretchable = true
	titlebar.add{ type = "sprite-button", name = CLOSE_BUTTON_FOR_SCORING_GUI, sprite = "utility/close_white", hovered_sprite = "utility/close_black", clicked_sprite = "utility/close_black", style = "close_button" }
	
	score.add{ type = "label", name = "description", caption = { "military-supply-scenario-score.description" }, style = "info_label" }
	score.description.style.single_line = false
	score.add{ type = "flow", name = "breakdown", direction = "horizontal", style = "centering_horizontal_flow" }
	
	local breakdown = score.breakdown
	breakdown.style.horizontal_spacing = 16
	breakdown.style.horizontally_stretchable = true
	
	breakdown.add{ type = "frame", name = "subscores", direction = "vertical", style = "inside_shallow_frame_with_padding" }
	breakdown.subscores.style.horizontally_stretchable = false
	breakdown.subscores.add{ type = "label", name = "points-from-goals", caption = { "military-supply-scenario-score.pfg", global.scoreManager.pointsFromGoals }, tooltip = { "military-supply-scenario-score.pfg-tooltip" }}
	breakdown.subscores.add{ type = "label", name = "points-from-time", caption = { "military-supply-scenario-score.pft", string.format( "%.1f", global.scoreManager.pointsFromTime )}, tooltip = { "military-supply-scenario-score.pft-tooltip" }}
	breakdown.subscores.add{ type = "label", name = "points-from-upgrades", caption = { "military-supply-scenario-score.pfu", string.format( "%.3f", global.scoreManager.pointsFromUpgrades )}, tooltip = { "military-supply-scenario-score.pfu-tooltip" }}
	breakdown.add{ type = "frame", name = "multis", direction = "vertical", style = "inside_shallow_frame_with_padding" }
	breakdown.multis.style.horizontally_stretchable = false
	breakdown.multis.add{ type = "label", name = "raw-total", caption = { "military-supply-scenario-score.rt", string.format( "%.3f", global.scoreManager.rawTotal )}, tooltip = { "military-supply-scenario-score.rt-tooltip" }}
	breakdown.multis.add{ type = "label", name = "divisor-from-deaths", caption = { "military-supply-scenario-score.dfd", global.scoreManager.divisorFromDeaths }, tooltip = { "military-supply-scenario-score.dfd-tooltip", global.militarySupplyScenario.playerDeaths }}
	breakdown.multis.add{ type = "label", name = "score-multiplier", caption = { "military-supply-scenario-score.sm", global.scoreManager.multiplier }, tooltip = { "military-supply-scenario-score.sm-tooltip" }}
	
	score.add{ type = "flow", name = "final-box", style = "centering_horizontal_flow" }
	score[ "final-box" ].style.horizontally_stretchable = true
	score[ "final-box" ].add{ type = "label", name = "final", caption = get_caption_for_scoring_GUI(), style = "heading_1_label" }

	if global.goalManager.goalsCompleted >= 30 then
		breakdown.subscores[ "points-from-goals" ].tooltip = { "military-supply-scenario-score.pfg-tooltip-2" }
	end
end

--This function does NOT recalculate the score!
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

function hide_score_GUI( player )
	local score = player.gui.screen[ SCORING_GUI_TOP_LEVEL_NAME ]
	if score then
		score.destroy()
	end
end

function create_starter_bonus_GUI( player )
	local GUI = player.gui.left.add{ type = "frame", name = "starter-bonus-GUI", caption = { "military-supply-scenario-starter-bonus-GUI.gui-title" }, direction = "horizontal" }
	GUI.add{ type = "sprite-button", name = "button-logistics", sprite = "item-group/logistics", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-logistics-name" }}
	GUI.add{ type = "sprite-button", name = "button-production", sprite = "item-group/production", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-production-name" }}
	GUI.add{ type = "sprite-button", name = "button-combat", sprite =  "item-group/combat", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-combat-name" }}
	
	--Make the pictures 64x64:
	GUI[ "button-logistics" ].style.width = 64
	GUI[ "button-logistics" ].style.height = 64
	GUI[ "button-production" ].style.width = 64
	GUI[ "button-production" ].style.height = 64
	GUI[ "button-combat" ].style.width = 64
	GUI[ "button-combat" ].style.height = 64
	
end

function add_preview_item( id, item, quantity, GUI )
	GUI.content.add{ type = "sprite", name = id.."1", sprite = "item/"..item }
	GUI.content.add{ type = "label", name = id.."2", caption = { "military-supply-scenario-starter-bonus-GUI.package-preview-item-qty", game.item_prototypes[ item ].localised_name, quantity }}
end

function add_preview_bonus( id, spr, localizedString, GUI )
	GUI.content.add{ type = "sprite", name = id.."1", sprite = spr }
	GUI.content.add{ type = "label", name = id.."2", caption = localizedString }
end

--For packageChosen, use "logistics," "production," "combat," or you may use "" to signal no package & return to the main menu of the GUI:
function choose_starter_bonus( player, packageChosen )
	local GUI = player.gui.left[ "starter-bonus-GUI" ]
	--If the GUI does not exist, the player may already have chosen a Starter Package.
	--In this case, skip everything else to prevent possible errors.
	if not GUI then
		return
	end
	
	--Here we assume that the GUI and everything in it is valid:
	if packageChosen == "logistics" then
		GUI.clear()
		GUI.caption = { "military-supply-scenario-starter-bonus-GUI.package-logistics-name" }
		GUI.add{ type = "table", name = "content", column_count = 2 }
		add_preview_item( "a", "transport-belt", 100, GUI )
		add_preview_item( "b", "underground-belt", 10, GUI )
		add_preview_item( "c", "splitter", 10, GUI )
		add_preview_item( "d", "burner-inserter", 25, GUI )
		add_preview_item( "e", "steel-chest", 10, GUI )
		GUI.content.add{ type = "button", name = "no-logistics", caption = { "military-supply-scenario-starter-bonus-GUI.gui-no" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-no" }}
		GUI.content.add{ type = "button", name = "yes-logistics", caption = { "military-supply-scenario-starter-bonus-GUI.gui-yes" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-yes" }}
	elseif packageChosen == "production" then
		GUI.clear()
		GUI.caption = { "military-supply-scenario-starter-bonus-GUI.package-production-name" }
		GUI.add{ type = "table", name = "content", column_count = 2 }
		add_preview_item( "a", "burner-assembling-machine-1", 5, GUI )
		add_preview_item( "b", "burner-mining-drill", 10, GUI )
		add_preview_item( "c", "stone-furnace", 40, GUI )
		add_preview_item( "d", "burner-inserter", 10, GUI )
		add_preview_bonus( "e", "entity/character", { "military-supply-scenario-starter-bonus-GUI.package-production-preview-e2" }, GUI )
		GUI.content.add{ type = "button", name = "no-production", caption = { "military-supply-scenario-starter-bonus-GUI.gui-no" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-no" }}
		GUI.content.add{ type = "button", name = "yes-production", caption = { "military-supply-scenario-starter-bonus-GUI.gui-yes" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-yes" }}
	elseif packageChosen == "combat" then
		GUI.clear()
		GUI.caption = { "military-supply-scenario-starter-bonus-GUI.package-combat-name" }
		GUI.add{ type = "table", name = "content", column_count = 2 }
		add_preview_item( "a", "uranium-rounds-magazine", 200, GUI )
		add_preview_item( "b", "military-supply-power-armor", 1, GUI )
		add_preview_item( "c", "grenade", 20, GUI )
		add_preview_item( "d", "stone-wall", 100, GUI )
		add_preview_bonus( "e", "item/radar", { "military-supply-scenario-starter-bonus-GUI.package-combat-preview-e2" }, GUI )
		GUI.content.add{ type = "button", name = "no-combat", caption = { "military-supply-scenario-starter-bonus-GUI.gui-no" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-no" }}
		GUI.content.add{ type = "button", name = "yes-combat", caption = { "military-supply-scenario-starter-bonus-GUI.gui-yes" }, tooltip = { "military-supply-scenario-starter-bonus-GUI.tooltip-yes" }}
	elseif packageChosen == "" then
		GUI.clear()
		GUI.caption = { "military-supply-scenario-starter-bonus-GUI.gui-title" }
		GUI.add{ type = "sprite-button", name = "button-logistics", sprite = "item-group/logistics", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-logistics-name" }}
		GUI.add{ type = "sprite-button", name = "button-production", sprite = "item-group/production", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-production-name" }}
		GUI.add{ type = "sprite-button", name = "button-combat", sprite =  "item-group/combat", tooltip = { "military-supply-scenario-starter-bonus-GUI.package-combat-name" }}

		--Make the pictures 64x64:
		GUI[ "button-logistics" ].style.width = 64
		GUI[ "button-logistics" ].style.height = 64
		GUI[ "button-production" ].style.width = 64
		GUI[ "button-production" ].style.height = 64
		GUI[ "button-combat" ].style.width = 64
		GUI[ "button-combat" ].style.height = 64
	end
end

--For packageChosen, use "logistics," "production," or "combat."  Any other value will perform no action.
function receive_starter_bonus( player, packageChosen )
	local GUI = player.gui.left[ "starter-bonus-GUI" ]
	--If the GUI does not exist, the player may already have chosen a Starter Package.
	--In this case, skip everything else to prevent possible errors.
	if not GUI then
		return
	end
	
	if packageChosen == "logistics" then
		GUI.destroy()
		player.print{ "military-supply-scenario-starter-bonus-GUI.thoughts-choose-logistics" }
		player.insert{ name = "transport-belt", count = 100 }
		player.insert{ name = "underground-belt", count = 10 }
		player.insert{ name = "splitter", count = 10 }
		player.insert{ name = "burner-inserter", count = 25 }
		player.insert{ name = "steel-chest", count = 10 }
		
		set_next_message_of_scenario_object( global.militarySupplyScenario, 240, "thoughts-initial4" )
	elseif packageChosen == "production" then
		GUI.destroy()
		player.print{ "military-supply-scenario-starter-bonus-GUI.thoughts-choose-production" }
		player.insert{ name = "burner-assembling-machine-1", count = 5 }
		player.insert{ name = "burner-mining-drill", count = 10 }
		player.insert{ name = "stone-furnace", count = 40 }
		player.insert{ name = "burner-inserter", count = 10 }
		if player.character then
			player.character_crafting_speed_modifier = player.character_crafting_speed_modifier + 0.5
		end
		
		set_next_message_of_scenario_object( global.militarySupplyScenario, 240, "thoughts-initial4" )
	elseif packageChosen == "combat" then
		GUI.destroy()
		player.print{ "military-supply-scenario-starter-bonus-GUI.thoughts-choose-combat" }
		player.insert{ name = "uranium-rounds-magazine", count = 200 }
		player.insert{ name = "military-supply-power-armor", count = 1 }
		player.insert{ name = "grenade", count = 20 }
		player.insert{ name = "stone-wall", count = 100 }	
		player.force.chart( 1, {{ -400, -400 }, { 200, 200 }})
		
		set_next_message_of_scenario_object( global.militarySupplyScenario, 240, "thoughts-initial4" )
	end
end

function update_objective( player )
	local objective = player.gui.left.objective
	objective.clear()
	objective.add{ type = "label", name = "objective-text3", caption = { "military-supply-scenario-objective.player-objective-text3" }}
end