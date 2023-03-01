--Burner Inserters actually cannot pollute, since the game engine does not support it.
--data.raw.inserter[ "burner-inserter" ].energy_source.emissions_per_minute = 0.12

--Make cars pollute:
data.raw.car[ "car" ].burner.emissions_per_minute = 1.5

--Make tanks pollute:
data.raw.car[ "tank" ].burner.emissions_per_minute = 6

--Instead of making trains pollute, I'll make them require air filters in the file Recipe.lua
--But here, I'll make them not emit smoke.  The idea is that they are very efficient, and what little pollution they produce is absorbed by the air filters.
data.raw.locomotive[ "locomotive" ].burner.smoke = nil