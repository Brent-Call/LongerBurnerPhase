require( "Prototypes.Updates.Burner_inserter" )
require( "Prototypes.Updates.Circuit_network" )
require( "Prototypes.Updates.Item_group" )
require( "Prototypes.Updates.Make_pollute" )
require( "Prototypes.Updates.Module_slots" )
require( "Prototypes.Updates.Pump" )
require( "Prototypes.Updates.Recipe" )
require( "Prototypes.Technology.Military_Updates" )
require( "Prototypes.Technology.Updates" )

--This function inserts the given recipe into the given module's limitation:
function insert_limitation( m, r )
	if data.raw.module[ m ] then
		if data.raw.module[ m ].limitation then
			table.insert( data.raw.module[ m ].limitation, r )
		end
	end
end

--This funcion inserts the given recipe into the productivity module limitation:
function insert_productivity_limitation( r )
	 --This should not casue an error even if all modules were removed from the game
	 --This should also be compatible with Bob's modules:
	 
	insert_limitation( "productivity-module",   r )
	insert_limitation( "productivity-module-2", r )
	insert_limitation( "productivity-module-3", r )
	insert_limitation( "productivity-module-4", r )
	insert_limitation( "productivity-module-5", r )
	insert_limitation( "productivity-module-6", r )
	insert_limitation( "productivity-module-7", r )
	insert_limitation( "productivity-module-8", r )
	
	insert_limitation( "raw-productivity-module", r )
	insert_limitation( "raw-productivity-module-2", r )
	insert_limitation( "raw-productivity-module-3", r )
	insert_limitation( "raw-productivity-module-4", r )
	insert_limitation( "raw-productivity-module-5", r )
	insert_limitation( "raw-productivity-module-6", r )
	insert_limitation( "raw-productivity-module-7", r )
	insert_limitation( "raw-productivity-module-8", r )
end
insert_productivity_limitation( "air-filter" )
insert_productivity_limitation( "burner-science-pack-1" )
insert_productivity_limitation( "burner-science-pack-2" )

--Now make the wooden chest provide a fuel value equal to that of its ingredients:
data.raw.item[ "wooden-chest" ].fuel_value = "4MJ"
data.raw.item[ "wooden-chest" ].fuel_category = "chemical"
--Do the same for the small electric pole:
data.raw.item[ "small-electric-pole" ].fuel_value = "1MJ"
data.raw.item[ "small-electric-pole" ].fuel_category = "chemical"