require( "Prototypes.Entities.Assembling_machine" )
require( "Prototypes.Entities.Lab" )
require( "Prototypes.Entities.MilitarySupply" )
require( "Prototypes.Entities.Mining_drill" )
require( "Prototypes.Entities.Oil_and_chemistry" )
require( "Prototypes.Items.Item" )
require( "Prototypes.Items.MilitarySupply" )
require( "Prototypes.Items.Science" )
require( "Prototypes.Recipes.MilitarySupply" )
require( "Prototypes.Recipes.Recipe" )
require( "Prototypes.Recipes.Science" )
require( "Prototypes.Technology.Technology" )
require( "Prototypes.MilitarySupply_GUI_Style" )
require( "Prototypes.Military_Supply_sprites" )
--This mod adds 3 new achievements to complete!  Enjoy!
require( "Prototypes.Achievement" )

--Order these items so that they're in the order I want:
local items = data.raw.item
items[ "burner-mining-drill" ].order = "a[ items ]-a[ burner-mining-drill ]"
items[ "advanced-burner-mining-drill" ].order = "a[ items ]-b[ advanced-burner-mining-drill ]"
items[ "electric-mining-drill" ].order = "a[ items ]-c[ electric-mining-drill ]"
items[ "offshore-pump" ].order = "b[ fluids ]-a[ offshore_pump ]"
items[ "burner-pumpjack" ].order = "b[ fluids ]-b[ burner-pumpjack ]"
items[ "pumpjack" ].order = "b[ fluids ]-c[ pumpjack ]"