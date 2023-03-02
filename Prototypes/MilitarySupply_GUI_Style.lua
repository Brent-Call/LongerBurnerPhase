--This file contains the style for the MilitarySupply gui:
data.raw[ "gui-style" ].default[ "military-supply-flow" ] =
{
	type = "vertical_flow_style",
	parent = "vertical_flow",
	
	--Remove extra space between items:
	vertical_spacing = 0
}
data.raw[ "gui-style" ].default[ "military-supply-objectives-frame" ] =
{
	type = "frame_style",
	parent = "frame",
	--Make the caption font orange:
	font_color = default_orange_color,
	
	--Cut all spacing values in half or approximately so:
	title_bottom_padding = 8,
	top_padding = data.raw[ "gui-style" ].default[ "frame" ].top_padding / 2,
	bottom_padding = data.raw[ "gui-style" ].default[ "frame" ].bottom_padding / 2,
	left_padding = data.raw[ "gui-style" ].default[ "frame" ].left_padding / 2,
	right_padding = data.raw[ "gui-style" ].default[ "frame" ].right_padding / 2,
}

data.raw[ "gui-style" ].default[ "inside_shallow_frame_with_padding_and_spacing" ] =
{
	type = "vertical_frame_style",
	parent = "inside_shallow_frame",
	
	--Add extra space between items:
	vertical_spacing = 4
}