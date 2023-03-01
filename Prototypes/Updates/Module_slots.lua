--In the options menu there is a setting to allow module slots in some higher-tier burner devices:
if settings.startup[ "Q-longer-burner-phase-modules-in-burner-machines" ].value == true then
	data.raw[ "assembling-machine" ][ "burner-assembling-machine-2" ].module_specification = { module_slots = 1 }
	data.raw[ "assembling-machine" ][ "burner-assembling-machine-3" ].module_specification = { module_slots = 2 }
	data.raw[ "mining-drill" ][ "advanced-burner-mining-drill" ].module_specification = { module_slots = 3 }
	
	--The base productivity of an Advanced Burner Mining drill is 8% if the setting "Module slots for burner machines" is disabled.
	--The base productivity is 3% if the setting is enabled instead.
	data.raw[ "mining-drill" ][ "advanced-burner-mining-drill" ].base_productivity = 0.03
end