--Make the burner inserter just as fast as the regular one:
data.raw.inserter[ "burner-inserter" ].extension_speed = data.raw.inserter[ "inserter" ].extension_speed
data.raw.inserter[ "burner-inserter" ].rotation_speed = data.raw.inserter[ "inserter" ].rotation_speed

--Actually, Inserters of any type cannot produce pollution; the game engine does not support it.
--See the file Make_pollute.lua for the code that makes burner inserters produce pollution, but no smoke.