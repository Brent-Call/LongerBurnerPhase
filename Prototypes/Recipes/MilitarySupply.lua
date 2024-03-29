--The following recipeies are used only in the Military Supply scenario.
data:extend({
{
	--This is a version of the normal recipe for repair packs,
	--but it doesn't require electronic circuits to craft.
	type = "recipe",
	name = "military-supply-repair-pack",
	category = "crafting",
	enabled = false,
	energy_required = 0.5,
	ingredients =
	{
		{ "copper-plate", 3 },
		{ "iron-gear-wheel", 3 }
	},
	result = "repair-pack"
},
{
	--This is a version of the normal recipe for refined concrete,
	--but it can be crafted in a Burner Assembling Machine 2.
	--Since this recipe is only for the Military Supply scenario,
	--I think I'll make it a bit cheaper to craft than normal.
	type = "recipe",
	name = "military-supply-refined-concrete",
	category = "crafting-with-fluid",
	enabled = false,
	energy_required = 15,
	ingredients =
	{
		{ "concrete", 10 }, --Regular recipe requires 20
		{ "iron-stick", 8 },
		--Regular recipe requires 1 steel plate.
		{ type = "fluid", name = "water", amount = 100 }
	},
	result = "refined-concrete",
	result_count = 10
},
{
	type = "recipe",
	name = "military-supply-eternity-ray-structure",
	category = "advanced-crafting",
	enabled = false,
	energy_required = 5,
	ingredients =
	{
		{ "steel-plate", 15 },
		{ "concrete", 10 },
		{ "stone-wall", 10 }
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
		{ "big-electric-pole", 3 },
		{ "steam-engine", 3 }
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
		{ "military-supply-zarnium-crystal", 20 },
		{ "engine-unit", 10 },
		{ "gun-turret", 5 }
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
--This recipe exists only to make sulfur show up in item selection menus
--(such as inventory slot filters or the filter inserter GUI) once sulfur has been unlocked
--in the Military Supply scenario.
{
	type = "recipe",
	name = "military-supply-dummy-enable-sulfur",
	category = "crafting",
	enabled = false,
	energy_required = 0.5,
	ingredients = {},
	result = "sulfur",
	allow_as_intermediate = false,
	hidden = true --Do not show this recipe in any crafting menus.
}
})