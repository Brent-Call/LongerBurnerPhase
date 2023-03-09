--The code in each of these functions acts on each specific force & player, so it should be multiplayer-safe.

function initial_resources()
	for _, player in pairs( game.players ) do
		player.insert{ name = "iron-plate", count = 300 }
		player.insert{ name = "copper-plate", count = 100 }
		player.insert{ name = "stone-furnace", count = 10 }
		player.insert{ name = "burner-mining-drill", count = 10 }
		player.insert{ name = "solid-fuel", count = 50 }
	end
end
	
function initial_recipes()
	add_goal_item( "pistol", 3.75, 5, 20 )
	add_goal_item( "firearm-magazine", 2, 40, 400 )

	for _, force in pairs( game.forces ) do
		local recipes = force.recipes
	
		--Logistics:
		recipes[ "iron-chest" ].enabled = true
		recipes[ "steel-chest" ].enabled = true
		recipes[ "transport-belt" ].enabled = true
		recipes[ "underground-belt" ].enabled = true
		recipes[ "splitter" ].enabled = true
		recipes[ "burner-inserter" ].enabled = true
	
		--Production:
		recipes[ "burner-mining-drill" ].enabled = true
		recipes[ "stone-furnace" ].enabled = true
		recipes[ "burner-assembling-machine-1" ].enabled = true
	
		--Intermediate products:
		recipes[ "iron-plate" ].enabled = true
		recipes[ "copper-plate" ].enabled = true
		recipes[ "steel-plate" ].enabled = true
		recipes[ "iron-stick" ].enabled = true
		recipes[ "iron-gear-wheel" ].enabled = true
		recipes[ "stone-brick"].enabled = true;
	
		--Combat:
		recipes[ "pistol" ].enabled = true
		recipes[ "firearm-magazine" ].enabled = true
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
	for _, force in pairs( game.forces ) do
		local recipes = force.recipes
		recipes[ "military-supply-eternity-ray-structure" ].enabled = true
		recipes[ "military-supply-eternity-ray-power-core" ].enabled = true
		recipes[ "military-supply-eternity-ray-emitter" ].enabled = true
		recipes[ "military-supply-eternity-ray" ].enabled = true
	end
	
	for _, player in pairs( game.players ) do
		--Now it will say that to win, the player must build the ETERNITY RAY.
		update_main_GUI_for_final_objective( player )
	end
	
	--Tell the scenario object to add zarnium crystals to the SUPPLY DROPOFF CHEST:
	global.militarySupplyScenario.zarniumUnlocked = true
end

function on_killed_spawner()
	for _, force in pairs( game.forces ) do
		--Provide a 20% bonus to gun turrets:
		force.set_turret_attack_modifier( "gun-turret", force.get_turret_attack_modifier( "gun-turret" ) + 0.2 )
	end
end

function upgrades_after_concrete()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "sulfur", "item/sulfur", 700 )
end

function upgrades_after_wall()	
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "repair", "item/repair-pack", 75 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "light-armor", "item/light-armor", 150 )
end

function upgrades_after_repair()	
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "concrete", "item/concrete", 275 )
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
	--If the mod Iron Sticks Gear is enabled, add an upgrade to unlock it:
	--Otherwise, nothing happens.
	if game.recipe_prototypes[ "advanced-iron-gear-wheel" ] then
		--The mod Iron Sticks Gear is enabled!
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
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "solar-panel", "item/solar-panel", 600 )
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "mining-prod-1", "item/electric-mining-drill", 800 )
end

function upgrades_after_fast_inserter()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "circuit-network", "item/red-wire", 350 )
end

function upgrades_after_circuit_network()
	--If Q's Cable-Making Mod is enabled, add an upgrade to unlock a better recipe:
	if game.recipe_prototypes[ "advanced-cable1" ] then
		--The mod Iron Sticks Gear is enabled!
		add_upgrade_to_scenario_object( global.militarySupplyScenario, "better-cable-making", "recipe/advanced-cable1", 750 )
	end
end

function upgrades_after_armor()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "heavy-armor", "item/heavy-armor", 400 )
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

function upgrades_after_bullet_3()
	add_upgrade_to_scenario_object( global.militarySupplyScenario, "laser-turret", "item/laser-turret", 900 )
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
		for _, force in pairs( game.forces ) do
			force.recipes[ "submachine-gun" ].enabled = true
		end
		
		add_goal_item( "submachine-gun", 16.25, 5, 20 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-smg" )
		upgrades_after_smg()
	end,
	[ "piercing-ammo" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "piercing-rounds-magazine" ].enabled = true
		end
		
		add_goal_item( "piercing-rounds-magazine", 4.5, 40, 400 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-piercing-ammo" )
		upgrades_after_piercing_ammo()
	end,
	wall = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "stone-wall" ].enabled = true
			recipes[ "stone-brick" ].enabled = true
			recipes[ "gate" ].enabled = true
		end
	
		add_goal_item( "stone-wall", 3.75, 20, 200 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-wall" )
		upgrades_after_wall()
	end,
	[ "bam-2" ] = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "engine-unit" ].enabled = true
			recipes[ "pipe" ].enabled = true
			recipes[ "burner-assembling-machine-2" ].enabled = true
		end
		
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-bam-2" )
		upgrades_after_bam2()
	end,
	sulfur = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "burner-chemical-plant" ].enabled = true
			recipes[ "sulfuric-acid" ].enabled = true
			recipes[ "battery" ].enabled = true
			--This dummy recipe doesn't show up in crafting menus, but it does make sulfur appear in
			--listings of all unlocked items.
			recipes[ "military-supply-dummy-enable-sulfur" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-sulfur1" )
		--Tell the scenario object to add sulfur to the SUPPLY DROPOFF CHEST:
		global.militarySupplyScenario.sulfurUnlocked = true
	end,
	repair = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "military-supply-repair-pack" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-repair" )
		upgrades_after_repair()
	end,
	[ "light-armor" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "light-armor" ].enabled = true
		end
		add_goal_item( "light-armor", 20, 2, 5 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-light-armor" )
		upgrades_after_armor()
	end,
	concrete = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "concrete" ].enabled = true
			recipes[ "hazard-concrete" ].enabled = true
			--Concrete needs water to craft.  Just in case the player doesn't have water, give him/her a way to get some:
			recipes[ "pipe" ].enabled = true
			recipes[ "pipe-to-ground" ].enabled = true
			recipes[ "offshore-pump" ].enabled = true
			if recipes[ "burner-offshore-pump" ] then
				recipes[ "burner-offshore-pump" ].enabled = true
			end
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-concrete" )
		upgrades_after_concrete()
	end,
	[ "steel-furnace" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "steel-furnace" ].enabled = true
		end
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
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			--Note: the "pipe" recipe will already be enabled because it is included in one of this upgrade's prerequisites.
			recipes[ "pipe-to-ground" ].enabled = true
			recipes[ "boiler" ].enabled = true
			recipes[ "steam-engine" ].enabled = true
			recipes[ "offshore-pump" ].enabled = true
			recipes[ "medium-electric-pole" ].enabled = true
			recipes[ "small-lamp" ].enabled = true
			recipes[ "inserter" ].enabled = true
			recipes[ "copper-cable" ].enabled = true
			recipes[ "electronic-circuit" ].enabled = true
			if recipes[ "burner-offshore-pump" ] then
				recipes[ "burner-offshore-pump" ].enabled = true
			end
		end
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
		for _, force in pairs( game.forces ) do
			force.recipes[ "advanced-iron-gear-wheel" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-iron-sticks-gear" )
	end,
	[ "electricity-2" ] = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "assembling-machine-1" ].enabled = true
			recipes[ "big-electric-pole" ].enabled = true
			recipes[ "electric-mining-drill" ].enabled = true
			recipes[ "radar" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-electricity-2" )
		upgrades_after_electricity_2()
	end,
	[ "fast-inserter" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "fast-inserter" ].enabled = true
			force.recipes[ "filter-inserter" ].enabled = true
			force.recipes[ "uncraft-burner-inserters" ].enabled = true
		end
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
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "fast-transport-belt" ].enabled = true
			recipes[ "fast-underground-belt" ].enabled = true
			recipes[ "fast-splitter" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-red-belt" )
		upgrades_after_fast_belts()
	end,
	[ "solar-panel" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "solar-panel" ].enabled = true
			force.recipes[ "accumulator" ].enabled = true
			--Compatibiilty with the Simple Silicon mod:
			if force.recipes[ "SiSi-quartz" ] then
				force.recipes[ "SiSi-quartz" ].enabled = true
			end
			if force.recipes[ "SiSi-silicon" ] then
				force.recipes[ "SiSi-silicon" ].enabled = true
			end
			if force.recipes[ "SiSi-solar-cell" ] then
				force.recipes[ "SiSi-solar-cell" ].enabled = true
			end
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-solar-panel" )
	end,
	[ "mining-prod-1" ] = function()
		for _, force in pairs( game.forces ) do
			--Adds 4% mining productivity.
			force.mining_drill_productivity_bonus = force.mining_drill_productivity_bonus + 0.04
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-mining-prod-bonus" )
	end,
	[ "circuit-network" ] = function()
		for _, force in pairs( game.forces ) do
			local recipes = force.recipes
			recipes[ "red-wire" ].enabled = true
			recipes[ "green-wire" ].enabled = true
			recipes[ "arithmetic-combinator" ].enabled = true
			recipes[ "decider-combinator" ].enabled = true
			recipes[ "constant-combinator" ].enabled = true
			recipes[ "power-switch" ].enabled = true
			recipes[ "programmable-speaker" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-circuit-network" )
		upgrades_after_circuit_network()
	end,
	[ "better-cable-making" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "advanced-cable1" ].enabled = true
			force.recipes[ "green-to-red-wire" ].enabled = true
			force.recipes[ "red-to-green-wire" ].enabled = true
			
			--Disable the old recipe:
			force.recipes[ "copper-cable" ].enabled = false
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-better-cable-making" )
	end,
	[ "heavy-armor" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "heavy-armor" ].enabled = true
		end
		add_goal_item( "heavy-armor", 87.5, 2, 5 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-heavy-armor" )
	end,
	grenade = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "grenade" ].enabled = true
		end
		add_goal_item( "grenade", 5, 20, 200 )
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-grenade" )
		upgrades_after_grenade()
	end,
	car = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "car" ].enabled = true
		end
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
		--Purchasing the turret renders the old pistol obsolete.
		--(In truth, it was obsolete the moment we got the SMG, but now they will no longer be accepted as goal items.)
		remove_goal_item( "pistol" )
		add_goal_item( "gun-turret", 22.5, 15, 100 )
		
		for _, force in pairs( game.forces ) do
			force.recipes[ "gun-turret" ].enabled = true
		end
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
		for _, force in pairs( game.forces ) do
			force.recipes[ "poison-capsule" ].enabled = true
			force.recipes[ "defender-capsule" ].enabled = true
			--Allow 5 followers right from the start:
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
		upgrades_after_bullet_3()
	end,
	[ "laser-turret" ] = function()
		for _, force in pairs( game.forces ) do
			force.recipes[ "laser-turret" ].enabled = true
		end
		display_message_of_scenario_object( global.militarySupplyScenario, "thoughts-unlock-laser-turret" )
	end
}

--Sets the seed for the Lua random number generator based on some information.
--@param package	A number.  Technically it doesn't matter, but customarily we use
--				a value corresponding to the starter package that was chosen.
--@param player	A LuaPlayer object.  The player's data, along with some global game
--				data, will be used to calculate the seed using a mathematical function.
function seed_RNG( package, player )
	math.randomseed( game.tick + integerValueOfPackageChosen * 599 +
		player.position.x * 8819 + ( player.position.y ^ 2 ) * 13921 )
end