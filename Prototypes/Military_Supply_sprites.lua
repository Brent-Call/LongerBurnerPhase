--This file defines some sprites used only for the Military Supply scenario.
local CONSTRUCTION_ROBOT_ITEM = data.raw.item[ "construction-robot" ]

data:extend({
{
	type = "sprite",
	name = "military-supply-worker-robot-speed-bonus",
	layers =
	{
		{
			filename = CONSTRUCTION_ROBOT_ITEM.icon,
			size = CONSTRUCTION_ROBOT_ITEM.icon_size,
			mipmap_count = CONSTRUCTION_ROBOT_ITEM.mipmap_count,
			flags = { "gui-icon" }
		},
		data.raw[ "utility-sprites" ].default.worker_robot_speed_modifier_constant
	}
},
{
	type = "sprite",
	name = "military-supply-ghost-rebuild-timeout",
	layers =
	{
		data.raw[ "utility-sprites" ].default.ghost_time_to_live_modifier_icon,
		data.raw[ "utility-sprites" ].default.ghost_time_to_live_modifier_constant,
	}
},
{
	type = "sprite",
	name = "military-supply-manual-mining-penalty",
	filename = "__LongerBurnerPhase__/Graphics/Items/MilitarySupply/steel-axe.png",
	size = 64,
	flags = { "gui-icon" },
	mipmap_count = 4,
	tint = { r = 1, g = 0.5, b = 0.5, a = 1 },
	scale = 0.5
}
})

--Shrink the icons:
for _, v in pairs( data.raw.sprite[ "military-supply-worker-robot-speed-bonus" ].layers ) do
	v.scale = ( v.scale or 1 ) * 0.5
end
for _, v in pairs( data.raw.sprite[ "military-supply-ghost-rebuild-timeout" ].layers ) do
	v.scale = ( v.scale or 1 ) * 0.5
end