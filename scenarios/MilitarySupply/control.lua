require( "Goals_lib" )
require( "Functions" )
require( "GUI" )

--This function returns a scenario object:
function create_scenario()
	local scenario = {}
	scenario.messages = {}
	--This table contains all purchases, whether already bought or otherwise
	scenario.upgrades = {}
	--Used to tell wether to put sulfur or zarnium, respectively, in the SUPPLY DROPOFF CHEST or not:
	scenario.sulfurUnlocked = false
	scenario.zarniumUnlocked = false
	--Number of available, unpurchased upgrades:
	scenario.availableUpgrades = 0
	--Number of upgrades already purchased:
	scenario.purchasedUpgrades = 0
	scenario.money = 0
	--Completing goals gives you money.  The amount of money is multiplied by this number.
	scenario.moneyMultiplier = 1
	--A multiplier to your final score.
	scenario.scoreMultiplier = 1
	scenario.playerDeaths = 0
	--Time limit is 6 hours.  Shouldn't really be a problem, unless you die a lot.
	scenario.secondsLeft = 60 * 60 * 6
	scenario.nextMessage = nil
	scenario.ticksTillNextMessage = nil
	--Since Factorio no longer supports storing functions in savegames, this object has no member functions.
	return scenario
end

function create_score_manager()
	return { pointsFromGoals = 0, pointsFromTime = 0, pointsFromUpgrades = 0, rawTotal = 0, divisorFromDeaths = 1, multiplier = 1, finalScore = 0 }
	--Since Factorio no longer supports storing functions in savegames, this object has no member functions.
end

update_scenario_object = function( s )
	if type( s.ticksTillNextMessage ) == "number" then
		if s.ticksTillNextMessage == 0 then
			display_message_of_scenario_object( s, s.nextMessage )
		end
		if s.ticksTillNextMessage > -1 then
			s.ticksTillNextMessage = s.ticksTillNextMessage - 1
		end
	end
end
add_message_to_scenario_object = function( s, name, ticksTillNext, nextMessage, extraFunc )
	local message = {}
	message.text = "military-supply-scenario-thoughts."..name
	message.ticksTillNext = ticksTillNext
	message.nextMessage = nextMessage
	message.shown = false
	if type( extraFunc ) == "function" then
		error( "Cannot add the message named "..name.." because the extraFunc is of the wrong data type!" )
	elseif type( extraFunc ) == "string" then
		message.extraFunc = extraFunc
	end
	s.messages[ name ] = message
end
display_message_of_scenario_object = function( s, name )
	local msg = s.messages[ name ]
	if not msg then
		return
	end
	--Don't show the message if it's been shown already:
	if msg.shown then
		return
	end
	--Note that this command prints it so that ALL players can see it:
	game.print{ msg.text }
	--Update the message so it's shown:
	msg.shown = true
	
	--Note: this could potentially cause errors:
	if type( msg.extraFunc ) == "string" then
		local eF = messageAssociatedFunctions[ msg.extraFunc ]
		if type( eF ) == "function" then
			eF()
		else
			error( "Message-associated function named "..msg.extraFunc.." could not be found!" )
		end
	end
	
	--Tell the scenario to set the next message, if there is one:
	set_next_message_of_scenario_object( s, msg.ticksTillNext, msg.nextMessage )
	
end

--Pass in the name of the upgrade (as a string), the sprite path for the icon, its cost.  The upgrade's effects are looked up in the upgradeAssociatedFunctions table & called if they are there.
--The key is the upgradeName
--The description for the upgrade will automatically be generated based on the upgrade's name.
add_upgrade_to_scenario_object = function( s, upgradeName, upgradeIcon, upgradeCost )
	s.upgrades[ upgradeName ] = { name = upgradeName, icon = upgradeIcon, cost = upgradeCost, description = { "military-supply-scenario-upgrades."..upgradeName }, purchased = false }
	s.availableUpgrades = s.availableUpgrades + 1
end
purchase_upgrade_of_scenario_object = function( s, upgradeName )
	local toBuy = s.upgrades[ upgradeName ]
	if not toBuy then
		--The upgrade isn't valid.  Do nothing.
		return
	end
	if toBuy.alreadyPurchased then
		--The upgrade was already purchased.  Do nothing.
		return
	end
	--Else, the upgrade is valid:
	if s.money >= toBuy.cost then
		--The player can pay for it!
		s.money = s.money - toBuy.cost
		local eF = upgradeAssociatedFunctions[ toBuy.name ]
		if type( eF ) == "function" then
			eF()
		else
			error( "Upgrade-associated function named "..toBuy.name.." could not be found!" )
		end
		toBuy.purchased = true
		s.purchasedUpgrades = s.purchasedUpgrades + 1
		s.availableUpgrades = s.availableUpgrades - 1
	end
end
get_time_left_of_scenario_object = function( s )
	local hours = math.max( 0, math.floor( s.secondsLeft / 3600 ))
	local minutes = math.max( 0, math.floor( s.secondsLeft / 60 ) - hours * 60 )
	local seconds = math.max( 0, s.secondsLeft - hours * 3600 - minutes * 60 )
	return hours, minutes, seconds
end
set_next_message_of_scenario_object = function( s, ticks, name )
	if type( name ) == "string" and type( ticks ) == "number" then
		s.nextMessage = name
		s.ticksTillNextMessage = ticks
	end
end
get_was_message_shown_of_scenario_object = function( s, name )
	return s.messages[ name ].shown
end

--The scenario object has the following methods:
--add_message(...) pass it the localized string of the message (without the military-supply-scenario. part), and optionally, set the next message
--display_message(...) pass it the name of the message to display
--update(...) call this once every tick
--set_next_message(...) pass it the number of ticks to wait & the name of the message to go to
--message_displayed(...) pass it the name & it will return a boolean
--get_time_left(...) it returns 3 values: hours, minutes, & seconds

--This function will perform all of the math & update all internal values.  It returns nothing.
calculate_score_manager_object = function( self )
	--Create some local references to external objects, then check them for validity:
	local gMan = global.goalManager
	local mS = global.militarySupplyScenario
	
	if not gMan then
		error( "Cannot calculate score because goalManager is missing." )
	end
	if not mS then
		error( "Cannot calculate score because main scenario object is missing." )
	end
	--Else, there are no errors, so continue:
	
	--Every goal up to & including 30 provides 10 points.  Every goal after 30 provides 50 points:
	self.pointsFromGoals = 10 * gMan.goalsCompleted + 40 * math.max( gMan.goalsCompleted - 30, 0 )
	--Every second is worth 0.5 points.  The score cannot fall below 0 (time remaining can, however):
	self.pointsFromTime = math.max( 0, 0.5 * mS.secondsLeft )
	--Earn points equal to 100 times the square root of the number of purchased upgrades:
	self.pointsFromUpgrades = 100 * math.sqrt( mS.purchasedUpgrades )
	--From the 3 values above, a raw total is calculated:
	self.rawTotal = self.pointsFromGoals + self.pointsFromTime + self.pointsFromUpgrades
	--Divide by the number of player deaths + 1:
	self.divisorFromDeaths = mS.playerDeaths + 1
	--Apply the scenario score multiplier:
	self.multiplier = mS.scoreMultiplier
	--The calculation for final score is: ( raw total divided by deaths divisor ) times money multiplier:
	self.finalScore = ( self.rawTotal / self.divisorFromDeaths ) * self.multiplier
end

script.on_init( function()
	global.militarySupplyScenario = create_scenario()
	global.goalManager = create_goals_manager()
	global.scoreManager = create_score_manager()
	
	--This table contains all of the items that can be made into goals & all of the monetary values per item:
	--Copper & coal are both worth 0.25
	--Iron is worth 0.5
	--Stone bricks are worth 0.75
	--Steel is worth 1.25
	--Each item here has 4 data values:
	--	name: The name of the item prototype.
	--	price: The price of 1 item of this type.
	--	min: The minimum amount that can be in one order.
	--	max: The maximum amount that can be in one order.
	global.goalItemTable = {}
	
	local mS = global.militarySupplyScenario
	add_message_to_scenario_object( mS, "thoughts-initial1", 360, "thoughts-initial2", "msg_initial_upgrades" )
	add_message_to_scenario_object( mS, "thoughts-initial2", 300, "thoughts-initial3" )
	add_message_to_scenario_object( mS, "thoughts-initial3", 300, "thoughts-choose-starter-package", "msg_initial_resources" )
	add_message_to_scenario_object( mS, "thoughts-choose-starter-package", nil, nil, "msg_starter_bonus_GUI" )
	add_message_to_scenario_object( mS, "thoughts-initial4", 600, "thoughts-initial5", "msg_initial_recipes" )
	add_message_to_scenario_object( mS, "thoughts-initial5", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-find-shipwreck", nil, nil, "msg_on_find_shipwreck" )
	add_message_to_scenario_object( mS, "thoughts-killed-biters", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-built-turret", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-built-wall", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-killed-spawner1", 240, "thoughts-killed-spawner2", "msg_on_killed_spawner" )
	add_message_to_scenario_object( mS, "thoughts-killed-spawner2", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-player-died", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-hint-at-mission", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-pistol-obsolete", nil, nil )
	
	--When you complete goals (in intervals of 5), these messages show up:
	add_message_to_scenario_object( mS, "thoughts-news-5-goals", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-news-15-goals1", 300, "thoughts-news-15-goals2" )
	add_message_to_scenario_object( mS, "thoughts-news-15-goals2", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-news-20-goals", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-25-goals", nil, nil )
	add_message_to_scenario_object( mS, "thoughts-receive-secret-mission1", 360, "thoughts-receive-secret-mission2", "msg_unlock_eternity_ray" )
	add_message_to_scenario_object( mS, "thoughts-receive-secret-mission2", nil, nil )
	
	--These ones are set to appear when you buy the respective upgrade:
	add_message_to_scenario_object( mS, "thoughts-better-cable-making" )
	add_message_to_scenario_object( mS, "thoughts-bullet-bonus-1" )
	add_message_to_scenario_object( mS, "thoughts-bullet-bonus-2" )
	add_message_to_scenario_object( mS, "thoughts-bullet-bonus-3" )
	add_message_to_scenario_object( mS, "thoughts-follower-count-bonus" )
	add_message_to_scenario_object( mS, "thoughts-grenade-bonus-1" )
	add_message_to_scenario_object( mS, "thoughts-grenade-bonus-2" )
	add_message_to_scenario_object( mS, "thoughts-inserter-stack-bonus" )
	add_message_to_scenario_object( mS, "thoughts-iron-sticks-gear" )
	add_message_to_scenario_object( mS, "thoughts-mining-prod-bonus" )
	add_message_to_scenario_object( mS, "thoughts-money-multiplier" )
	add_message_to_scenario_object( mS, "thoughts-speed-health-bonus" )
	add_message_to_scenario_object( mS, "thoughts-unlock-bam-2" )
	add_message_to_scenario_object( mS, "thoughts-unlock-capsules" )
	add_message_to_scenario_object( mS, "thoughts-unlock-car" )
	add_message_to_scenario_object( mS, "thoughts-unlock-concrete" )
	add_message_to_scenario_object( mS, "thoughts-unlock-electricity-1" )
	add_message_to_scenario_object( mS, "thoughts-unlock-electricity-2" )
	add_message_to_scenario_object( mS, "thoughts-unlock-fast-inserter" )
	add_message_to_scenario_object( mS, "thoughts-unlock-grenade" )
	add_message_to_scenario_object( mS, "thoughts-unlock-heavy-armor" )
	add_message_to_scenario_object( mS, "thoughts-unlock-piercing-ammo" )
	add_message_to_scenario_object( mS, "thoughts-unlock-red-belt" )
	add_message_to_scenario_object( mS, "thoughts-unlock-refined-concrete" )
	add_message_to_scenario_object( mS, "thoughts-unlock-repair" )
	add_message_to_scenario_object( mS, "thoughts-unlock-smg" )
	add_message_to_scenario_object( mS, "thoughts-unlock-steel-furnace" )
	add_message_to_scenario_object( mS, "thoughts-unlock-sulfur1", 240, "thoughts-unlock-sulfur2" )
	add_message_to_scenario_object( mS, "thoughts-unlock-sulfur2" )
	add_message_to_scenario_object( mS, "thoughts-unlock-turret" )
	add_message_to_scenario_object( mS, "thoughts-unlock-wall" )
	
	--Erase the map:
	game.forces.player.clear_chart()
	
	--Creates a military supply pickup chest at position (0,0) for the player's force.  Makes it indestructible.
	local supplyChest = game.surfaces[ 1 ].create_entity{ name = "military-supply-pickup-chest", position = { 0, 0 }, force = "player" }
	supplyChest.destructible = false
	
	--Creates a military supply dropoff chest at position (2,0) for the player's force.  Makes it indestructible.
	local dropoffChest = game.surfaces[ 1 ].create_entity{ name = "military-supply-dropoff-chest", position = { 2, 0 }, force = "player" }
	dropoffChest.destructible = false
	
	--Make the day 15 minutes long, which is longer than by default.
	game.surfaces[ 1 ].ticks_per_day = 60 * 60 * 15

	
	--Disable all recipes & disable research for all forces.
	for _, force in pairs( game.forces ) do
		force.disable_all_prototypes()
		force.disable_research()
	end
	
	set_next_message_of_scenario_object( mS, 60, "thoughts-initial1" )
end )

script.on_event( defines.events.on_player_created, function( event )
	local player = game.players[ event.player_index ]
	
	create_main_GUI( player )
end )

script.on_event( defines.events.on_tick, function( event )
	update_scenario_object( global.militarySupplyScenario )
end )

script.on_nth_tick( 300, function( event )
	local mS = global.militarySupplyScenario

	--Finds the supply chest at position (0.5,0.5)
	local supplyChest = game.surfaces[ 1 ].find_entity( "military-supply-pickup-chest", { x = 0.5, y = 0.5 })
	
	check_all_goals_of_goals_manager( global.goalManager, supplyChest.get_inventory( defines.inventory.chest ))
	
	--Based on the number of goals completed, display some messages:
	if global.goalManager.goalsCompleted >= 30 then
		display_message_of_scenario_object( mS, "thoughts-receive-secret-mission1" )
	elseif global.goalManager.goalsCompleted >= 25 then
		display_message_of_scenario_object( mS, "thoughts-25-goals" )
	elseif global.goalManager.goalsCompleted >= 20 then
		display_message_of_scenario_object( mS, "thoughts-news-20-goals" )
	elseif global.goalManager.goalsCompleted >= 15 then
		display_message_of_scenario_object( mS, "thoughts-news-15-goals1" )
	elseif global.goalManager.goalsCompleted >= 10 then
		display_message_of_scenario_object( mS, "thoughts-hint-at-mission" )
	elseif global.goalManager.goalsCompleted >= 5 then
		display_message_of_scenario_object( mS, "thoughts-news-5-goals" )
	end
	
	if get_goal_count_of_goals_manager( global.goalManager ) < 7 then
		make_random_goal()
	end
	
	update_scores()
		
	if supplyChest.get_inventory( defines.inventory.chest ).get_item_count( "military-supply-eternity-ray" ) > 0 then
		--Well, look at that!  You won!
		for _, v in pairs( game.players ) do
			v.set_ending_screen_data{ "military-supply-scenario-score.final-score", string.format( "%.3f", global.scoreManager.finalScore )}
		end
		game.set_game_state{ game_finished = true, player_won = true, can_continue = false }
	end
	for _, player in pairs( game.players ) do
		update_goals_GUI( player )
		update_shop_GUI( player )
	end
end )

--Perform clock actions every second:
script.on_nth_tick( 60, function( event )
	local mS = global.militarySupplyScenario
	if mS.secondsLeft > 0 then
		mS.secondsLeft = mS.secondsLeft - 1
	end
	
	--Fill the dropoff chest invenory:
	--We want 50 sulfur & 50 zarnium crystals in it exactly, but only add them when the player has unlocked them.
	--We use game.forces[ 1 ] as a proxy for any given force or player having unlocked them.
	local chestInventory = game.surfaces[ 1 ].find_entity( "military-supply-dropoff-chest", { x = 2.5, y = 0.5 }).get_inventory( defines.inventory.chest )
	if mS.sulfurUnlocked then
		local sulfurCount = chestInventory.get_item_count( "sulfur" )
		if sulfurCount > 50 then
			chestInventory.remove{ name = "sulfur", count = sulfurCount - 50 }
		elseif sulfurCount < 50 then
			chestInventory.insert{ name = "sulfur", count = 50 - sulfurCount }
		end
	end
	if mS.zarniumUnlocked then
		local zarniumCount = chestInventory.get_item_count( "military-supply-zarnium-crystal" )
		if zarniumCount > 50 then
			chestInventory.remove{ name = "military-supply-zarnium-crystal", count = zarniumCount - 50 }
		elseif zarniumCount < 50 then
			chestInventory.insert{ name = "military-supply-zarnium-crystal", count = 50 - zarniumCount }
		end
	end
	
	--Area to scan to see if any player is close enough to a script trigger:
	local triggerBox = game.surfaces[ 1 ].get_script_areas( "Shipwreck" )[ 1 ].area
		
	for _, player in pairs( game.players ) do
		--While we're looping through all players, we might as well:
		update_scenario_timer( player )

		--local scanArea = {{ player.position.x - 48, player.position.y - 48 }, { player.position.x + 48, player.position.y + 48 }}
	
		--Also check to see if a trigger for a scenario message has been met:
		if not get_was_message_shown_of_scenario_object( mS, "thoughts-find-shipwreck" ) then
			--Scan an area for the shipwrecks.  If we find it, display the character's thoughts:
			--local nearbyShipwrecks = player.surface.find_entities_filtered{ area = scanBox, name = { "big-ship-wreck-1", "big-ship-wreck-2", "big-ship-wreck-3" }}
			--if nearbyShipwrecks then
			--	if #nearbyShipwrecks > 0 then
			--		mS:display_message( "thoughts-find-shipwreck" )
			--	end
			--end
			
			--No, no no no.  Instead, we see if the player is in the triggerBox:
			if player.position.x >= triggerBox.left_top.x and player.position.x < triggerBox.right_bottom.x and player.position.y >= triggerBox.left_top.y and player.position.y < triggerBox.right_bottom.y then
				display_message_of_scenario_object( mS, "thoughts-find-shipwreck" )
			end
		end
	end
	
	update_scores()
	
	if mS.secondsLeft <= 0 then
		--If you run out of time, you lose.
		game.set_game_state{ game_finished = true, player_won = false, can_continue = false }
	end
end )

script.on_event( defines.events.on_gui_click, function( event )
	--Create some local variables:\
	local player = game.players[ event.player_index ]
	local name = event.element.name
	if name == BUTTON_TO_TOGGLE_GOALS_GUI then
		if get_is_goals_GUI_open( player ) then
			hide_goals_GUI( player )
		else
			show_goals_GUI( player )
		end
	elseif name == BUTTON_TO_TOGGLE_SHOP_GUI then
		if get_is_shop_GUI_open( player ) then
			hide_shop_GUI( player )
		else
			show_shop_GUI( player )
		end
	elseif name == BUTTON_TO_TOGGLE_SCORE_GUI then
		if get_is_score_GUI_open( player ) then
			hide_score_GUI( player )
		else
			show_score_GUI( player )
		end
	elseif name == CLOSE_BUTTON_FOR_SCORING_GUI then
		hide_score_GUI( player )
	elseif name == CLOSE_BUTTON_FOR_SHOP_GUI then
		hide_shop_GUI( player )
	elseif name == BUTTON_TO_OPEN_STARTER_PACKAGE_GUI then
		create_starter_package_GUI( player )
	elseif name == CLOSE_BUTTON_FOR_STARTER_PACKAGE_GUI then
		destroy_starter_package_GUI( player )
	elseif name == BUTTON_TO_DESELECT_STARTER_PACKAGE then
		choose_starter_package( player, nil )
	elseif name == BUTTON_TO_SELECT_LOGISTICS_STARTER_PACKAGE then
		choose_starter_package( player, "logistics" )
	elseif name == BUTTON_TO_SELECT_PRODUCTION_STARTER_PACKAGE then
		choose_starter_package( player, "production" )
	elseif name == BUTTON_TO_SELECT_COMBAT_STARTER_PACKAGE then
		choose_starter_package( player, "combat" )
	elseif name == BUTTON_TO_CONFIRM_STARTER_PACKAGE then
		receive_starter_package( player, get_which_starter_package_is_chosen( player ))
	--If it was an upgrade in the shop, check to see if it has the correct prefix:
	elseif string.sub( name, 1, 15 ) == "upgrades-button" then
		--Then take away the prefix to find the name of the upgrade, and purchase it:
		purchase_upgrade_of_scenario_object( global.militarySupplyScenario, string.sub( name, 16, -1 ))
		
		update_scores()
		for _, anyPlayer in pairs( game.players ) do
			update_shop_GUI( anyPlayer )
		end
	end
end )

--When the player uses the input to close a GUI, actually hide that GUI onscreen.
script.on_event( defines.events.on_gui_closed, function( event )
	local element = event.element
	local player = game.players[ event.player_index ]
	if not element then
		return
	end
	if element.name == SHOP_GUI_TOP_LEVEL_NAME then
		hide_shop_GUI( player )
	elseif element.name == SCORING_GUI_TOP_LEVEL_NAME then
		hide_score_GUI( player )
	elseif element.name == STARTER_PACKAGE_GUI_TOP_LEVEL_NAME then
		destroy_starter_package_GUI( player )
	end
end )

script.on_event( defines.events.on_entity_died, function( event )
	local entity = event.entity
	
	if entity.name == "small-biter" then
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-killed-biters" )
	end
	if entity.name == "biter-spawner" or entity.name == "spitter-spawner" then
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-killed-spawner1" )
	end
end )

script.on_event( defines.events.on_player_died, function( event )
	local mS = global.militarySupplyScenario
	
	--If you die, it's a 1-hour penalty to the time limit.
	mS.secondsLeft = mS.secondsLeft - 60 * 60
	mS.playerDeaths = mS.playerDeaths + 1
	update_scores()
	
	if mS.secondsLeft <= 0 then
		--If you run out of time, you lose.
		game.set_game_state{ game_finished = true, player_won = false, can_continue = false }
	end
	
	--Since the time limit changed, reflect that instantly for all players:
	for _, player in pairs( game.players ) do
		update_scenario_timer( player )
		update_scenario_deaths( player )
	end
end )

--The character will have a comment to make about respawning.
script.on_event( defines.events.on_player_respawned, function( event )
	display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-player-died" )
end )

script.on_event( defines.events.on_built_entity, function( event )
	local entity = event.created_entity

	if entity.name == "gun-turret" then
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-built-turret" )
	end
	if entity.name == "stone-wall" then
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-built-wall" )
	end	
end )

--Utility function used only for debugging.
--I'll leave it in the release version since it has no effect on gameplay whatsoever.
--WARNING: this function pollutes the log file when called.
print_goalItemTable = function()
	game.print( "global.goalItemTable is a table with "..table_size( global.goalItemTable ).." elements.  See the log file for details." )
	log( "global.goalItemTable is a table with "..table_size( global.goalItemTable ).." elements: "..serpent.block( global.goalItemTable ))
end