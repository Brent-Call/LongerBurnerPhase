--MilitarySupply_GUI_Style.lua
--This file contains GUI styles specifically for the Military Supply scenario.

--This frame_style is used for a light-gray colored inner frame with padding along the edges & vertical spacing
--on the elements inside.
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:inside_shallow_frame_with_padding_and_spacing" ] =
{
	type = "frame_style",
	parent = "inside_shallow_frame_with_padding",
	
	vertical_flow_style =
	{
		type = "vertical_flow_style",
		--Add extra space between items:
		vertical_spacing = 4
	}
}
--This is used for the draggable space in the titlebar of a GUI:
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:titlebar_draggable_space" ] =
{
	type = "empty_widget_style",
	parent = "draggable_space_header",
	height = 24,
	horizontally_stretchable = "on"
}
--This is used for the draggable space in the footer of a GUI such as a dialog box:
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:footer_draggable_space" ] =
{
	type = "empty_widget_style",
	parent = "draggable_space_header",
	height = 32,
	horizontally_stretchable = "on"
}
--This is used for a slot button that's 64x64 pixels.
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:slot_button_64px" ] =
{
	type = "button_style",
	parent = "slot_button",
	size = 64
}
--This is used for a horizontal flow with extra spacing that keeps things centered.
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:score_gui_centering_flow" ] =
{
	type = "horizontal_flow_style",
	parent = "centering_horizontal_flow",
	horizontal_spacing = 16,
	horizontally_stretchable = "on"
}
--This is used for a shallow frame with padding but no horizontal stretching.
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:score_gui_compact_inside_frame" ] =
{
	type = "frame_style",
	parent = "inside_shallow_frame_with_padding",
	horizontally_stretchable = "off"
}
--This is used for the table of available upgrades in the Shop GUI.
data.raw[ "gui-style" ].default[ "Q-LongerBurnerPhase:shop-gui-table" ] =
{
	type = "table_style",
	right_cell_padding = 4,
	column_widths =
	{
		{
			column = 1, --Sprite buttons
			width = 40
		},
		{
			column = 2, --Effects of upgrade
			minimal_width = 160
		},
		{
			column = 3, --Cost of upgrade
			minimal_width = 40
		}
	}
}