data:extend({
{
	type = "lab",
	name = "burner-lab",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-lab.png",
	icon_size = 32,
	flags = { "placeable-player", "player-creation" },
	minable = { mining_time = data.raw.lab[ "lab" ].minable.mining_time, result = "burner-lab" },
	max_health = 150,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	light = { intensity = 0.75, size = 8, color = { r = 1.0, g = 1.0, b = 1.0 }},
	on_animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-lab/burner-lab.png",
				width = 97,
				height = 87,
				frame_count = 18,
				line_length = 6,
				animation_speed = 1 / 3,
				shift = util.by_pixel(-0.5, 1.5),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/burner-lab/hr-burner-lab.png",
					width = 194,
					height = 174,
					frame_count = 18,
					line_length = 6,
					animation_speed = 1 / 3,
					shift = util.by_pixel(-0.5, 1.5),
					scale = 0.5
				}
			},
			{
				filename = "__base__/graphics/entity/lab/lab-integration.png",
				width = 122,
				height = 81,
				frame_count = 1,
				line_length = 1,
				repeat_count = 18,
				animation_speed = 1 / 3,
				shift = util.by_pixel(0, 15.5),
				hr_version =
				{
					filename = "__base__/graphics/entity/lab/hr-lab-integration.png",
					width = 242,
					height = 162,
					frame_count = 1,
					line_length = 1,
					repeat_count = 18,
					animation_speed = 1 / 3,
					shift = util.by_pixel(0, 15.5),
					scale = 0.5
				}
			},
			{
				filename = "__base__/graphics/entity/lab/lab-shadow.png",
				width = 122,
				height = 68,
				frame_count = 1,
				line_length = 1,
				repeat_count = 18,
				animation_speed = 1 / 3,
				shift = util.by_pixel(13, 11),
				draw_as_shadow = true,
				hr_version =
				{
					filename = "__base__/graphics/entity/lab/hr-lab-shadow.png",
					width = 242,
					height = 136,
					frame_count = 1,
					line_length = 1,
					repeat_count = 18,
					animation_speed = 1 / 3,
					shift = util.by_pixel(13, 11),
					scale = 0.5,
					draw_as_shadow = true
				}
			}
		}
	},
	off_animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-lab/burner-lab.png",
				width = 98,
				height = 87,
				frame_count = 1,
				shift = util.by_pixel(0, 1.5),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/burner-lab/hr-burner-lab.png",
					width = 194,
					height = 174,
					frame_count = 1,
					shift = util.by_pixel(0, 1.5),
					scale = 0.5
				}
			},
			{
				filename = "__base__/graphics/entity/lab/lab-integration.png",
				width = 122,
				height = 81,
				frame_count = 1,
				shift = util.by_pixel(0, 15.5),
				hr_version =
				{
					filename = "__base__/graphics/entity/lab/hr-lab-integration.png",
					width = 242,
					height = 162,
					frame_count = 1,
					shift = util.by_pixel(0, 15.5),
					scale = 0.5
				}
			},
			{
				filename = "__base__/graphics/entity/lab/lab-shadow.png",
				width = 122,
				height = 68,
				frame_count = 1,
				shift = util.by_pixel(13, 11),
				draw_as_shadow = true,
				hr_version =
				{
					filename = "__base__/graphics/entity/lab/hr-lab-shadow.png",
					width = 242,
					height = 136,
					frame_count = 1,
					shift = util.by_pixel(13, 11),
					draw_as_shadow = true,
					scale = 0.5
				}
			}
		}
	},
	working_sound =
	{
		sound = { filename = "__base__/sound/furnace.ogg" },
		apparent_volume = 1
	},
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	--Consumes chemical fuel at a rate of 75kW.
	--Produces 1.5 pollution per minute:
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		effectivity = 1,
		fuel_inventory_size = 1,
		emissions_per_minute = 1.5,
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 1,
				position = util.by_pixel( 0, -16 ),
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "75kW",
	
	--=======================================================================
	--               RESEARCH ABILITIES & VITAL INFORMATION
	--=======================================================================
	researching_speed = 1,
	inputs = { "burner-science-pack-1", "burner-science-pack-2", "automation-science-pack" }
}
})