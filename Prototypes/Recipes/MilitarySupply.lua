--The following recipeies are used only in the Military Supply scenario:
data:extend({
{
	type = "recipe",
	name = "military-supply-repair-pack",
	category = "crafting",
	enabled = false,
	energy_required = 0.5,
	ingredients =
	{
		{ "iron-gear-wheel", 2 },
		{ "copper-plate", 3 }
	},
	result = "repair-pack"
},
{
	type = "recipe",
	name = "military-supply-eternity-ray-structure",
	category = "advanced-crafting",
	enabled = false,
	energy_required = 5,
	ingredients =
	{
		{ "concrete", 10 },
		{ "stone-wall", 10 },
		{ "steel-plate", 15 }
	},
	result = "military-supply-eternity-ray-structure"
},
{
	type = "recipe",
	name = "military-supply-eternity-ray-power-core",
	category = "advanced-crafting",
	enabled = false,
	energy_required = 5,
	ingredients =
	{
		{ "battery", 10 },
		{ "steam-engine", 3 },
		{ "big-electric-pole", 3 }
	},
	result = "military-supply-eternity-ray-power-core"
},
{
	type = "recipe",
	name = "military-supply-eternity-ray-emitter",
	category = "advanced-crafting",
	enabled = false,
	energy_required = 5,
	ingredients =
	{
		{ "laser-turret", 3 },
		{ "engine-unit", 10 },
		{ "military-supply-zarnium-crystal", 20 }
	},
	result = "military-supply-eternity-ray-emitter"
},
{
	type = "recipe",
	name = "military-supply-eternity-ray",
	category = "advanced-crafting",
	enabled = false,
	energy_required = 30,
	ingredients =
	{
		{ "military-supply-eternity-ray-structure", 20 },
		{ "military-supply-eternity-ray-power-core", 20 },
		{ "military-supply-eternity-ray-emitter", 20 }
	},
	result = "military-supply-eternity-ray"
},
{
	type = "recipe",
	name = "military-supply-dummy-enable-sulfur",
	category = "crafting",
	enabled = false,
	energy_required = 0.5,
	ingredients = {},
	result = "sulfur",
	allow_as_intermediate = false,
	hidden = true
}
})