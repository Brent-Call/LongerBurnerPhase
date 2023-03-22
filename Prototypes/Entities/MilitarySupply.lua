--A simple constant, equal to the map color of the Military Supply chests:
local MILITARY_SUPPLY_CHEST_MAP_COLOR = { r = 1.0, g = 1.0, b = 1.0 }

--The following entities are used in the Military Supply scenario, included with this mod:
data:extend({
{
	type = "container",
	name = "military-supply-pickup-chest",
	icon = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/pickup-chest-icon.png",
	icon_size = 32,
	flags = { "not-blueprintable", "not-deconstructable", "not-repairable" },
	mineable = { mineable = false },
	max_health = 1000,
	corpse = "small-remnants",
	collision_box = {{ -0.35, -0.35 }, { 0.35, 0.35 }},
	selection_box = {{ -0.5,  -0.5 },  { 0.5,  0.5  }},
	inventory_size = 16,
	open_sound =  { filename = "__base__/sound/metallic-chest-open.ogg",  volume = 0.65 },
	close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7  },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	picture =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/pickup-chest.png",
				priority = "extra-high",
				width = 34,
				height = 38,
				shift = { 0, -0.0625 },
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/hr-pickup-chest.png",
					priority = "extra-high",
					width = 66,
					height = 74,
					shift = { 0, -0.0625 },
					scale = 0.5
				}
			},
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/chest-shadow.png",
				priority = "extra-high",
				width = 48,
				height = 24,
				shift = util.by_pixel( 8.5, 5.5 ),
				draw_as_shadow = true,
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/hr-chest-shadow.png",
					priority = "extra-high",
					width = 96,
					height = 44,
					shift = util.by_pixel( 8.5, 5 ),
					draw_as_shadow = true,
					scale = 0.5
				}
			}
		}
	},
	
	map_color = MILITARY_SUPPLY_CHEST_MAP_COLOR,
	
	--Circuit connector definitions; this chest cannot be connected to the circuit network.
	circuit_wire_connection_point = circuit_connector_definitions[ "chest" ].points,
	circuit_connector_sprites = circuit_connector_definitions[ "chest" ].sprites,
	circuit_wire_max_distance = 0
},
{
	type = "infinity-container",
	name = "military-supply-dropoff-chest",
	icon = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/dropoff-chest-icon.png",
	icon_size = 32,
	flags = { "not-blueprintable", "not-deconstructable", "not-repairable" },
	mineable = { mineable = false },
	max_health = 1000,
	corpse = "small-remnants",
	collision_box = {{ -0.35, -0.35 }, { 0.35, 0.35 }},
	selection_box = {{ -0.5,  -0.5 },  { 0.5,  0.5  }},
	inventory_size = 16,
	open_sound =  { filename = "__base__/sound/metallic-chest-open.ogg",  volume = 0.65 },
	close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7  },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	picture =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/dropoff-chest.png",
				priority = "extra-high",
				width = 34,
				height = 38,
				shift = { 0, -0.0625 },
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/hr-dropoff-chest.png",
					priority = "extra-high",
					width = 66,
					height = 74,
					shift = { 0, -0.0625 },
					scale = 0.5
				}
			},
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/chest-shadow.png",
				priority = "extra-high",
				width = 48,
				height = 24,
				shift = util.by_pixel( 8.5, 5.5 ),
				draw_as_shadow = true,
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/MilitarySupply/hr-chest-shadow.png",
					priority = "extra-high",
					width = 96,
					height = 44,
					shift = util.by_pixel( 8.5, 5 ),
					draw_as_shadow = true,
					scale = 0.5
				}
			}
		}
	},
	
	map_color = MILITARY_SUPPLY_CHEST_MAP_COLOR,
	
	--Properties of infinity chests:
	erase_contents_when_mined = true,
	gui_mode = "none",

	--Circuit connector definitions; this chest cannot be connected to the circuit network.
	circuit_wire_connection_point = circuit_connector_definitions[ "chest" ].points,
	circuit_connector_sprites = circuit_connector_definitions[ "chest" ].sprites,
	circuit_wire_max_distance = 0
}
})