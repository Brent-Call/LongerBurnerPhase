--The code in each of these functions acts on each specific force & player, so it should be multiplayer-safe.

local TICKS_PER_HOUR = 216000 --Number of game ticks per hour of real time.

--This function accepts a table with a list of recipes, & it enables those recipes for ALL forces.
--This is designed to be safe to use with other mods, so if a recipe doesn't exist,
--this function skips that recipe instead of causing an error.
--@param arrayOfRecipes	A table where the values are the names of recipe prototypes.
--					In this implementation, the keys of the table don't matter.
--					If the recipe with the requested name doesn't exist, silently skips that entry.
--@return nil
function enable_recipes_for_all( arrayOfRecipes )
	for _, force in pairs( game.forces ) do
		local recipes = force.recipes
		for _, recipeName in pairs( arrayOfRecipes ) do
			local theRecipe = recipes[ recipeName ]
			if theRecipe then
				if not theRecipe.enabled then
					theRecipe.enabled = true
				end
			end
		end
	end
end

--This function accepts a table with a list of recipes, & it disables those recipes for ALL forces.
--This is designed to be safe to use with other mods, so if a recipe doesn't exist,
--this function skips that recipe instead of causing an error.
--@param arrayOfRecipes	A table where the values are the names of recipe prototypes.
--					In this implementation, the keys of the table don't matter.
--					If the recipe with the requested name doesn't exist, silently skips that entry.
--@return nil
function disable_recipes_for_all( arrayOfRecipes )
	for _, force in pairs( game.forces ) do
		local recipes = force.recipes
		for _, recipeName in pairs( arrayOfRecipes ) do
			local theRecipe = recipes[ recipeName ]
			if theRecipe then
				if theRecipe.enabled then
					theRecipe.enabled = false
				end
			end
		end
	end
end

function initial_resources()
	local addTorches = game.active_mods[ "Torches" ] ~= nil
	for _, player in pairs( game.players ) do
		player.insert({ name = "iron-plate", count = 300 })
		player.insert({ name = "copper-plate", count = 100 })
		player.insert({ name = "stone-furnace", count = 10 })
		player.insert({ name = "burner-mining-drill", count = 10 })
		player.insert({ name = "solid-fuel", count = 50 })
		if addTorches then
			player.insert({ name = "torch", count = 20 })
		end
	end
end
	
function initial_recipes()
	local addTorches = game.active_mods[ "Torches" ] ~= nil
	add_goal_item( "pistol", 3.75, 5, 20 )
	add_goal_item( "firearm-magazine", 2, 40, 400 )
	enable_recipes_for_all({ 
		--Logistics recipes:
		"iron-chest", "steel-chest", "transport-belt", "underground-belt", "splitter", "burner-inserter",
		--Production recipes:
		"burner-mining-drill", "stone-furnace", "burner-assembling-machine-1",
		--Intermediate product recipes:
		"iron-plate", "copper-plate", "steel-plate", "iron-stick", "iron-gear-wheel", "stone-brick",
		--Combat recipes:
		"pistol", "firearm-magazine" })
	if addTorches then
		--This is for 2 reasons: firstly, so that torches can be remade once mined,
		--& secondly, so that torches appear in the list of unlocked items.
		enable_recipes_for_all({ "torch" })
	end
	for _, player in pairs( game.players ) do
		update_main_GUI_for_scenario( player )
	end	
end

function initial_upgrades()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "smg", "item/submachine-gun", 50 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "piercing-ammo", "item/piercing-rounds-magazine", 150 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "wall", "item/stone-wall", 175 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "bam-2", "item/burner-assembling-machine-2", 250 )
end

function on_find_shipwreck()
	--There are 200 Military Science Packs inside one of the wrecked ships...
	--Maybe you could turn those in for $800?
	add_goal_to_goals_manager( global.goalManager, "military-science-pack", 200, 800 )
	for _, player in pairs( game.players ) do
		update_goals_GUI( player )
	end
end

function unlock_eternity_ray()
	enable_recipes_for_all({	"military-supply-eternity-ray-structure",
						"military-supply-eternity-ray-power-core",
						"military-supply-eternity-ray-emitter",
						"military-supply-eternity-ray" })
	for _, player in pairs( game.players ) do
		--Now it will say that to win, the player must build the ETERNITY RAY.
		update_main_GUI_for_final_objective( player )
	end
	--Tell the scenario object to add zarnium crystals to the SUPPLY DROPOFF CHEST:
	global.militarySupplyScenario.zarniumUnlocked = true
	if not global.dropoffChest or not global.dropoffChest.valid then
		error( "The dropoff chest became invalid somehow." )
	end
	global.dropoffChest.set_infinity_container_filter( 2, { name = "military-supply-zarnium-crystal", count = 50, mode = "exactly" })
end

function on_killed_spawner()
	for _, force in pairs( game.forces ) do
		--Provide a 20% bonus to gun turrets:
		force.set_turret_attack_modifier( "gun-turret", force.get_turret_attack_modifier( "gun-turret" ) + 0.2 )
	end
end

function upgrades_after_concrete()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "refined-concrete", "item/refined-concrete", 600 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "sulfur", "item/sulfur", 700 )
end

function upgrades_after_wall()	
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "repair", "item/repair-pack", 75 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "heavy-armor", "item/heavy-armor", 550 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "concrete", "item/concrete", 275 )
end

function upgrades_after_repair()	
	--The one upgrade that had repair packs as a prerequisite, "concrete", was moved elsewhere.
end

function upgrades_after_bam2()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "steel-furnace", "item/steel-furnace", 325 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "speed-health", "entity/character", 250 )
end

function upgrades_after_furnace()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "electricity-1", "item/steam-engine", 500 )
end

function upgrades_after_speed_health()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "money-bonus", "item/coin", 1000 )
end

function upgrades_after_car()
	--If the mod Iron Sticks Gear is active, add an upgrade to unlock the recipe from that mod.
	if game.recipe_prototypes[ "advanced-iron-gear-wheel" ] then
		--The mod Iron Sticks Gear is active!
		add_upgrade_to_scenario_object( global.militarySupplyScenario, "iron-sticks-gear", "item/iron-stick", 600 )
	end
end

function upgrades_after_electricity_1()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "electricity-2", "item/assembling-machine-1", 525 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "fast-inserter", "item/fast-inserter", 600 )
end

function upgrades_after_capsules()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "follower-count-bonus", "item/defender-capsule", 475 )
end

function upgrades_after_electricity_2()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "fast-belts", "item/fast-transport-belt", 1000 )
end

function upgrades_after_fast_belts()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "mining-prod-1", "item/electric-mining-drill", 800 )
end

function upgrades_after_mining_1()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "mining-prod-2", "item/electric-mining-drill", 2000 )
end

function upgrades_after_fast_inserter()
	--If Q's Cable-Making Mod is active, add an upgrade to unlock a better recipe:
	if game.recipe_prototypes[ "advanced-cable1" ] then
		add_upgrade_to_scenario_object( global.militarySupplyScenario, "better-cable-making", "recipe/advanced-cable1", 750 )
	end
end


function upgrades_after_piercing_ammo()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "grenade", "item/grenade", 275  )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "car", "item/car", 475 )
end

function upgrades_after_grenade()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "grenade-bonus-1", "item/grenade", 375 )
end

function upgrades_after_grenade_bonus_1()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "grenade-bonus-2", "item/grenade", 575 )
end

function upgrades_after_smg()	
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "turret", "item/gun-turret", 200 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "bullet-bonus-1", "item/firearm-magazine", 300 )
end


function upgrades_after_turret()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "capsules", "item/poison-capsule", 350 )
end

function upgrades_after_bullet_1()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "inserter-stack-bonus", "item/stack-inserter", 275 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "bullet-bonus-2", "item/firearm-magazine", 575 )
end

function upgrades_after_bullet_2()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "bullet-bonus-3", "item/firearm-magazine", 700 )
end

function starter_bonus_GUI()
	for _, player in pairs( game.players ) do
		update_main_GUI_for_starter_bonus( player )
	end
end

--This function updates the player score & all open score GUIs:
function update_scores()
	calculate_score_manager_object( global.scoreManager )
	for _, player in pairs( game.players ) do
		update_score_GUI( player )
	end
end

messageAssociatedFunctions =
{
	msg_initial_upgrades = initial_upgrades,
	msg_initial_resources = initial_resources,
	msg_starter_bonus_GUI = starter_bonus_GUI,
	msg_initial_recipes = initial_recipes,
	msg_on_find_shipwreck = on_find_shipwreck,
	msg_on_killed_spawner = on_killed_spawner,
	msg_unlock_eternity_ray = unlock_eternity_ray
}
upgradeAssociatedFunctions =
{
	smg = function()
		enable_recipes_for_all({ "submachine-gun" })
		add_goal_item( "submachine-gun", 16.25, 5, 20 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-smg" )
		upgrades_after_smg()
	end,
	[ "piercing-ammo" ] = function()
		enable_recipes_for_all({ "piercing-rounds-magazine" })
		add_goal_item( "piercing-rounds-magazine", 4.5, 40, 400 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-piercing-ammo" )
		upgrades_after_piercing_ammo()
	end,
	wall = function()
		enable_recipes_for_all({ "stone-wall", "gate" })
		add_goal_item( "stone-wall", 3.75, 20, 200 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-wall" )
		upgrades_after_wall()
	end,
	[ "bam-2" ] = function()
		--(Pipes are unlocked because they are required to craft engine units.)
		enable_recipes_for_all({ "engine-unit", "pipe", "burner-assembling-machine-2" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-bam-2" )
		upgrades_after_bam2()
	end,
	sulfur = function()
		enable_recipes_for_all({ "burner-chemical-plant", "sulfuric-acid", "battery",
			--This dummy recipe doesn't show up in crafting menus, but it does make sulfur appear in
			--listings of all unlocked items.
			"military-supply-dummy-enable-sulfur" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-sulfur1" )
		--Tell the scenario object to add sulfur to the SUPPLY DROPOFF CHEST:
		global.militarySupplyScenario.sulfurUnlocked = true
		if not global.dropoffChest or not global.dropoffChest.valid then
			error( "The dropoff chest became invalid somehow." )
		end
		global.dropoffChest.set_infinity_container_filter( 1, { name = "sulfur", count = 50, mode = "exactly" })
	end,
	repair = function()
		enable_recipes_for_all({ "military-supply-repair-pack" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-repair" )
		upgrades_after_repair()
	end,
	concrete = function()
		enable_recipes_for_all({ "concrete", "hazard-concrete",
			--Concrete needs water to craft.  Just in case the player doesn't have water, unlock stuff to get it:
			"pipe", "pipe-to-ground", "offshore-pump",
			--Item from a mod:
			"burner-offshore-pump" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-concrete" )
		upgrades_after_concrete()
	end,
	[ "refined-concrete" ] = function()
		enable_recipes_for_all({ "military-supply-refined-concrete", "refined-hazard-concrete" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-refined-concrete" )
	end,
	[ "steel-furnace" ] = function()
		enable_recipes_for_all({ "steel-furnace" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-steel-furnace" )
		upgrades_after_furnace()
	end,
	[ "speed-health" ] = function()
		for _, force in pairs( game.forces ) do
			force.character_running_speed_modifier = force.character_running_speed_modifier + 0.5
			force.character_health_bonus = force.character_health_bonus + 75
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-speed-health-bonus" )
		upgrades_after_speed_health()
	end,
	[ "electricity-1" ] = function()
		--Note: the "pipe" recipe will already be enabled because it is included in one of this upgrade's prerequisites.
		enable_recipes_for_all({ "pipe-to-ground", "boiler", "steam-engine", "offshore-pump",
			--Item from a mod:
			"burner-offshore-pump",
			"medium-electric-pole", "small-lamp", "inserter", "copper-cable", "electronic-circuit" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-electricity-1" )
		upgrades_after_electricity_1()
	end,
	[ "money-bonus" ] = function()
		--Provides a *2 bonus to money from goals & a *2 bonus to score
		global.militarySupplyScenario.moneyMultiplier = global.militarySupplyScenario.moneyMultiplier * 2
		global.militarySupplyScenario.scoreMultiplier = global.militarySupplyScenario.scoreMultiplier * 2
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-money-multiplier" )
		update_scores()
		for _, player in pairs( game.players ) do
			update_goals_GUI( player )
		end
	end,
	[ "iron-sticks-gear" ] = function()
		enable_recipes_for_all({ "advanced-iron-gear-wheel" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-iron-sticks-gear" )
	end,
	[ "electricity-2" ] = function()
		enable_recipes_for_all({ "assembling-machine-1", "big-electric-pole", "electric-mining-drill", "radar" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-electricity-2" )
		upgrades_after_electricity_2()
	end,
	[ "fast-inserter" ] = function()
		enable_recipes_for_all({ "fast-inserter", "filter-inserter", "uncraft-burner-inserters" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-fast-inserter" )
		upgrades_after_fast_inserter()
	end,
	[ "follower-count-bonus" ] = function()
		for _, force in pairs( game.forces ) do
			force.maximum_following_robot_count = force.maximum_following_robot_count + 10
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-follower-count-bonus" )
	end,
	[ "fast-belts" ] = function()
		enable_recipes_for_all({ "fast-transport-belt", "fast-underground-belt", "fast-splitter" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-red-belt" )
		upgrades_after_fast_belts()
	end,
	[ "mining-prod-1" ] = function()
		for _, force in pairs( game.forces ) do
			--Adds 4% mining productivity.
			force.mining_drill_productivity_bonus = force.mining_drill_productivity_bonus + 0.04
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-mining-prod-bonus-1" )
		upgrades_after_mining_1()
	end,
	[ "mining-prod-2" ] = function()
		for _, force in pairs( game.forces ) do
			--Adds 6% mining productivity.
			force.mining_drill_productivity_bonus = force.mining_drill_productivity_bonus + 0.06
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-mining-prod-bonus-2" )
	end,
	[ "better-cable-making" ] = function()
		enable_recipes_for_all({ "advanced-cable1" })
		disable_recipes_for_all({ "copper-cable" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-better-cable-making" )
	end,
	[ "heavy-armor" ] = function()
		enable_recipes_for_all({ "heavy-armor" })
		add_goal_item( "heavy-armor", 87.5, 2, 5 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-heavy-armor" )
	end,
	grenade = function()
		enable_recipes_for_all({ "grenade" })
		add_goal_item( "grenade", 5, 20, 200 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-grenade" )
		upgrades_after_grenade()
	end,
	car = function()
		enable_recipes_for_all({ "car" })
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-car" )
		upgrades_after_car()
	end,
	[ "grenade-bonus-1" ] = function()
		for _, force in pairs( game.forces ) do
			force.set_ammo_damage_modifier( "grenade", force.get_ammo_damage_modifier( "grenade" ) + 0.25 )
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-grenade-bonus-1" )
		upgrades_after_grenade_bonus_1()
	end,
	[ "grenade-bonus-2" ] = function()
		for _, force in pairs( game.forces ) do
			force.set_ammo_damage_modifier( "grenade", force.get_ammo_damage_modifier( "grenade" ) + 0.35 )
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-grenade-bonus-2" )
	end,
	turret = function()
		enable_recipes_for_all({ "gun-turret" })
		--Purchasing the turret renders the old pistol obsolete.
		--(In truth, it was obsolete the moment we got the SMG, but now they will no longer be accepted as goal items.)
		remove_goal_item( "pistol" )
		add_goal_item( "gun-turret", 22.5, 15, 100 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-turret" )
		
		--Set to display the "pistol obsolete" message in a short while:
		set_next_message_of_scenario_object( global.militarySupplyScenario, 60, "thoughts-pistol-obsolete" )
		
		upgrades_after_turret()
	end,
	[ "bullet-bonus-1" ] = function()
		for _, force in pairs( game.forces ) do
			force.set_ammo_damage_modifier( "bullet", force.get_ammo_damage_modifier( "bullet" ) + 0.15 )
			force.set_gun_speed_modifier( "bullet", force.get_gun_speed_modifier( "bullet" ) + 0.1 )
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-bullet-bonus-1" )
		upgrades_after_bullet_1()
	end,
	capsules = function()
		enable_recipes_for_all({ "poison-capsule", "defender-capsule" })
		--Allow 5 followers right from the start:
		for _, force in pairs( game.forces ) do
			force.maximum_following_robot_count = 5
		end
		add_goal_item( "poison-capsule", 7.5, 10, 200 )
		add_goal_item( "defender-capsule", 9.25, 10, 50 )
		remove_goal_item( "firearm-magazine" )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-capsules" )
		upgrades_after_capsules()
	end,
	[ "inserter-stack-bonus" ] = function()
		for _, force in pairs( game.forces ) do
			--The bonus is +2 to inserter stack size
			force.inserter_stack_size_bonus = force.inserter_stack_size_bonus + 2
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-inserter-stack-bonus" )
	end,
	[ "bullet-bonus-2" ] = function()
		for _, force in pairs( game.forces ) do
			force.set_ammo_damage_modifier( "bullet", force.get_ammo_damage_modifier( "bullet" ) + 0.25 )
			force.set_gun_speed_modifier( "bullet", force.get_gun_speed_modifier( "bullet" ) + 0.15 )
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-bullet-bonus-2" )
		upgrades_after_bullet_2()
	end,
	[ "bullet-bonus-3" ] = function()
		for _, force in pairs( game.forces ) do
			force.set_ammo_damage_modifier( "bullet", force.get_ammo_damage_modifier( "bullet" ) + 0.35 )
			force.set_gun_speed_modifier( "bullet", force.get_gun_speed_modifier( "bullet" ) + 0.25 )
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-bullet-bonus-3" )
	end
}

--Sets the seed for the Lua random number generator based on some information.
--@param package	A number.  Technically it doesn't matter, but customarily we use
--				a value corresponding to the starter package that was chosen.
--@param player	A LuaPlayer object.  The player's data, along with some global game
--				data, will be used to calculate the seed using a mathematical function.
function seed_RNG( package, player )
	math.randomseed( game.tick + package * 599 +
		player.position.x * 8819 + ( player.position.y ^ 2 ) * 13921 )
end

--Creates the table of all data related to starter packages, overwriting whatever was in global.starterPackages in the process.
--Call this once, at the beginning of the scenario.
--global.starterPackages is an array of starter package data structures.
--A starter package data structure has the following fields:
--	localisedName -- LocalisedString.  Displayed as the name of the starter package.
--	messageWhenChosen -- LocalisedString.  Printed to the console when the starter package is chosen.
--	isChallenge -- Boolean.  If true, the GUI warns the player that this starter package is more difficult than normal.
--	sprite -- SpritePath.  Image associated with this starter package.
--	contents -- Table.  Array of the starter package item data structures.
--A starter package item data structure has the following fields:
--	type -- String.  Determines the behavior of this entry.  The types are:
--			"item" -- When the starter package is chosen, the item will go into the character's inventory.
--					If the item in question is the hardcoded value "construction-robot" then the last slot
--					in the character's inventory will have its filter set to be that item.
--			"crafting-speed-modifier" -- The player who chose this will get a bonus to manual crafting speed.
--							The bonus wears off when they die.
--			"armor-with-shield" -- When the starter package is chosen, the player will get armor with
--							plenty of useful equipment in their equipment grid.  This is all predefined.
--			"armor-with-roboport" -- Same as above, except the equipment loadout is different.
--			"force-map-chart" -- When the starter package is chosen, the player's force will chart an area of the map.
--							The surface charted will be the surface the player is currently located on.
--			"money-multiplier" -- Grants a global multiplier to goal reward.
--			"score-multiplier" -- Grants a global multiplier to score.
--			"richness-penalty" -- Reduces the richness of all resources on the map.
--			"worker-robots-speed-modifier" -- When the starter package is chosen, the player's force gets
--							a modifier to the movement speed of their construction & logistic robots.
--			"manual-mining-speed-penalty" -- The player who chose this will get a penalty to manual mining speed.
--							The bonus wears off when they die.
--			"ghost-rebuild-timeout" -- When the starter package is chosen, the pleyer's force gets a bonus
--							where their entities that die create ghosts that last for a while.
--	item -- String.  Name of the item prototype to use.  Used if type is "item".
--	count -- Number.  Amount of items given.  Used if type is "item".
--	modifier -- Number.  Amount of modifier to give.  Used if type is "crafting-speed-modifier", "worker-robots-speed-modifier",
--			or "manual-mining-speed-penalty".
--	area -- BoundingBox.  Area of the world to be charted.  Used if type is "force-map-chart".
--	multiplier -- Number.  Amount to multiply by.  Used if type is "money-multiplier" or "score-multiplier".
--	multipliers -- Table.  Amount to multiply each resource amount by.  Used if type is "richness-penalty".
--						The keys of this table are the prototype names of resources & the values are numbers.
--						Additionally, there is one special mandatory key: "other", used as a default value.
--	hoursToTimeout -- Number.  Number of hours that entity ghosts remain after death.  Used if type is "ghost-rebuild-timeout".
function initialize_starter_packages()
	global.starterPackages =
	{
		--Logistics starter package:
		{
			localisedName = { "military-supply-scenario-gui.starter-package-logistics" },
			messageWhenChosen = { "military-supply-scenario-thoughts.thoughts-choose-logistics" },
			isChallenge = false,
			sprite = "item-group/logistics",
			contents =
			{
				{ type = "item", item = "transport-belt", count = 100 },
				{ type = "item", item = "underground-belt", count = 10 },
				{ type = "item", item = "splitter", count = 10 },
				{ type = "item", item = "burner-inserter", count = 25 },
				{ type = "item", item = "steel-chest", count = 10 }
			}
		},
		--Production starter package:
		{
			localisedName = { "military-supply-scenario-gui.starter-package-production" },
			messageWhenChosen = { "military-supply-scenario-thoughts.thoughts-choose-production" },
			isChallenge = false,
			sprite = "item-group/production",
			contents =
			{
				{ type = "item", item = "burner-assembling-machine-1", count = 5 },
				{ type = "item", item = "burner-mining-drill", count = 10 },
				{ type = "item", item = "stone-furnace", count = 40 },
				{ type = "item", item = "burner-inserter", count = 10 },
				{ type = "crafting-speed-modifier", modifier = 0.5 }
			}
		},
		--Combat starter package:
		{
			localisedName = { "military-supply-scenario-gui.starter-package-combat" },
			messageWhenChosen = { "military-supply-scenario-thoughts.thoughts-choose-combat" },
			isChallenge = false,
			sprite = "item-group/combat",
			contents =
			{
				{ type = "item", item = "uranium-rounds-magazine", count = 200 },
				{ type = "item", item = "grenade", count = 20 },
				{ type = "item", item = "stone-wall", count = 100 },
				{ type = "armor-with-shield" },
				{ type = "force-map-chart", area = {{ -400, -400 }, { 200, 200 }}}
			}
		},
		--Builder's starter package:
		{
			localisedName = { "military-supply-scenario-gui.starter-package-builder" },
			messageWhenChosen = { "military-supply-scenario-thoughts.thoughts-choose-builder" },
			isChallenge = false,
			sprite = "item/personal-roboport-mk2-equipment",
			contents =
			{
				{ type = "armor-with-roboport" },
				{ type = "item", item = "construction-robot", count = 25 },
				{ type = "worker-robots-speed-modifier", modifier = 1.8 },
				{ type = "manual-mining-speed-penalty", modifier = -0.5 },
				{ type = "ghost-rebuild-timeout", hoursToTimeout = 6 }
			}
		},
		--Richness challenge starter package:
		{
			localisedName = { "military-supply-scenario-gui.starter-package-richness-challenge" },
			messageWhenChosen = { "military-supply-scenario-thoughts.thoughts-choose-richness-challenge" },
			isChallenge = true,
			sprite = "utility/questionmark",
			contents =
			{
				{ type = "item", item = "advanced-burner-mining-drill", count = 2 },
				{ type = "item", item = "steel-furnace", count = 10 },
				{ type = "money-multiplier", multiplier = 0.5 },
				{ type = "score-multiplier", multiplier = 4 },
				{ type = "richness-penalty", multipliers =
					{
						coal = 0.05,
						[ "copper-ore" ] = 0.025,
						[ "iron-ore" ] = 0.07,
						other = 0.06
					}
				}
			}
		}
	}
end

--Gives to the player all the gear, equipment, & stuff as part of the [index]th starter package.
--@param player	The LuaPlayer object to act on.
--@param index		A number specifying which starter package to give to the player.
--@return nil
function apply_bonuses_from_starter_package( player, index )
	if type( global.starterPackages ) ~= "table" then
		error( "Can\'t receive a starter package when no starter packages are defined!" )
	end
	local starterPackage = global.starterPackages[ index ]
	if not starterPackage then
		error( "The requested starter package does not exist!" )
	end
	local contents = starterPackage.contents
	if not contents or #contents < 1 then
		error( "The requested starter package has no contents!" )
	end
	if not player.character then
		error( "The player had no character to receive the starter package!" )
	end

	--Loop through all bonuses in the requested starter package & grant those.
	for _, v in ipairs( contents ) do
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
			player.insert({ name = v.item, count = v.count })
			if v.item == "construction-robot" then
				--Filter the last slot in the player's inventory:
				local inventory = player.get_inventory( defines.inventory.character_main )
				inventory.set_filter( #inventory, "construction-robot" )
			end
		elseif v.type == "crafting-speed-modifier" then
			if type( v.modifier ) ~= "number" then
				error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
			end
			--Else: valid.
			player.character_crafting_speed_modifier = player.character_crafting_speed_modifier + v.modifier
		elseif v.type == "armor-with-shield" then
			player.insert({ name = "modular-armor", count = 1 })
			--Put the equipment inside the modular armor's equipment grid:
			local grid = player.get_inventory( defines.inventory.character_armor )[ 1 ].grid
			grid.put({ name = "night-vision-equipment", by_player = player })
			grid.put({ name = "energy-shield-equipment", by_player = player })
			grid.put({ name = "belt-immunity-equipment", by_player = player })
			grid.put({ name = "solar-panel-equipment", by_player = player })
			grid.put({ name = "battery-mk2-equipment", by_player = player })
			grid.put({ name = "battery-mk2-equipment", by_player = player })
			for n = 1, 11 do
				grid.put({ name = "solar-panel-equipment", by_player = player })
			end
		elseif v.type == "armor-with-roboport" then
			player.insert({ name = "modular-armor", count = 1 })
			--Put the equipment inside the modular armor's equipment grid:
			local grid = player.get_inventory( defines.inventory.character_armor )[ 1 ].grid
			grid.put({ name = "personal-roboport-mk2-equipment", by_player = player })
			grid.put({ name = "battery-mk2-equipment", by_player = player })
			grid.put({ name = "battery-mk2-equipment", by_player = player })
			grid.put({ name = "belt-immunity-equipment", by_player = player })
			for n = 1, 16 do
				grid.put({ name = "solar-panel-equipment", by_player = player })
			end
		elseif v.type == "force-map-chart" then
			player.force.chart( player.surface, v.area )
		elseif v.type == "money-multiplier" then
			if type( v.multiplier ) ~= "number" then
				error( "Paramater \"multiplier\" was invalid.  Number expected, got "..type( v.multiplier ).."." )
			end
			global.militarySupplyScenario.moneyMultiplier = global.militarySupplyScenario.moneyMultiplier * v.multiplier
		elseif v.type == "score-multiplier" then
			if type( v.multiplier ) ~= "number" then
				error( "Paramater \"multiplier\" was invalid.  Number expected, got "..type( v.multiplier ).."." )
			end
			global.militarySupplyScenario.scoreMultiplier = global.militarySupplyScenario.scoreMultiplier * v.multiplier
		elseif v.type == "richness-penalty" then
			if type( v.multipliers ) ~= "table" then
				error( "Paramater \"multipliers\" was invalid.  Table expected, got "..type( v.multipliers ).."." )
			end
			apply_richness_penalty( v.multipliers )
		elseif v.type == "worker-robots-speed-modifier" then
			if type( v.modifier ) ~= "number" then
				error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
			end
			player.force.worker_robots_speed_modifier = player.force.worker_robots_speed_modifier + v.modifier
		elseif v.type == "manual-mining-speed-penalty" then
			if type( v.modifier ) ~= "number" then
				error( "Paramater \"modifier\" was invalid.  Number expected, got "..type( v.modifier ).."." )
			end
			player.character_mining_speed_modifier = player.character_mining_speed_modifier + v.modifier
		elseif v.type == "ghost-rebuild-timeout" then
			if type( v.hoursToTimeout ) ~= "number" then
				error( "Paramater \"hoursToTimeout\" was invalid.  Number expected, got "..type( v.hoursToTimeout ).."." )
			end
			player.force.ghost_time_to_live = player.force.ghost_time_to_live + v.hoursToTimeout * TICKS_PER_HOUR
		else
			error( "Paramater \"type\" was not one of the predefined valid values." )
		end
	end

	--The character will have some thoughts or comments on the starter package chosen.
	player.print( starterPackage.messageWhenChosen )
end

--Any amount of ore less than or equal to this number is not penalized.
--Additionally, any amount of ore above this number won't drop below this number as part of applying the penalty.
local MINIMUM_ORE_TO_PENALIZE = 10
--Any amount of ore greater than this number is capped at this amount instead.
local MAXIMUM_ORE_AFTER_PENALTY = 4294967295 --2^32 - 1

--This function decreases the richness of all resource entities on the map.
--This function is meant to be called ONLY ONCE because it requires searching an entire surface, so it's slow.
--@param multipliers	Table.  The keys are the names of resources to penalize & the values are the amount to multiply by.
--					For any key not present in the table, the key "other" is used as a default value.
--					The key "other" is ABSOLUTELY REQUIRED.
function apply_richness_penalty( multipliers )
	local allResources = game.surfaces[ 1 ].find_entities_filtered({ type = "resource" })
	if type( multipliers.other ) ~= "number" then
		error( "Paramater \"multipliers.other\" was invalid.  Number expected, got "..type( multipliers.other ).."." )
	end

	--Just for debug purposes, let's start with a small area.
	for _, v in pairs( allResources ) do
		if v.amount > MINIMUM_ORE_TO_PENALIZE then
			--Use the name of the resource, but if that key is missing, use the default.
			--Don't go negative & don't increase 
			local thisMulti = multipliers[ v.name ] or multipliers.other

			--Don't reduce below MINIMUM_ORE_TO_PENALIZE or go above MAXIMUM_ORE_AFTER_PENALTY:
			v.amount = math.max( MINIMUM_ORE_TO_PENALIZE, math.min( v.amount * thisMulti, MAXIMUM_ORE_AFTER_PENALTY ))
		end
		--Don't affect amounts of ore that are already less than MINIMUM_ORE_TO_PENALIZE.
	end
end