--Goals_lib.lua
--This file contains functions related to creation and completion of goals in my scenario, MilitarySupply.
--This file was coded by Q.

function make_random_goal()
	--Skip everything if there are no accepted items:
	if #global.goalItemTable == 0 then
		return
	end
	--Else, there is at least 1 item we can use:
	local itemTable = global.goalItemTable[ math.random( #global.goalItemTable )]
	--Else, there is at least 1 item, & the one we are using is valid.
	local itemName = itemTable[ 1 ]
	if game.players[ 1 ].force.recipes[ itemName ].enabled == false then
		--The recipe isn't unlocked, so skip it!
		return
	end
	local amount = math.random( itemTable[ 3 ] )
	local moneyValue = math.floor( itemTable[ 2 ] * amount )
	
	--Now check: make sure that the goal manager does not already have a goal of this type:
	for k, goal in pairs( global.goalManager.allGoals ) do
		if goal.item == itemName then
			--There's already a goal of this type, so skip it.
			return
		end
	end
	--Else, this goal is unique.  Add it!
	add_goal_to_goals_manager( global.goalManager, itemName, amount, moneyValue )
end

--Call this function to check if an inventory has the items necessary to satisfy the goal in question (and executes completion reward if so)
--It assumes its parameters are valid
--Returns:
--	true  - if the goal was completed and the reward function executed
--	false - if the goal was not met
function check_goal_completed( goal, LuaInventory )
	if LuaInventory.get_item_count( goal.item ) >= goal.count then
		local mS = global.militarySupplyScenario
		local gMan = global.goalManager
		local basePrice = goal.moneyValue
		local price = basePrice * mS.moneyMultiplier
		--Goal met!
		--Give the player their reward:
		mS.money = mS.money + price
		--Remove goal items from inventory:
		LuaInventory.remove{ name = goal.item, count = goal.count }
		
		gMan.baseMoneyThisTick = gMan.baseMoneyThisTick + basePrice
		gMan.moneyThisTick = gMan.moneyThisTick + price
		return true
	end
	--Else:
	return false
end

--This function will add a goal to a table with 3 columns
--Pass it a goal & a LuaGuiElement table
--Returns nothing
function add_goal_to_table( goal, guiTable )
	local multi = global.militarySupplyScenario.moneyMultiplier
	
	guiTable.add{ type = "label", name = goal.ID.."-item", caption = game.item_prototypes[ goal.item ].localised_name }
	guiTable.add{ type = "label", name = goal.ID.."-count", caption = goal.count }
	if multi > 1 then
		guiTable.add{ type = "label", name = goal.ID.."-reward", caption = { "military-supply-scenario-goals-GUI.money-value-with-bonus", goal.moneyValue, multi, goal.moneyValue * multi }}
	else
		guiTable.add{ type = "label", name = goal.ID.."-reward", caption = { "military-supply-scenario-goals-GUI.money-value", goal.moneyValue }}
	end
end

--Call this function to create an object that will manage goals automatically.
--Return value:
--	Success: table representing the manager
--How to use:
--	Call this function and store the resulting object
--	Call the manager's update function once every few seconds or so
--Members:
--	goalsCompleted	- The number of goals completed
--Functions:
--	add_goal( goal )	- Adds a goal to the list
--	check_all_goals( LuaInventory )	- Iterates through all goals and if any are completed, executes its completion reward, removing any completed goals
--	add_goals_to_table( guiTable )	- Adds all goals to a table in a gui
function create_goals_manager()
	--moneyThisTick is the amount of money added in this tick.  Used to create a message for the player when a goal is completed to show the money earned.
	--baseMoneyThisTick is the amount of money added, not counting the goal rewards multiplier
	--Since Factorio no longer supports storing functions in savegames, this object has no member functions.
	return { allGoals = {}, goalsCompleted = 0, moneyThisTick = 0, baseMoneyThisTick = 0 }
end

--This function creates a goal object with the parameters you supply:
--	item		- string, representing type of item needed
--	count	- number, representing amount of item needed
--	moneyValue- number, represents the amount of money rewarded upon completion
add_goal_to_goals_manager = function( m, item, count, moneyValue )
	local newGoal = {}
	if type( item ) == "string" then
		newGoal.item = item
	else
		error( "Creation of the goal failed because 1st parameter was invalid!" )
	end
	if type( count ) == "number" and count > 0 then
		newGoal.count = count
	else
		error( "Creation of the goal failed because 2nd parameter was invalid!" )
	end
	--The goal ID is made by taking the item's internal name & concatenating the amount:
	newGoal.ID = item..count
	if type( moneyValue ) == "number" and moneyValue > 0 then
		newGoal.moneyValue = moneyValue
	else
		error( "Creation of the goal failed because 4th parameter was invalid!" )
	end
	
	table.insert( m.allGoals, newGoal )
end
get_goal_count_of_goals_manager = function( m )
	return #m.allGoals
end
check_all_goals_of_goals_manager = function( m, LuaInventory )
	local indicesToRemove = {}
	local offset = 0
	
	m.moneyThisTick = 0
	m.baseMoneyThisTick = 0
	for k, v in ipairs( m.allGoals ) do
		if check_goal_completed( v, LuaInventory ) then
			m.goalsCompleted = m.goalsCompleted + 1
			table.insert( indicesToRemove, k )
		end
	end
	
	for k, v in ipairs( indicesToRemove ) do
		table.remove( m.allGoals, v - offset )
		offset = offset + 1
	end
	
	--Now tell the player how much money was earned:
	if m.moneyThisTick > 0 then
		--Contains a LocalisedString of what it will say:
		local flyingTextStr = {}
		
		if global.militarySupplyScenario.moneyMultiplier > 1 then
			flyingTextStr = { "military-supply-scenario-goals-GUI.money-value-with-bonus", m.baseMoneyThisTick, global.militarySupplyScenario.moneyMultiplier, m.moneyThisTick }
		else
			flyingTextStr = { "military-supply-scenario-goals-GUI.money-value", m.moneyThisTick }
		end
			
		game.surfaces[ 1 ].create_entity{ name = "flying-text", position = { 0, 0 }, text = flyingTextStr, color = { r = 0, g = 1, b = 0 }}
	end
	m.moneyThisTick = 0
	m.baseMoneyThisTick = 0
end
add_goals_to_table_of_goals_manager = function( m, guiTable )
	for k, v in ipairs( m.allGoals ) do
		add_goal_to_table( v, guiTable )
	end
end