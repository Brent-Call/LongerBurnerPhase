require( "Library.Lib" )

--Create some shorthand ways to refer to technology costs:
--"bsp" stands for "Burner Science Pack" (i.e. from this mod) & "sp" stands for "Science Pack" (i.e. from the base game)
--I use table.deepcopy(...) to ensure that changes to one tech don't affect all of the others.
local bsp1 = {{ "burner-science-pack-1", 1 }}
local bsp12 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }}
local bsp12sp1 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }, { "automation-science-pack", 1 }}
local sp1 = {{ "automation-science-pack", 1 }}
local sp12 = {{ "automation-science-pack", 1 }, { "logistic-science-pack", 1 }}

data:extend({
{
	type = "technology",
	name = "burner-automation",
	icon = "__base__/graphics/technology/automation-1.png",
	icon_size = 256,
	icon_mipmaps = 4,
	effects =
	{
		{ type = "unlock-recipe", recipe = "burner-mining-drill" },
		{ type = "unlock-recipe", recipe = "burner-assembling-machine-1" }
	},
	unit =
	{
		count = 10,
		ingredients = table.deepcopy( bsp1 ),
		time = 5
	},
	ignore_tech_cost_multiplier = true,
	order = "a-a-a"
},
{
	type = "technology",
	name = "burner-automation-2",
	icon = "__base__/graphics/technology/automation-1.png",
	icon_size = 256,
	icon_mipmaps = 4,
	effects =
	{
		{ type = "unlock-recipe", recipe = "advanced-burner-mining-drill" },
		{ type = "unlock-recipe", recipe = "burner-assembling-machine-3" },
		{ type = "unlock-recipe", recipe = "uncraft-burner-lab" }
	},
	prerequisites = { "air-filtering", "advanced-material-processing" },
	unit =
	{
		count = 100,
		ingredients = table.deepcopy( bsp12sp1 ),
		time = 30
	},
	order = "a-a-b"
},
{
	type = "technology",
	name = "electricity",
	icon = "__LongerBurnerPhase__/Graphics/Technologies/electricity.png",
	icon_size = 64,
	effects =
	{
		{ type = "unlock-recipe", recipe = "copper-cable" },
		{ type = "unlock-recipe", recipe = "electronic-circuit" },
		{ type = "unlock-recipe", recipe = "steam-engine" },
		{ type = "unlock-recipe", recipe = "small-electric-pole" },
		{ type = "unlock-recipe", recipe = "radar" },
		{ type = "unlock-recipe", recipe = "repair-pack" },
		{ type = "unlock-recipe", recipe = "lab" }
	},
	prerequisites = { "automation-science-pack" },
	unit =
	{
		count = 100,
		ingredients = table.deepcopy( bsp12sp1 ),
		time = 5
	},
	order = "a-a-d"
},
{
	type = "technology",
	name = "burner-oil-processing",
	icon = "__base__/graphics/technology/oil-gathering.png",
	icon_size = 256,
	icon_mipmaps = 4,
	localised_description = { "technology-description.oil-processing" },
	effects =
	{
		{ type = "unlock-recipe", recipe = "burner-pumpjack" },
		{ type = "unlock-recipe", recipe = "burner-oil-refinery" },
		{ type = "unlock-recipe", recipe = "burner-chemical-plant" },
		{ type = "unlock-recipe", recipe = "basic-oil-processing" },
		{ type = "unlock-recipe", recipe = "solid-fuel-from-petroleum-gas" }
		--In previous versions of this mod, this technology also unlocked solid fuel from light & heavy oils
	},
	prerequisites = { "fluid-handling" },
	unit =
	{
		count = 100,
		ingredients = table.deepcopy( bsp12 ),
		time = 20
	},
	order = "a-a-e"
},
{
	type = "technology",
	name = "air-filtering",
	icon = "__LongerBurnerPhase__/Graphics/Technologies/air-filter.png",
	icon_size = 64,
	effects =
	{
		{ type = "unlock-recipe", recipe = "air-filter" }
	},
	prerequisites = { "plastics" },
	unit =
	{
		count = 100,
		ingredients = table.deepcopy( bsp12sp1 ),
		time = 30
	},
	order = "a-a-f"
},
{
	type = "technology",
	name = "automation-science-pack",
	icon = "__LongerBurnerPhase__/Graphics/Technologies/automation-science-pack.png",
	icon_size = 128,
	effects =
	{
		{ type = "unlock-recipe", recipe = "automation-science-pack" }
	},
	unit =
	{
		count = 100,
		ingredients = table.deepcopy( bsp12 ),
		time = 5
	},
	order = "a-a-w"
},
{
	type = "technology",
	name = "eco-automation",
	icon = "__base__/graphics/technology/automation-1.png",
	icon_size = 256,
	icon_mipmaps = 4,
	effects =
	{
		{ type = "unlock-recipe", recipe = "eco-assembling-machine" },
		{ type = "unlock-recipe", recipe = "eco-chemical-plant" }
	},
	prerequisites = { "automation-3", "effectivity-module-3" },
	unit =
	{
		count = 300,
		ingredients = {{ "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "chemical-science-pack", 1 }, { "production-science-pack", 1 }},
		time = 30
	},
	order = "a-b-d"
}
})