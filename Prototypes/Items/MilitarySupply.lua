--Parts of the Eternity Ray are tinted this color:
local eternityRayTint = { r = 1, g = 0.5, b = 0, a = 1 }

data:extend({
{
	type = "item-subgroup",
	name = "military-supply-eternity-ray",
	group = "combat",
	order = "z"
},
{
	type = "item",
	name = "military-supply-eternity-ray-structure",
	icons = {{ icon = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/eternity-ray-structure.png", tint = eternityRayTint }},
	icon_size = 32,
	flags = { "hidden" },
	subgroup = "military-supply-eternity-ray",
	order = "a[ structure ]",
	stack_size = 20
},
{
	type = "item",
	name = "military-supply-eternity-ray-power-core",
	icons = {{ icon = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/eternity-ray-power-core.png", tint = eternityRayTint }},
	icon_size = 32,
	flags = { "hidden" },
	subgroup = "military-supply-eternity-ray",
	order = "b[ power-core ]",
	stack_size = 20
},
{
	type = "item",
	name = "military-supply-eternity-ray-emitter",
	icons = {{ icon = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/eternity-ray-emitter.png", tint = eternityRayTint }},
	icon_size = 32,
	flags = { "hidden" },
	subgroup = "military-supply-eternity-ray",
	order = "c[ emitter ]",
	stack_size = 20
},
{
	type = "item",
	name = "military-supply-eternity-ray",
	icons = {{ icon = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/eternity-ray.png", tint = eternityRayTint }},
	icon_size = 32,
	flags = { "hidden" },
	subgroup = "military-supply-eternity-ray",
	order = "d[ the-actual-ray-itself ]",
	stack_size = 1,
	stackable = false
},
--The zarnium crystals are what make the Eternity Ray so powerful:
{
	type = "item",
	name = "military-supply-zarnium-crystal",
	icons = {{ icon = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/zarnium-crystal.png", tint = { r = 0, g = 0, b = 1, a = 1 }}},
	icon_size = 32,
	flags = { "hidden" },
	subgroup = "raw-resource",
	order = "a[ zarnium-crystal ]",
	stack_size = 50
}
})