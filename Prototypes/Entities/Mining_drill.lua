function overlay_stone_furnace1()
	local stoneFurnacePicture = table.deepcopy( data.raw.furnace[ "stone-furnace" ].animation.layers[ 1 ])
	stoneFurnacePicture.stripes = util.multiplystripes( 40,
		{
			{
				filename = stoneFurnacePicture.filename,
				width_in_frames = 1,
				height_in_frames = 1
			}
		})
	stoneFurnacePicture.frame_count = 40
	stoneFurnacePicture.filename = nil
	
	stoneFurnacePicture.hr_version.stripes = util.multiplystripes( 40,
		{
			{
				filename = stoneFurnacePicture.hr_version.filename,
				width_in_frames = 1,
				height_in_frames = 1
			}
		})
	stoneFurnacePicture.hr_version.frame_count = 40
	stoneFurnacePicture.hr_version.filename = nil
	
	return stoneFurnacePicture
end
function overlay_stone_furnace2()
	local stoneFurnacePicture = table.deepcopy( data.raw.furnace[ "stone-furnace" ].animation.layers[ 2 ])
	stoneFurnacePicture.stripes = util.multiplystripes( 40,
		{
			{
				filename = stoneFurnacePicture.filename,
				width_in_frames = 1,
				height_in_frames = 1
			}
		})
	stoneFurnacePicture.frame_count = 40
	stoneFurnacePicture.filename = nil
	
	stoneFurnacePicture.hr_version.stripes = util.multiplystripes( 40,
		{
			{
				filename = stoneFurnacePicture.hr_version.filename,
				width_in_frames = 1,
				height_in_frames = 1
			}
		})
	stoneFurnacePicture.hr_version.frame_count = 40
	stoneFurnacePicture.hr_version.filename = nil
	return stoneFurnacePicture
end

--Make the burner pumjack fast-replaceable with the electric pumpjack:
if not data.raw[ "mining-drill" ][ "pumpjack" ].fast_replaceable_group then
	data.raw[ "mining-drill" ][ "pumpjack" ].fast_replaceable_group = "pumpjack"
end

--This is the circuit connector definition for the Advanced Burner Mining Drill:
circuit_connector_definitions[ "advanced-burner-mining-drill" ] = circuit_connector_definitions.create
(
  universal_connector_template,
  {
    { variation = 26, main_offset = util.by_pixel( 3, 4 ), shadow_offset = util.by_pixel( 3, 4 ), show_shadow = true },
    { variation = 26, main_offset = util.by_pixel( 3, 4 ), shadow_offset = util.by_pixel( 3, 4 ), show_shadow = true },
    { variation = 26, main_offset = util.by_pixel( 3, 4 ), shadow_offset = util.by_pixel( 3, 4 ), show_shadow = true },
    { variation = 26, main_offset = util.by_pixel( 3, 4 ), shadow_offset = util.by_pixel( 3, 4 ), show_shadow = true },
  }
)

--Stands for get ADVanced Burner Mining Drill PICtureS:
function get_adv_bmd_pics_base()
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/advanced-burner-mining-drill/advanced-burner-mining-drill-base.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 128,
		height = 128,
		frame_count = 16,
	}
end
function get_adv_bmd_pics_shadow()
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/advanced-burner-mining-drill/advanced-burner-mining-drill-shadow.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 104,
		height = 64,
		frame_count = 16,
		shift = util.by_pixel( 44, 0 ),
		draw_as_shadow = true
	}
end
function get_adv_bmd_pics_top()
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__LongerBurnerPhase__/Graphics/Entities/advanced-burner-mining-drill/advanced-burner-mining-drill-top.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 64,
		height = 96,
		frame_count = 16,
		shift = util.by_pixel( 0, -16 )
	}
end
function get_adv_bmd_pics_spinning_wheels()
	return 
	{
		filename = "__LongerBurnerPhase__/Graphics/Entities/advanced-burner-mining-drill/advanced-burner-mining-drill-wheels.png",
		priority = "extra-high",
		width = 64,
		height = 64,
		line_length = 4,
		frame_count = 16,
		animation_speed = 0.5,
		shift = util.by_pixel( 0, -32 )
	}
end
function get_adv_bmd_pipe_pics_up( xShift, yShift )
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 16,
		--direction_count = 1,
		shift = { xShift, yShift }
	}
end
function get_adv_bmd_pipe_pics_down( xShift, yShift )
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 16,
		--direction_count = 1,
		shift = { xShift, yShift }
	}
end
function get_adv_bmd_pipe_pics_left( xShift, yShift )
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 16,
		--direction_count = 1,
		shift = { xShift, yShift }
	}
end
function get_adv_bmd_pipe_pics_right( xShift, yShift )
	return
	{
		stripes = util.multiplystripes( 16,
		{
			{
				filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
				width_in_frames = 1,
				height_in_frames = 1
			}
		}),
		priority = "extra-high",
		width = 64,
		height = 64,
		frame_count = 16,
		--direction_count = 1,
		shift = { xShift, yShift }
	}
end

data:extend({
{
	type = "mining-drill",
	name = "advanced-burner-mining-drill",
	icon = "__LongerBurnerPhase__/Graphics/Items/advanced-burner-mining-drill.png",
	icon_size = 32,
	flags = { "placeable-neutral", "player-creation" },
	--The type of resources this mining drill supports:
	--It supports the same categories as the vanilla Burner Mining Drill:
	resource_categories = { "basic-solid" },
	minable = { mining_time = 0.5, result = "advanced-burner-mining-drill" },
	max_health = 550,
	resistances =
	{
		{ type = "fire", percent = 50 },
		{ type = "physical", percent = 20 }
	},
	corpse = "big-remnants",
	collision_box = {{ -1.8, -1.8 }, { 1.8, 1.8 }},
	selection_box = {{ -2, -2 }, { 2, 2 }},
	--Has a 100% chance of dropping a stone brick when killed.
	--This is one of the stone bricks that was used to craft it.
	--Why did I add this?  I don't know.
	loot = {{ item = "stone-brick", count_min = 1, count_max = 1, probability = 1 }},
		
	input_fluid_box =
	{
		production_type = "input-output",
		pipe_picture = assembler2pipepictures(),
		pipe_covers = pipecoverspictures(),
		base_area = 1,
		height = 2,
		base_level = -1,
		pipe_connections =
		{
			{ position = { -2.5, -0.5 }},
			{ position = { -2.5,  0.5 }},
			{ position = {  2.5, -0.5 }},
			{ position = {  2.5,  0.5 }},
			{ position = { -0.5,  2.5 }},
			{ position = {  0.5,  2.5 }},
		}
	},
	
	--This drill is better at mining than the Electric Mining Drill:
	mining_speed = 1.25,
	mining_power = 4,
	
	working_sound =
	{
		sound = { filename = "__base__/sound/burner-mining-drill.ogg", volume = 0.9 },
	},
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	--The Advanced Burner Mining Drill has a more efficient burner because it has a Steel Furnace inside instead of a Stone Furnace.
	--However, because the effeciency was simplified in version 0.17, I decided to remove effeciency from this as well--and change the numbers to match.
	--It outputs less pollution than one might expect because it contains an Air Filter.
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		fuel_inventory_size = 1,
		emissions_per_minute = 3,
		smoke =
		{
			{
				name = "smoke",
				north_position = { 0.21, -1.7 },
				south_position = { 0.21, -1.7 },
				east_position = { 0.21, -1.7 },
				west_position = { 0.21, -1.7 },
				deviation = { 0.1, 0.1 },
				frequency = 4,
				starting_vertical_speed = 0.08
			}
		}
	},
	--It outputs 3 pollution.
	--The formula for pollution is { p = e * u } where:
	--p = pollution
	--e = energy_source.emissions
	--u = energy_usage (in kW)
	energy_usage = "450kW",
	monitor_visualization_tint = { r = 78, g = 173, b = 255 },
	fast_replaceable_group = "mining-drill",
	resource_searching_radius = 3.99,
	vector_to_place_result = { -0.5, -2.25 },
	
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },
	
	--The base productivity of an Advanced Burner Mining drill is 8% if the setting "Module slots for burner machines" is disabled.
	--The base productivity is 3% if the setting is enabled instead.
	base_productivity = 0.08,
	
	--The drill is 4x4, and its radius is 8x8.
	radius_visualisation_picture =
	{
		filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
		width = 12,
		height = 12
	},
	
	--A lot of the graphics are the same for the dry mining & wet mining graphics sets.
	graphics_set =
	{
		animation =
		{
			layers = 
			{
				get_adv_bmd_pics_base(),
				get_adv_bmd_pics_shadow(),
				get_adv_bmd_pics_top(),
				get_adv_bmd_pics_spinning_wheels()
			}
		}
	},
	wet_mining_graphics_set =
	{
		animation =
		{
			north =
			{
				layers = 
				{
					--Base
					get_adv_bmd_pics_base(),
					--Fluidbox inputs; uses the same graphics as the pipe-to-ground entity:
					--Fluidbox inputs are defined separately for each direction:
					get_adv_bmd_pipe_pics_down( 0.5, 1.5 ),
					get_adv_bmd_pipe_pics_down( -0.5, 1.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, -0.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, 0.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, -0.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, 0.5 ),
					--Shadow
					get_adv_bmd_pics_shadow(),
					--Top
					get_adv_bmd_pics_top(),
					--Spinning wheels
					get_adv_bmd_pics_spinning_wheels()
				}
			},
			south =
			{
				layers = 
				{
					--Base
					get_adv_bmd_pics_base(),
					--Fluidbox inputs; uses the same graphics as the pipe-to-ground entity:
					--Fluidbox inputs are defined separately for each direction:
					get_adv_bmd_pipe_pics_up( 0.5, -1.5 ),
					get_adv_bmd_pipe_pics_up( -0.5, -1.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, -0.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, 0.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, -0.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, 0.5 ),
					--Shadow
					get_adv_bmd_pics_shadow(),
					--Top
					get_adv_bmd_pics_top(),
					--Spinning wheels
					get_adv_bmd_pics_spinning_wheels()
				}
			},
			east =
			{
				layers = 
				{
					--Base
					get_adv_bmd_pics_base(),
					--Fluidbox inputs; uses the same graphics as the pipe-to-ground entity:
					--Fluidbox inputs are defined separately for each direction:
					get_adv_bmd_pipe_pics_down( 0.5, 1.5 ),
					get_adv_bmd_pipe_pics_down( -0.5, 1.5 ),
					get_adv_bmd_pipe_pics_up( 0.5, -1.5 ),
					get_adv_bmd_pipe_pics_up( -0.5, -1.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, -0.5 ),
					get_adv_bmd_pipe_pics_left( -1.5, 0.5 ),
					--Shadow
					get_adv_bmd_pics_shadow(),
					--Top
					get_adv_bmd_pics_top(),
					--Spinning wheels
					get_adv_bmd_pics_spinning_wheels()
				}
			},
			west =
			{
				layers = 
				{
					--Base
					get_adv_bmd_pics_base(),
					--Fluidbox inputs; uses the same graphics as the pipe-to-ground entity:
					--Fluidbox inputs are defined separately for each direction:
					get_adv_bmd_pipe_pics_up( 0.5, -1.5 ),
					get_adv_bmd_pipe_pics_up( -0.5, -1.5 ),
					get_adv_bmd_pipe_pics_down( 0.5, 1.5 ),
					get_adv_bmd_pipe_pics_down( -0.5, 1.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, -0.5 ),
					get_adv_bmd_pipe_pics_right( 1.5, 0.5 ),
					--Shadow
					get_adv_bmd_pics_shadow(),
					--Top
					get_adv_bmd_pics_top(),
					--Spinning wheels
					get_adv_bmd_pics_spinning_wheels()
				}
			},
		}
	},
	
	--Uses custom circuit connector definitions:
	circuit_wire_connection_points = circuit_connector_definitions[ "advanced-burner-mining-drill" ].points,
	circuit_connector_sprites = circuit_connector_definitions[ "advanced-burner-mining-drill" ].sprites,
	circuit_wire_max_distance = default_circuit_wire_max_distance
},
{
	type = "mining-drill",
	name = "burner-pumpjack",
	icon = "__LongerBurnerPhase__/Graphics/Items/burner-pumpjack.png",
	icon_size = 64,
	flags = { "placeable-neutral", "player-creation" },
	--The type of resources this mining drill supports:
	--It supports the same categories as the vanilla Pumpjack:
	resource_categories = { "basic-fluid" },
	minable = { mining_time = data.raw[ "mining-drill" ][ "pumpjack" ].minable.mining_time, result = "burner-pumpjack" },
	max_health = 200,
	resistances =
	{
		{ type = "fire", percent = 50 },
		{ type = "physical", percent = 20 }
	},
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
	selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
	fast_replaceable_group = data.raw[ "mining-drill" ][ "pumpjack" ].fast_replaceable_group,
	
	output_fluid_box =
	{
		base_area = 1,
		base_level = 1,
		pipe_covers = pipecoverspictures(),
		pipe_connections = {{ positions = {{ 1, -2 }, { 2, -1 }, { -1, 2 }, { -2, 1 }}}},
	},
	
	--This is slower than the vanilla Pumpjack:
	mining_speed = 0.8,
	
	working_sound =
	{
		sound = { filename = "__base__/sound/pumpjack.ogg" },
		apparent_volume = 1.5,
	},
	vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	
	--Has same energy consumption & pollution stats as the vanilla burner mining drill.
	energy_source =
	{
		type = "burner",
		fuel_category = "chemical",
		fuel_inventory_size = 1,
		emissions_per_minute = 12,
		smoke =
		{
			{
				name = "smoke",
				deviation = { 0.1, 0.1 },
				frequency = 9,
				north_position = { 0.0, -0.8 },
				south_position = { 0.0, -0.8 },
				east_position =  { 0.0, -0.8 },
				west_position =  { 0.0, -0.8 },
				starting_vertical_speed = 0.08,
				starting_frame_deviation = 60
			}
		}
	},
	energy_usage = "150kW",
	
	allowed_effects = { "consumption", "speed", "productivity", "pollution" },
	
	monitor_visualization_tint = { r = 78, g = 173, b = 255 },
	fast_replaceable_group = "pumpjack",
	resource_searching_radius = 0.49,
	vector_to_place_result = { -0, 0 },
	
	radius_visualisation_picture =
	{
		filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
		width = 12,
		height = 12
	},
	
	base_render_layer = "lower-object-above-shadow",
	base_picture = table.deepcopy( data.raw[ "mining-drill" ][ "pumpjack" ].base_picture ),
	animations = table.deepcopy( data.raw[ "mining-drill" ][ "pumpjack" ].animations ),
	
	circuit_wire_connection_points = circuit_connector_definitions[ "pumpjack" ].points,
	circuit_connector_sprites = circuit_connector_definitions[ "pumpjack" ].sprites,
	circuit_wire_max_distance = default_circuit_wire_max_distance
}
})

table.insert( data.raw[ "mining-drill" ][ "burner-pumpjack" ].animations.north.layers, overlay_stone_furnace1())
table.insert( data.raw[ "mining-drill" ][ "burner-pumpjack" ].animations.north.layers, overlay_stone_furnace2())