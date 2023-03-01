--Handy note:
--stripes = util.multiplystripes( x, {...}) is a useful way to take an image and copy it so it becomes a longer animation.  Thanks to Bob for pointing that out to me.
function bam2pipepictures()
return
{
	north =
	{
		filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/pipe-N.png",
		priority = "extra-high",
		width = 48,
		height = 32,
		shift = util.by_pixel( 7, 32 ),
		hr_version =
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-pipe-N.png",
			priority = "extra-high",
			width = 96,
			height = 64,
			shift = util.by_pixel( 7, 32 ),
			scale = 0.5
		}
	},
	east =
	{
		filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/pipe-E.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		shift = util.by_pixel( -48, -16 ),
		hr_version =
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-pipe-E.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			shift = util.by_pixel( -48, -16 ),
			scale = 0.5
		}
	},
	south =
	{
		filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/pipe-S.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		shift = util.by_pixel( 16, -48 ),
		hr_version =
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-pipe-S.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			shift = util.by_pixel( 16, -48 ),
			scale = 0.5
		}
	},
	west =
	{
		filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/pipe-W.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		shift = util.by_pixel( 48, 16 ),
		hr_version =
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-pipe-W.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			shift = util.by_pixel( 48, 16 ),
			scale = 0.5
		}
	}
}
end

data:extend({
{
	type = "assembling-machine",
	name = "burner-assembling-machine-1",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-assembling-machine-1.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "burner-assembling-machine-1" },
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	resistances =
	{
		{ type = "fire", percent = 50 }
	},
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	fast_replaceable_group = "assembling-machine",
	animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/burner-assembling-machine-1.png",
				priority = "high",
				width = 96,
				height = 96,
				frame_count = 32,
				line_length = 8,
				shift = util.by_pixel( 0, 0 ),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/hr-burner-assembling-machine-1.png",
					priority = "high",
					width = 192,
					height = 192,
					frame_count = 32,
					line_length = 8,
					shift = util.by_pixel( 0, 0 ),
					scale = 0.5
				}
			},
			{
				stripes = util.multiplystripes( 32,
				{
					{
						filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/burner-assembling-machine-shadow.png",
						width_in_frames = 1,
						height_in_frames = 1
					}
				}),
				priority = "high",
				width = 96,
				height = 96,
				frame_count = 32,
				draw_as_shadow = true,
				shift = util.by_pixel( 92, 0 ),
				hr_version =
				{
					stripes = util.multiplystripes( 32,
					{
						{
							filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/hr-burner-assembling-machine-shadow.png",
							width_in_frames = 1,
							height_in_frames = 1
						}
					}),
					priority = "high",
					width = 192,
					height = 192,
					frame_count = 32,
					draw_as_shadow = true,
					shift = util.by_pixel( 92, 0 ),
					scale = 0.5
				}
			}
		}
	},

	--Unlike the vanilla Assembling Machine 1, this has a limited ingredient set.  However, it also handles advanced crafting (egines and air filters).
	crafting_categories = { "crafting", "advanced-crafting" },
	crafting_speed = 0.5,
	ingredient_count = 3,

	--Consumes chemical fuel at a rate of 165 kW.
	--Produces 4 pollution.
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		effectivity = 1,
		fuel_inventory_size = 1,
		emissions_per_minute = 4,
		--There is a bug here that the color needs to be set outside of the light_flicker.
		--Thanks to Bilka for helping me out here.
		light_flicker = { intensity = 0, size = 0 }, color = { r = 0.0, g = 0.0, b = 0.0 },
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 5,
				position = util.by_pixel( 28, -46 ),
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "165kW",

	--Can recieve effects from Beacons.  This isn't realistic, but I added it for balancing reasons:
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },

	--Sounds:
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound =
		{
			{ filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 },
			{ filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 },
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 1.5,
	}
},
{
	type = "assembling-machine",
	name = "burner-assembling-machine-2",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-assembling-machine-2.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "burner-assembling-machine-2" },
	max_health = 250,
	corpse = "medium-remnants",
	resistances =
	{
		{ type = "fire", percent = 50 },
		{ type = "physical", percent = 20 }
	},
	collision_box = {{ -0.8, -0.8 }, { 0.8, 0.8 }},
	selection_box = {{ -1.0, -1.0 }, { 1.0, 1.0 }},
	fast_replaceable_group = "assembling-machine",
	animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/burner-assembling-machine-2.png",
				priority = "high",
				width = 64,
				height = 64,
				frame_count = 32,
				line_length = 8,
				shift = util.by_pixel( 0, 0 ),
				animation_speed = 0.5,
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-burner-assembling-machine-2.png",
					priority = "high",
					width = 128,
					height = 128,
					frame_count = 32,
					line_length = 8,
					shift = util.by_pixel( 0, 0 ),
					animation_speed = 0.5,
					scale = 0.5
				}
			},
			{
				stripes = util.multiplystripes( 32,
				{
					{
						filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/burner-assembling-machine-2-shadow.png",
						width_in_frames = 1,
						height_in_frames = 1
					}
				}),
				priority = "high",
				width = 64,
				height = 64,
				frame_count = 32,
				draw_as_shadow = true,
				shift = util.by_pixel( 60, 0 ),
				hr_version =
				{
					stripes = util.multiplystripes( 32,
					{
						{
							filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-2/hr-burner-assembling-machine-2-shadow.png",
							width_in_frames = 1,
							height_in_frames = 1
						}
					}),
					priority = "high",
					width = 128,
					height = 128,
					frame_count = 32,
					draw_as_shadow = true,
					shift = util.by_pixel( 60, 0 ),
					scale = 0.5
				}
			}
		}
	},

	--This is faster than the vanilla Assembling Machine 3, but it can handle only 2 ingredients:
	crafting_categories = { "crafting", "crafting-with-fluid" },
	crafting_speed = 2,
	--Was originally 1, changed to be 2 in LongerBurnerPhase version 1.1.1:
	ingredient_count = 2,

	--This Burner Assembling Machine can support barreling & unbarreling:
	fluid_boxes =
	{
		{
			production_type = "input",
			pipe_picture = bam2pipepictures(),
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type = "input", position = { 0.5, -1.5 }}},
			secondary_draw_orders = { north = -1 }
		},
		{
			production_type = "output",
			pipe_picture = bam2pipepictures(),
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = 1,
			pipe_connections = {{ type = "output", position = { -0.5, 1.5 }}},
			secondary_draw_orders = { north = -1 }
		},
		off_when_no_fluid_recipe = true
	},

	--Consumes chemical fuel at a rate of 500 kW
	--Produces 8 pollution.
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		fuel_inventory_size = 1,
		emissions_per_minute = 8,
		--There is a bug here that the color needs to be set outside of the light_flicker.
		--Thanks to Bilka for helping me out here.
		light_flicker = { intensity = 0, size = 0 }, color = { r = 0.0, g = 0.0, b = 0.0 },
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 10,
				position = util.by_pixel( 14, -29 ),
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "500kW",

	--Can recieve effects from Beacons.  This isn't realistic, but I added it for balancing reasons:
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },

	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound =
		{
			{ filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.8 },
			{ filename = "__base__/sound/assembling-machine-t2-2.ogg", volume = 0.8 },
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 1.5,
	},
},
{
	type = "assembling-machine",
	name = "burner-assembling-machine-3",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-assembling-machine-3.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "burner-assembling-machine-3" },
	max_health = 400,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	resistances =
	{
		{ type = "fire", percent = 50 },
		{ type = "physical", percent = 20 }
	},
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	fast_replaceable_group = "assembling-machine",
	animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-3/burner-assembling-machine-3.png",
				priority = "high",
				width = 96,
				height = 96,
				frame_count = 32,
				line_length = 8,
				shift = util.by_pixel( 0, 0 ),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-3/hr-burner-assembling-machine-3.png",
					priority = "high",
					width = 192,
					height = 192,
					frame_count = 32,
					line_length = 8,
					shift = util.by_pixel( 0, 0 ),
					scale = 0.5
				}
			},
			{
				stripes = util.multiplystripes( 32,
				{
					{
						filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/burner-assembling-machine-shadow.png",
						width_in_frames = 1,
						height_in_frames = 1
					}
				}),
				priority = "high",
				width = 96,
				height = 96,
				frame_count = 32,
				draw_as_shadow = true,
				shift = util.by_pixel( 92, 0 ),
				hr_version =
				{
					stripes = util.multiplystripes( 32,
					{
						{
							filename = "__LongerBurnerPhase__/Graphics/Entities/burner-assembling-machine-1/hr-burner-assembling-machine-shadow.png",
							width_in_frames = 1,
							height_in_frames = 1
						}
					}),
					priority = "high",
					width = 192,
					height = 192,
					frame_count = 32,
					draw_as_shadow = true,
					shift = util.by_pixel( 92, 0 ),
					scale = 0.5
				}
			},
		}
	},

	--This is comparable to the vanilla Assembling Machine 3 except that it doesn't use fluids:
	crafting_categories = { "crafting", "advanced-crafting" },
	crafting_speed = 1,
	--ingredient_count = unlimited,

	--Consumes chemical fuel at a rate of 350 kW
	--Produces 0.5 pollution (it's super low because it has an air filter).
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		effectivity = 1,
		fuel_inventory_size = 1,
		emissions_per_minute = 0.5,
		--There is a bug here that the color needs to be set outside of the light_flicker.
		--Thanks to Bilka for helping me out here.
		light_flicker = { intensity = 0, size = 0 }, color = { r = 0.0, g = 0.0, b = 0.0 },
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 3,
				position = util.by_pixel( 28, -46 ),
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "350kW",

	--Can recieve effects from Beacons.  This isn't realistic, but I added it for balancing reasons:
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },

	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound =
		{
			{ filename = "__base__/sound/assembling-machine-t3-1.ogg", volume = 0.8 },
			{ filename = "__base__/sound/assembling-machine-t3-2.ogg", volume = 0.8 },
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 1.5,
	}
},
{
	type = "assembling-machine",
	name = "eco-assembling-machine",
	icon = "__LongerBurnerPhase__/Graphics/Items/eco-assembling-machine.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "eco-assembling-machine" },
	max_health = 350,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	resistances = {{ type = "fire", percent = 70 }},
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	fast_replaceable_group = "assembling-machine",
	animation =
	{
		layers =
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-assembling-machine/eco-assembling-machine.png",
				priority = "high",
				width = 108,
				height = 110,
				frame_count = 32,
				line_length = 8,
				shift = util.by_pixel(0, 4),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-assembling-machine/hr-eco-assembling-machine.png",
					priority = "high",
					width = 214,
					height = 218,
					frame_count = 32,
					line_length = 8,
					shift = util.by_pixel(0, 4),
					scale = 0.5
				}
			},
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-assembling-machine/eco-assembling-machine-shadow.png",
				priority = "high",
				width = 98,
				height = 82,
				frame_count = 32,
				line_length = 8,
				draw_as_shadow = true,
				shift = util.by_pixel(12, 5),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-assembling-machine/hr-eco-assembling-machine-shadow.png",
					priority = "high",
					width = 196,
					height = 163,
					frame_count = 32,
					line_length = 8,
					draw_as_shadow = true,
					shift = util.by_pixel(12, 4.75),
					scale = 0.5
				}
			},
		},
	},

	--This is the same speed as the vanilla Assembling Machine 2, but it cannot handle crafting with fluids:
	crafting_categories = { "crafting", "advanced-crafting" },
	crafting_speed = 0.75,
	--ingredient_count = unlimited,

	--This is really special in that it produces no pollution!
	--Also, the module inside it reduces energy consumption.
	energy_source =
	{
		type = "electric",
		usage_priority = "secondary-input",
		emissions_per_minute = 0
	},
	energy_usage = "75kW",

	--Give it the same module slots as the Assembling Machine 2:
	module_specification = { module_slots = 2 },
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },

	--Sounds:
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound =
		{
			{ filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.8 },
			{ filename = "__base__/sound/assembling-machine-t2-2.ogg", volume = 0.8 },
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 1.5,
	}
}
})