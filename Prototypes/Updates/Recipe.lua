require( "Library.Lib" )

local recipes = data.raw.recipe

--Make splitters not take electronic circuits to craft:
recipes[ "splitter" ].ingredients =
{
	{ "copper-plate", 3 },
	{ "transport-belt", 4 },
	{ "iron-plate", 5 }
}

--Split the recipe for the Splitter so it's different in normal vs. expensive mode:
local spli = table.deepcopy( recipes[ "splitter" ])
spli.normal = {}
spli.normal.enabled = spli.enabled
spli.normal.ingredients = spli.ingredients
spli.normal.result = spli.result
spli.expensive = table.deepcopy( spli.normal )
spli.expensive.ingredients[ 1 ][ 2 ] = 10
spli.enabled = nil
spli.ingredients = nil
spli.result = nil
recipes[ "splitter" ] = table.deepcopy( spli )
spli = nil

--Change offshore pump recipe:
recipes[ "offshore-pump" ].ingredients =
{
	{ "iron-gear-wheel", 2 },
	{ "pipe", 2 },
	{ "iron-plate", 5 }
}

--Make burner inserters take 3 stone to craft:
QLuaLibrary.add_recipe_ingredient( "burner-inserter", "stone", 3, 3 )

--Make the assembling-machine-3 require lubricant to craft:
recipes[ "assembling-machine-3" ].category = "crafting-with-fluid"
table.insert( recipes[ "assembling-machine-3" ].ingredients, { type = "fluid", name = "lubricant", amount = 60 })

--Split the recipe for the Locomotive so it's different in normal vs. expensive mode:
local loco = table.deepcopy( recipes[ "locomotive" ])
loco.normal = {}
loco.normal.enabled = loco.enabled
loco.normal.ingredients = loco.ingredients
loco.normal.result = loco.result
loco.expensive = table.deepcopy( loco.normal )
loco.enabled = nil
loco.ingredients = nil
loco.result = nil
recipes[ "locomotive" ] = table.deepcopy( loco )
loco = nil

--Locomotives require air filters to make:
QLuaLibrary.add_recipe_ingredient( "locomotive", "air-filter", 1, 3 )

--Disable electricity at the start of the game:
QLuaLibrary.disable_recipe( "burner-mining-drill" )
QLuaLibrary.disable_recipe( "copper-cable" )
QLuaLibrary.disable_recipe( "electric-mining-drill" )
QLuaLibrary.disable_recipe( "electronic-circuit" )
QLuaLibrary.disable_recipe( "inserter" )
QLuaLibrary.disable_recipe( "lab" )
QLuaLibrary.disable_recipe( "radar" )
QLuaLibrary.disable_recipe( "repair-pack" )
QLuaLibrary.disable_recipe( "automation-science-pack" )
QLuaLibrary.disable_recipe( "small-electric-pole" )
QLuaLibrary.disable_recipe( "steam-engine" )
if data.raw.recipe[ "electric-offshore-pump" ] then
	QLuaLibrary.disable_recipe( "electric-offshore-pump" )
end