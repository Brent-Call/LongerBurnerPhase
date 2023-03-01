data:extend({
{
	type = "recipe",
	name = "air-filter",
	--Air filters cannot be crafted by hand:
	category = "advanced-crafting",
	enabled = false,
	emissions_multiplier = 0.7,
	energy_required = 4,
	ingredients =
	{
		{ "steel-plate", 1 },
		{ "wood", 2 },
		{ "plastic-bar", 4 }
	},
	result = "air-filter"
},
{
	type = "recipe",
	name = "advanced-burner-mining-drill",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 3,
		ingredients =
		{
			{ "air-filter", 1 },
			{ "steel-furnace", 1 },
			{ "steel-plate", 5 },
			{ "iron-gear-wheel", 5 }
		},
		result = "advanced-burner-mining-drill"
	},
	expensive =
	{
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{ "steel-furnace", 2 },
			{ "air-filter", 3 },
			{ "steel-plate", 9 },
			{ "iron-gear-wheel", 12 }
		},
		result = "advanced-burner-mining-drill"
	}
},
{
	type = "recipe",
	name = "burner-pumpjack",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{ "stone-furnace", 1 },
			{ "steel-plate", 5 },
			{ "iron-gear-wheel", 10 },
			{ "pipe", 10 },
			{ "stone-brick", 10 }
		},
		result = "burner-pumpjack"
	},
	expensive =
	{
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{ "stone-furnace", 2 },
			{ "steel-plate", 10 },
			{ "pipe", 10 },
			{ "stone-brick", 10 },
			{ "iron-gear-wheel", 15 }
		},
		result = "burner-pumpjack"
	}
},
{
	type = "recipe",
	name = "burner-assembling-machine-1",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{ "stone-furnace", 1 },
			{ "iron-gear-wheel", 5 },
			{ "iron-plate", 9 }
		},
		result = "burner-assembling-machine-1"
	},
	expensive =
	{
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{ "stone-furnace", 2 },
			{ "iron-gear-wheel", 8 },
			{ "iron-plate", 10 }
		},
		result = "burner-assembling-machine-1"
	}
},
{
	type = "recipe",
	name = "burner-assembling-machine-2",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{ "engine-unit", 2 },
			{ "iron-gear-wheel", 8 },
			{ "steel-plate", 10 }
		},
		result = "burner-assembling-machine-2"
	},
	expensive =
	{
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{ "engine-unit", 4 },
			{ "iron-gear-wheel", 14 },
			{ "steel-plate", 15 }
		},
		result = "burner-assembling-machine-2"
	}
},
{
	type = "recipe",
	name = "burner-assembling-machine-3",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{ "air-filter", 1 },
			{ "burner-assembling-machine-1", 1 },
			{ "steel-furnace", 1 },
			{ "iron-gear-wheel", 8 },
			{ "steel-plate", 10 }
		},
		results =
		{
			{ "burner-assembling-machine-3", 1 },
			{ "stone-furnace", 1 }
		},
		main_product = "burner-assembling-machine-3",
		allow_as_intermediate = false
	},
	expensive =
	{
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{ "burner-assembling-machine-1", 1 },
			{ "steel-furnace", 2 },
			{ "air-filter", 3 },
			{ "iron-gear-wheel", 15 },
			{ "steel-plate", 20 }
		},
		results =
		{
			{ "burner-assembling-machine-3", 1 },
			{ "stone-furnace", 2 }
		},
		main_product = "burner-assembling-machine-3",
		allow_as_intermediate = false
	}
},
{
	type = "recipe",
	name = "burner-oil-refinery",
	category = "crafting",
	normal =
	{
		enabled = false,
		energy_required = 8,
		ingredients =
		{
			{ "stone-furnace", 2 },
			{ "iron-gear-wheel", 10 },
			{ "pipe", 10 },
			{ "steel-plate", 10 },
			{ "stone-brick", 10 }
		},
		result = "burner-oil-refinery",
	},
	expensive =
	{
		enabled = false,
		energy_required = 8,
		ingredients =
		{
			{ "stone-furnace", 5 },
			{ "iron-gear-wheel", 15 },
			{ "pipe", 15 },
			{ "steel-plate", 15 },
			{ "stone-brick", 25 }
		},
		result = "burner-oil-refinery",
	}
},
{
	type = "recipe",
	name = "burner-chemical-plant",
	category = "crafting",
	normal =
	{
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{ "stone-furnace", 1 },
			{ "iron-gear-wheel", 5 },
			{ "pipe", 5 },
			{ "steel-plate", 5 },
			{ "stone-brick", 10 }
		},
		result = "burner-chemical-plant",
	},
	expensive =
	{
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{ "stone-furnace", 2 },
			{ "iron-gear-wheel", 9 },
			{ "steel-plate", 10 },
			{ "pipe", 12 },
			{ "stone-brick", 12 }
		},
		result = "burner-chemical-plant",
	}
},
{
	type = "recipe",
	name = "eco-assembling-machine",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{ "air-filter", 1 },
			{ "assembling-machine-2", 1 },
			{ "effectivity-module-3", 1 },
			{ "advanced-circuit", 4 }
		},
		result = "eco-assembling-machine"
	},
	expensive =
	{
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{ "air-filter", 3 },
			{ "assembling-machine-2", 1 },
			{ "effectivity-module-3", 1 },
			{ "advanced-circuit", 6 }
		},
		result = "eco-assembling-machine"
	}
},
{
	type = "recipe",
	name = "eco-chemical-plant",
	category = "crafting",
	normal = 
	{
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{ "air-filter", 1 },
			{ "chemical-plant", 1 },
			{ "effectivity-module-3", 1 },
			{ "advanced-circuit", 4 }
		},
		result = "eco-chemical-plant"
	},
	expensive =
	{
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{ "air-filter", 3 },
			{ "chemical-plant", 1 },
			{ "effectivity-module-3", 1 },
			{ "advanced-circuit", 6 }
		},
		result = "eco-chemical-plant"
	}
},
{
	type = "recipe",
	name = "uncraft-burner-inserters",
	icon = data.raw.item[ "burner-inserter" ].icon,
	icon_size = data.raw.item[ "burner-inserter" ].icon_size,
	subgroup = "inserter",
	order = "a[burner-inserter]-b",
	category = "crafting",
	enabled = false,
	energy_required = 2,
	ingredients = {{ "burner-inserter", 10 }},
	results =
	{
		{ "stone", 19 },
		{ "iron-plate", 6 },
		{ "iron-gear-wheel", 6 }
	},
	hide_from_stats = true,
	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false
}
})