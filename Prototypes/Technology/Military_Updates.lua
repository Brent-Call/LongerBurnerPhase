require( "Library.Lib" )

--Create some shorthand ways to refer to technology costs:
--"bsp" stands for "Burner Science Pack" (i.e. from this mod) & "sp" stands for "Science Pack" (i.e. from the base game)
--I use table.deepcopy(...) to ensure that changes to one tech don't affect all of the others.
local bsp1 = {{ "burner-science-pack-1", 1 }}
local bsp12 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }}
local bsp12sp1 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }, { "automation-science-pack", 1 }}
local sp1 = {{ "automation-science-pack", 1 }}
local sp12 = {{ "automation-science-pack", 1 }, { "logistic-science-pack", 1 }}

--Change these essential technologies to be more in line with my mod:
QLuaLibrary.change_tech_unit( "gun-turret", { count = 10, ingredients = table.deepcopy( bsp1 ), time = 10 })
QLuaLibrary.change_tech_unit( "military", { count = 10, ingredients = table.deepcopy( bsp1 ), time = 15 })
QLuaLibrary.change_tech_unit( "military-2", { count = 20, ingredients = table.deepcopy( sp1 ), time = 15 })
QLuaLibrary.change_tech_unit( "heavy-armor", { count = 30, ingredients = table.deepcopy( bsp12 ), time = 20 })
QLuaLibrary.change_tech_unit( "stone-wall", { count = 10, ingredients = table.deepcopy( bsp1 ), time = 10 })

--Change some prerequisites in the tech tree to be in line with this mod:
QLuaLibrary.add_tech_prerequisite( "military", "burner-automation" )
QLuaLibrary.add_tech_prerequisite( "military-science-pack", "logistic-science-pack" )
QLuaLibrary.add_tech_prerequisite( "stone-walls", "military" )
QLuaLibrary.add_tech_prerequisite( "gun-turret", "military" )
QLuaLibrary.add_tech_prerequisite( "gate", "logistic-science-pack" )
QLuaLibrary.add_tech_prerequisite( "stronger-explosives-1", "logistic-science-pack" )
data.raw.technology[ "military-2" ].prerequisites = { "gun-turret", "steel-processing", "automation-science-pack" } --In vanilla, it is military, steel-processing, & logistic-science-pack