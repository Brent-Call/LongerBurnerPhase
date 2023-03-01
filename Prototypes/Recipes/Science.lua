data:extend({
{
	type = "recipe",
	name = "burner-science-pack-1",
	category = "crafting",
	enabled = true,
	energy_required = 8,
	ingredients =
	{
		{ "stone", 1 }
	},
	result = "burner-science-pack-1"
},
{
	type = "recipe",
	name = "burner-science-pack-2",
	category = "crafting",
	enabled = true,
	energy_required = 4,
	ingredients =
	{
		{ "coal", 1 },
		{ "pipe", 1 }
	},
	result = "burner-science-pack-2"
},
{
	type = "recipe",
	name = "burner-lab",
	category = "crafting",
	enabled = true,
	energy_required = 3,
	ingredients =
	{
		{ "stone-furnace", 1 },
		{ "iron-gear-wheel", 10 },
		{ "wood", 10 }
	},
	result = "burner-lab"
},
{
	type = "recipe",
	name = "uncraft-burner-lab",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-lab.png",
	icon_size = 32,
	subgroup = "production-machine",
	category = "crafting",
	enabled = false,
	energy_required = 3,
	ingredients = {{ "burner-lab", 1 }},
	results =
	{
		{ "stone-furnace", 1 },
		{ "iron-gear-wheel", 10 },
		{ "wood", 10 }
	},
	hide_from_stats = true,
	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false
}
})