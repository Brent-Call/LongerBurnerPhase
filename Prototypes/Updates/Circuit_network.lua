--In the options menu there is a setting to prevent burner entities from connecting to the circuit network:
if settings.startup[ "Q-longer-burner-phase-disallow-circuit-network" ].value == true then
	data.raw.inserter[ "burner-inserter" ].circuit_wire_max_distance = 0
	data.raw[ "mining-drill" ][ "burner-mining-drill" ].circuit_wire_max_distance = 0
	data.raw[ "mining-drill" ][ "advanced-burner-mining-drill" ].circuit_wire_max_distance = 0
	data.raw[ "mining-drill" ][ "burner-pumpjack" ].circuit_wire_max_distance = 0
	data.raw[ "offshore-pump" ][ "offshore-pump" ].circuit_wire_max_distance = 0
end