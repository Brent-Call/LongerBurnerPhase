--Make sure that burner & electric oil refineries & chemical plants can be fast-replaced:
if not data.raw[ "assembling-machine" ][ "oil-refinery" ].fast_replaceable_group then
	data.raw[ "assembling-machine" ][ "oil-refinery" ].fast_replaceable_group = "oil-refinery"
end
if not data.raw[ "assembling-machine" ][ "chemical-plant" ].fast_replaceable_group then
	data.raw[ "assembling-machine" ][ "chemical-plant" ].fast_replaceable_group = "chemical-plant"
end

data:extend({
{
	type = "assembling-machine",
	name = "burner-oil-refinery",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-oil-refinery.png",
	icon_size = 32,
	flags = { "placeable-neutral", "player-creation" },
	minable = { mining_time = 0.2, result = "burner-oil-refinery" },
	max_health = 350,
	resistances =
	{
		{ type = "fire", percent = 70 },
		{ type = "physical", percent = 20 },
		{ type = "impact", percent = 20 },
		{ type = "explosion", percent = 10 }
	},
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	collision_box = {{ -2.4, -2.4 }, { 2.4, 2.4 }},
	selection_box = {{ -2.5, -2.5 }, { 2.5, 2.5 }},
	fast_replaceable_group = data.raw[ "assembling-machine" ][ "oil-refinery" ].fast_replaceable_group,
	--In past versions, this carried backer names.  However, the API doesn't support it anymore.

	--=======================================================================
	--                         BURNER PROTOTYPE
	--=======================================================================
	--Outputs 8 pollution
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		effectivity = 1,
		fuel_inventory_size = 1,
		emissions_per_minute = 8,
		--There is a bug here that the color needs to be set outside of the light_flicker.
		--Thanks to Bilka for helping me out here.
		light_flicker = { intensity = 0, size = 0 }, color = { r = 0.0, g = 0.0, b = 0.0 }
		--No smoke
	},
	energy_usage = "275kW",
	--=======================================================================
	--                          APPEARANCE & SOUNDS
	--=======================================================================
	
	animation = make_4way_animation_from_spritesheet({ layers =
	{
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-oil-refinery/burner-oil-refinery.png",
			width = 337,
			height = 255,
			frame_count = 1,
			shift = { 2.515625, 0.484375 },
			hr_version =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-oil-refinery/hr-burner-oil-refinery.png",
				width = 386,
				height = 430,
				frame_count = 1,
				shift = util.by_pixel(0, -7.5),
				scale = 0.5
			}
		},
		{
			filename = "__base__/graphics/entity/oil-refinery/oil-refinery-shadow.png",
			width = 337,
			height = 213,
			frame_count = 1,
			shift = util.by_pixel(82.5, 26.5),
			draw_as_shadow = true,
			hr_version =
			{
				filename = "__base__/graphics/entity/oil-refinery/hr-oil-refinery-shadow.png",
				width = 674,
				height = 426,
				frame_count = 1,
				shift = util.by_pixel(82.5, 26.5),
				draw_as_shadow = true,
				scale = 0.5
				}
			}
		}
	}),

	working_visualisations = table.deepcopy( data.raw[ "assembling-machine" ][ "oil-refinery" ].working_visualisations ),
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound = { filename = "__base__/sound/oil-refinery.ogg" },
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 2.5,
	},
	--=======================================================================
	--                        CRAFTING INFORMATION
	--=======================================================================
	--Can recieve effects from Beacons.  This isn't realistic, but I added it for balancing reasons:
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },
	
	--Has 1 fluid input & 3 fluid outputs
	--Does oil processing at the same rate as the vanilla oil refinery
	crafting_categories = { "oil-processing" },
	crafting_speed = 1,
	--ingredient_count = unlimited,
	--The burner oil refinery has 1 input pipe & 3 output pipes:
	fluid_boxes =
	{
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { -1, 3 }}}
		},
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { 1, 3 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = { -2, -3 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = { 0, -3 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = { 2, -3 }}}
		}
	},
	pipe_covers = pipecoverspictures()
},
{
	type = "assembling-machine",
	name = "burner-chemical-plant",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-chemical-plant.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.1, result = "burner-chemical-plant" },
	max_health = 300,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	resistances =
	{
		{ type = "fire", percent = 50 }
	},
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	fast_replaceable_group = data.raw[ "assembling-machine" ][ "chemical-plant" ].fast_replaceable_group,
	--=======================================================================
	--                          APPEARANCE & SOUNDS
	--=======================================================================
	animation = make_4way_animation_from_spritesheet({ layers =
	{
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/burner-chemical-plant/burner-chemical-plant.png",
			width = 122,
			height = 134,
			frame_count = 1,
			shift = util.by_pixel(-5, -4.5),
			hr_version =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/burner-chemical-plant/hr-burner-chemical-plant.png",
				width = 244,
				height = 268,
				frame_count = 1,
				shift = util.by_pixel(-5, -4.5),
				scale = 0.5
			}
		},
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/eco-chemical-plant-shadow.png",
			width = 175,
			height = 141,
			frame_count = 1,
			shift = util.by_pixel( 31.5, 11 ),
			draw_as_shadow = true,
			hr_version =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-eco-chemical-plant-shadow.png",
				width = 350,
				height = 219,
				frame_count = 1,
				shift = util.by_pixel( 31.5, 10.75 ),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	}}),
	working_visualisations = table.deepcopy( data.raw[ "assembling-machine" ][ "chemical-plant" ].working_visualizations ),
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound = {{ filename = "__base__/sound/chemical-plant.ogg", volume = 0.8 }},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		apparent_volume = 1.5,
	},
	--=======================================================================
	--                         BURNER PROTOTYPE
	--=======================================================================
	--Outputs 5 pollution
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		effectivity = 1,
		fuel_inventory_size = 1,
		emissions_per_minute = 5,
		--There is a bug here that the color needs to be set outside of the light_flicker.
		--Thanks to Bilka for helping me out here.
		light_flicker = { intensity = 0, size = 0 }, color = { r = 0.0, g = 0.0, b = 0.0 },
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 3,
				north_position = util.by_pixel( 32, -16 ),
				south_position = util.by_pixel( -32, -40 ),
				east_position = util.by_pixel( -16, 8 ),
				west_position = util.by_pixel( 0, -40 ),
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "125kW",
	--=======================================================================
	--                        CRAFTING INFORMATION
	--=======================================================================
	--Can recieve effects from Beacons.  This isn't realistic, but I added it for balancing reasons:
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },
	
	--Same crafting stats as the vanilla chemical plant, except slower crafting speed:
	--Supports 2 fluid inputs & 2 fluid outputs:
	crafting_speed = 0.75,
	--ingredient_count = unlimited,
	crafting_categories = { "chemistry" },
	fluid_boxes =
	{
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { -1, -2 }}}
		},
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { 1, -2 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = {-1, 2 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
  			base_level = 1,
			pipe_connections = {{ position = {1, 2 }}}
		}
	}
},
{
	type = "assembling-machine",
	name = "eco-chemical-plant",
	icon = "__LongerBurnerPhase__/Graphics/Items/eco-chemical-plant.png",
	icon_size = 32,
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.1, result = "eco-chemical-plant" },
	max_health = 300,
	corpse = "medium-remnants",
	dying_explosion = "medium-explosion",
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	drawing_box = {{ -1.5, -1.9 }, { 1.5, 1.5 }},
	fast_replaceable_group = data.raw[ "assembling-machine" ][ "chemical-plant" ].fast_replaceable_group,
	
	--=======================================================================
	--                        CRAFTING INFORMATION
	--=======================================================================
	--Same number of module slots as the vanilla Chemical Plant
	module_specification = { module_slots = 3 },
	allowed_effects = {"consumption", "speed", "productivity", "pollution"},
	crafting_speed = 1,
	--ingredient_count = unlimited,
	crafting_categories = { "chemistry" },
	fluid_boxes =
	{
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { -1, -2 }}}
		},
		{
			production_type = "input",
			pipe_covers = pipecoverspictures(),
			base_area = 10,
			base_level = -1,
			pipe_connections = {{ type="input", position = { 1, -2 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = { -1, 2 }}}
		},
		{
			production_type = "output",
			pipe_covers = pipecoverspictures(),
			base_level = 1,
			pipe_connections = {{ position = { 1, 2 }}}
		}
	},
	
	--=======================================================================
	--                             VISUALS
	--=======================================================================
	animation = make_4way_animation_from_spritesheet({ layers =
	{
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/eco-chemical-plant.png",
			width = 122,
			height = 134,
			frame_count = 1,
			shift = util.by_pixel( -5, -4.5 ),
			hr_version =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-eco-chemical-plant.png",
				width = 244,
				height = 268,
				frame_count = 1,
				shift = util.by_pixel( -5, -4.5 ),
				scale = 0.5
			}
		},
		{
			filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/eco-chemical-plant-shadow.png",
			width = 175,
			height = 141,
			frame_count = 1,
			shift = util.by_pixel( 31.5, 11 ),
			draw_as_shadow = true,
			hr_version =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-eco-chemical-plant-shadow.png",
				width = 350,
				height = 219,
				frame_count = 1,
				shift = util.by_pixel( 31.5, 10.75 ),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	}}),
	working_visualisations =
	{
		{
			north_position = util.by_pixel( 30, -24 ),
			west_position = util.by_pixel( 1, -49.5 ),
			south_position = util.by_pixel( -30, -48 ),
			east_position = util.by_pixel( -11, -1 ),
			apply_recipe_tint = "primary",
			animation =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/boiling-green-patch.png",
				frame_count = 32,
				width = 15,
				height = 10,
				animation_speed = 0.5,
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-boiling-green-patch.png",
					frame_count = 32,
					width = 30,
					height = 20,
					animation_speed = 0.5,
					scale = 0.5
				}
			}
		},
		{
			north_position = util.by_pixel( 30, -24 ),
			west_position = util.by_pixel( 1, -49.5 ),
			south_position = util.by_pixel( -30, -48 ),
			east_position = util.by_pixel( -11, -1 ),
			apply_recipe_tint = "secondary",
			animation =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/boiling-green-patch-mask.png",
				frame_count = 32,
				width = 15,
				height = 10,
				animation_speed = 0.5,
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-boiling-green-patch-mask.png",
					frame_count = 32,
					width = 30,
					height = 20,
					animation_speed = 0.5,
					scale = 0.5
				}
			}
		},
		{
			apply_recipe_tint = "tertiary",
			north_position = { 0, 0 },
			west_position =  { 0, 0 },
			south_position = { 0, 0 },
			east_position =  { 0, 0 },
			north_animation =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/boiling-window-green-patch.png",
				frame_count = 1,
				width = 87,
				height = 60,
				shift = util.by_pixel( 0, -5 ),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-boiling-window-green-patch.png",
					x = 0,
					frame_count = 1,
					width = 174,
					height = 119,
					shift = util.by_pixel( 0, -5.25 ),
					scale = 0.5
				}
			},
			east_animation =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/boiling-window-green-patch.png",
				x = 87,
				frame_count = 1,
				width = 87,
				height = 60,
				shift = util.by_pixel( 0, -5 ),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-boiling-window-green-patch.png",
					x = 174,
					frame_count = 1,
					width = 174,
					height = 119,
					shift = util.by_pixel( 0, -5.25 ),
					scale = 0.5
				}
			},
			south_animation =
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/boiling-window-green-patch.png",
				x = 174,
				frame_count = 1,
				width = 87,
				height = 60,
				shift = util.by_pixel( 0, -5 ),
				hr_version =
				{
					filename = "__LongerBurnerPhase__/Graphics/Entities/eco-chemical-plant/hr-boiling-window-green-patch.png",
					x = 348,
					frame_count = 1,
					width = 174,
					height = 119,
					shift = util.by_pixel( 0, -5.25 ),
					scale = 0.5
				}
			}
		}
	},
	--=======================================================================
	--                              SOUNDS
	--=======================================================================
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound =
	{
		sound = {{ filename = "__base__/sound/chemical-plant.ogg", volume = 0.8 }},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
		--apparent_volume for the base Chemical Plant is 1.5
		--This one is a quieter design (more advanced technology).
		apparent_volume = 1.0
	},
	
	--=======================================================================
	--                           ENERGY USAGE
	--=======================================================================
	--This one consumes only half as much energy as the vanilla Chemical Plant, & it produces 0 pollution.
	energy_source =
	{
		type = "electric",
		usage_priority = "secondary-input",
		emissions_per_minute = 0
	},
	energy_usage = "105kW"
}
})