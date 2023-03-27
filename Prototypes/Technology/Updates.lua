require( "Library.Lib" )

--Create some shorthand ways to refer to technology costs:
--"bsp" stands for "Burner Science Pack" (i.e. from this mod) & "sp" stands for "Science Pack" (i.e. from the base game)
--I use table.deepcopy(...) to ensure that changes to one tech don't affect all of the others.
local bsp1 = {{ "burner-science-pack-1", 1 }}
local bsp12 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }}
local bsp12sp1 = {{ "burner-science-pack-1", 1 }, { "burner-science-pack-2", 1 }, { "automation-science-pack", 1 }}
local sp1 = {{ "automation-science-pack", 1 }}
local sp12 = {{ "automation-science-pack", 1 }, { "logistic-science-pack", 1 }}

data.raw.technology[ "automation" ].ignore_tech_cost_multiplier = false

--Change the science packs needed for certain items:
QLuaLibrary.change_tech_unit( "logistics",                    { count =  10, ingredients = table.deepcopy( bsp1 ),     time = 10 })
QLuaLibrary.change_tech_unit( "engine",                       { count = 100, ingredients = table.deepcopy( bsp12 ),    time = 15 })
QLuaLibrary.change_tech_unit( "steel-processing",             { count =  50, ingredients = table.deepcopy( bsp1  ),    time =  5 })
QLuaLibrary.change_tech_unit( "flammables",                   { count =  50, ingredients = table.deepcopy( bsp12 ),    time = 30 })
QLuaLibrary.change_tech_unit( "advanced-material-processing", { count =  75, ingredients = table.deepcopy( bsp12sp1 ), time = 20 })
QLuaLibrary.change_tech_unit( "automation-2",                 { count =  50, ingredients = table.deepcopy( sp12 ),     time = 10 })
QLuaLibrary.change_tech_unit( "automobilism",                 { count = 100, ingredients = table.deepcopy( bsp12sp1 ), time = 30 })
QLuaLibrary.change_tech_unit( "plastics",                     { count = 200, ingredients = table.deepcopy( bsp12sp1 ), time = 20 })
QLuaLibrary.change_tech_unit( "research-speed-1",             { count = 100, ingredients = table.deepcopy( bsp12    ), time = 30 })
QLuaLibrary.change_tech_unit( "fluid-handling",               { count =  50, ingredients = table.deepcopy( bsp12    ), time = 15 })
--Change the cost of the landfill technology to be easily unlocked at the early game:
QLuaLibrary.change_tech_unit( "landfill", { count = 50, ingredients = table.deepcopy( sp1 ), time = 30 })
--In previous versions of this mod, rocket fuel was made to cost only burner science packs, but in Factorio version 0.17.60, rocket fuel was moved behind chemical science packs.

--Add prerequisites:
QLuaLibrary.add_tech_prerequisite( "logistics", "burner-automation" )
QLuaLibrary.add_tech_prerequisite( "steel-processing", "burner-automation" )
QLuaLibrary.add_tech_prerequisite( "automation", "electricity" )
QLuaLibrary.add_tech_prerequisite( "optics", "electricity" )
QLuaLibrary.add_tech_prerequisite( "research-speed-2", "electronics" )
QLuaLibrary.add_tech_prerequisite( "research-speed-2", "logistic-science-pack" )
QLuaLibrary.add_tech_prerequisite( "logistic-science-pack", "automation" )
QLuaLibrary.add_tech_prerequisite( "advanced-electronics", "electronics" ) --In vanilla, Electronics is multiple steps higher up the tree.
QLuaLibrary.add_tech_prerequisite( "automation-3", "automation-2" ) --In vanilla, Automation 2 is higher up in the prerequisite chain, but things are shifted around due to LBP
QLuaLibrary.add_tech_prerequisite( "automation-3", "lubricant" ) --This is because LBP adds lubricant as an ingredient for the Assembling Machine 3 recipe.
--Compatibility with Simple Silicon mod:
if data.raw.technology[ "SiSi-silicon-processing" ] then
    QLuaLibrary.add_tech_prerequisite( "SiSi-silicon-processing", "logistic-science-pack" ) --Without LBP, this tech has the science pack higher up in the prerequisite chain.
else
    QLuaLibrary.add_tech_prerequisite( "advanced-electronics", "logistic-science-pack" ) --If the Simple Silicon mod is installed, then the tech tree is shifted around a bit
end

--Remove prerequisites:
QLuaLibrary.remove_tech_prerequisite( "engine", "logistic-science-pack" )
QLuaLibrary.remove_tech_prerequisite( "fluid-handling", "automation-2" )
--Change prerequisites:
data.raw.technology[ "flammables" ].prerequisites = { "burner-oil-processing" }
data.raw.technology[ "plastics" ].prerequisites = { "burner-oil-processing", "automation-science-pack" }
data.raw.technology[ "research-speed-1" ].prerequisites = { "burner-automation" }
data.raw.technology[ "oil-processing" ].prerequisites = { "burner-oil-processing", "logistic-science-pack" } --In vanilla it has only 1 prereq: fluid-handling
data.raw.technology[ "automobilism" ].prerequisites = { "logistics", "engine", "automation-science-pack" } --In the vanilla game it requires logistics-2 instead of plain old logistics
data.raw.technology[ "fluid-wagon" ].prerequisites = { "railway", "electric-engine" } --In the vanilla game it requires railway & fluid-handling
data.raw.technology[ "railway" ].prerequisites = { "logistics-2", "air-filtering" } --In the vanilla game it requires logistics-2 & engine
data.raw.technology[ "advanced-material-processing" ].prerequisites = { "steel-processing", "automation-science-pack" } --In the vanilla game it requires logistic science pack
data.raw.technology[ "landfill" ].prerequisites = { "automation-science-pack" } --In the vanilla game it requires logistic science pack

--Change effects of researching these technologies:
QLuaLibrary.add_tech_effect( "electric-engine", { type = "unlock-recipe", recipe = "pump" })
QLuaLibrary.add_tech_effect( "automation", { type = "unlock-recipe", recipe = "inserter" })
QLuaLibrary.add_tech_effect( "automation", { type = "unlock-recipe", recipe = "electric-mining-drill" })
QLuaLibrary.add_tech_effect( "engine", { type = "unlock-recipe", recipe = "burner-assembling-machine-2" })
QLuaLibrary.add_tech_effect( "stack-inserter", { type = "unlock-recipe", recipe = "uncraft-burner-inserters" })
QLuaLibrary.remove_tech_effect( "fluid-handling", { type = "unlock-recipe", recipe = "pump" })
QLuaLibrary.remove_tech_effect( "oil-processing", { type = "unlock-recipe", recipe = "basic-oil-processing" })
QLuaLibrary.remove_tech_effect( "oil-processing", { type = "unlock-recipe", recipe = "solid-fuel-from-petroleum-gas" })
--Compatibility with Burner Offshore Pump mod:
if data.raw.recipe[ "electric-offshore-pump" ] then
    QLuaLibrary.add_tech_effect( "electricity", { type = "unlock-recipe", recipe = "electric-offshore-pump" })
end

--Automatically add tech prerequisites to anything requiring Automation Science Packs, since this is a new technology added by my mod:
QLuaLibrary.globally_add_science_pack_tech_prerequisite( "automation-science-pack", "automation-science-pack" )

--This function sets the infer_icon property to false for effects that affect laboratories.
--@param effectsTable   A table where the values are ModifierPrototypes OR nil.
--                      If nil, this function does nothing.
--@return nil
local function process_effects_table( effectsTable )
    if effectsTable == nil then
        return
    end
    for _, effect in pairs( effectsTable ) do
        if effect.type == "laboratory-speed" or effect.type == "laboratory-productivity" then
            effect.infer_icon = false
        end
    end
end

--Iterate through all researches that affect lab research speed & make them not infer icon.
--We make no assumptions about whether or not the technology has normal or expensive mode.
for _, v in pairs( data.raw.technology ) do
    process_effects_table( v.effects )
    if v.normal then
        process_effects_table( v.normal.effects )
    end
    if v.expensive then
        process_effects_table( v.expensive.effects )
    end
end

--Change the default utility sprites for technology effects.
--We do this because we don't want the technologies to auto-infer using the first lab they see,
--because that is the burner lab, & I'd rather use the regular lab as the icon for that.
local LAB_PROTOTPYE = data.raw.lab[ "lab" ]
local icon = data.raw[ "utility-sprites" ].default.laboratory_speed_modifier_icon
icon.filename = LAB_PROTOTPYE.icon
icon.width = LAB_PROTOTPYE.icon_size
icon.height = LAB_PROTOTPYE.icon_size
icon.mipmap_count = LAB_PROTOTPYE.icon_mipmaps
icon = data.raw[ "utility-sprites" ].default.laboratory_productivity_modifier_icon
icon.filename = LAB_PROTOTPYE.icon
icon.width = LAB_PROTOTPYE.icon_size
icon.height = LAB_PROTOTPYE.icon_size
icon.mipmap_count = LAB_PROTOTPYE.icon_mipmaps