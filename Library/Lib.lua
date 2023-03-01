if not QLuaLibrary then
	QLuaLibrary = {}
end

--This function will disable any recipe.
--It is useful to make certain vanilla recipes unlockable by technology:
function QLuaLibrary.disable_recipe( recipeName )
	local recipe = data.raw.recipe[ recipeName ]
	
	--If the recipe does not exist, then skip all of this!
	if not recipe then
		error( "Bad argument 'recipeName' in QLuaLibrary function 'disable_recipe(...)'" )
		return
	end
	--Else, the recipe exists:
	
	--If there's a difference between normal & expensive, then disable both modes, otherwise disable normally:
	if recipe.normal then
		recipe.normal.enabled = false
		recipe.expensive.enabled = false
	else
		recipe.enabled = false
	end
end

--This function will enable any recipe.
--It is useful to make any recipe unlocked at game start:
function QLuaLibrary.enable_recipe( recipeName )
	local recipe = data.raw.recipe[ recipeName ]
	
	--If the recipe does not exist, then skip all of this!
	if not recipe then
		error( "Bad argument 'recipeName' in QLuaLibrary function 'enable_recipe(...)'" )
		return
	end
	--Else, the recipe exists:
	
	--If there's a difference between normal & expensive, then disable both modes, otherwise disable normally:
	if recipe.normal then
		recipe.normal.enabled = true
		recipe.expensive.enabled = true
	else
		recipe.enabled = true
	end
end

--Adds the ingredient to the specified recipe:
function QLuaLibrary.add_recipe_ingredient( recipeName, ingredient, normalQty, expensiveQty )
	local recipe = data.raw.recipe[ recipeName ]
	
	--If the recipe does not exist, then skip all of this!
	if not recipe then
		error( "Bad argument 'recipeName' in QLuaLibrary function 'add_recipe_ingredient(...)'" )
		return
	end
	--Else, the recipe exists:
	
	--If there's a difference between normal & expensive, then disable both modes, otherwise disable normally:
	if recipe.normal then
		table.insert( recipe.normal.ingredients, { ingredient, normalQty })
		table.insert( recipe.expensive.ingredients, { ingredient, expensiveQty })
	else
		table.insert( recipe.ingredients, { ingredient, normalQty })
	end
end

--Removes the requested ingredient from the specified recipe:
function QLuaLibrary.remove_recipe_ingredient( recipeName, ingredient )
	local recipe = data.raw.recipe[ recipeName ]
	
	--If the recipe does not exist, then skip all of this!
	if not recipe then
		error( "Bad argument 'recipeName' in QLuaLibrary function 'remove_recipe_ingredient(...)'" )
		return
	end
	--Else, the recipe exists:
	
	--If there's a difference between normal & expensive, then disable both modes, otherwise disable normally:
	if recipe.normal then
		for k, v in pairs( recipe.normal.ingredients ) do
			if v[ 1 ] == ingredient then
				recipe.normal.ingredients[ k ] = nil
				break
			end
		end
		for k, v in pairs( recipe.expensive.ingredients ) do
			if v[ 1 ] == ingredient then
				recipe.expensive.ingredients[ k ] = nil
				break
			end
		end
	else
		for k, v in pairs( recipe.ingredients ) do
			if v[ 1 ] == ingredient then
				recipe.ingredients[ k ] = nil
				break
			end
		end
	end
end


function QLuaLibrary.replace_recipe_ingredient( recipeName, old, new )
	local recipe = data.raw.recipe[ recipeName ]
	if not recipe then
		error( "Bad argument 'recipeName' in QLuaLibrary function 'replace_recipe_ingredient(...)'" )
	end
	--Else, A-OK
	if recipe.ingredients then
		for _, v in pairs( recipe.ingredients ) do
			if v[ 1 ] == old then
				v[ 1 ] = new
			end
		end
	end
	if recipe.normal and recipe.normal.ingredients then
		for _, v in pairs( recipe.normal.ingredients ) do
			if v[ 1 ] == old then
				v[ 1 ] = new
			end
		end
	end
	if recipe.expensive and recipe.expensive.ingredients then
		for _, v in pairs( recipe.expensive.ingredients ) do
			if v[ 1 ] == old then
				v[ 1 ] = new
			end
		end
	end
end

function QLuaLibrary.change_tech_unit( techName, newUnit )
	if data.raw.technology[ techName ] then
		data.raw.technology[ techName ].unit = newUnit
	end
end
function QLuaLibrary.add_tech_prerequisite( techName, prereq )
	if data.raw.technology[ techName ] then
		local tech = data.raw.technology[ techName ]
		
		--If the technology has 0 prerequisites, then prepare the table for some to be added:
		if not tech.prerequisites then
			tech.prerequisites = {}
		end
		
		table.insert( tech.prerequisites, prereq )
	end
end
function QLuaLibrary.remove_tech_prerequisite( techName, prereq )
	if data.raw.technology[ techName ] then
		local tech = data.raw.technology[ techName ]
		
		--If the technology has 0 prerequisites, then do nothing
		if not tech.prerequisites then
			return
		end
		
		--To find the index of the prerequisite we remove:
		for i = 0, #tech.prerequisites do
			if tech.prerequisites[ i ] == prereq then
				table.remove( tech.prerequisites, i )
				return
			end
		end
	end
end
function QLuaLibrary.add_tech_effect( techName, effect )
	if data.raw.technology[ techName ] then
		local tech = data.raw.technology[ techName ]
		
		--If the technology has 0 effects, then prepare the table for some to be added:
		if not tech.effects then
			tech.effects = {}
		end
		
		table.insert( tech.effects, effect )
	end
end
function QLuaLibrary.remove_tech_effect( techName, effect )
	if data.raw.technology[ techName ] then
		local tech = data.raw.technology[ techName ]
		--If the technology has effects, remove the requested one:
		if tech.effects then
			--Loop through all effects & remove the one that matches the desired effect:
			for k, v in pairs( tech.effects ) do
				if table.compare( v, effect ) == true then
					--Delete the requested item, skip the rest of the loop:
					tech.effects[ k ] = nil
					return
				end
			end
		end
	end
end

--This function is big & complicated, so here's what it does:
--It goes through all techs in the game.  If any of them require a certain science pack, it adds the tech that unlocks
--that science pack to their prerequisites list, unless it already has that somewhere up in the chain.
--skipList is a list of technologies to make exempt from this operation.  It can be left blank.
function QLuaLibrary.globally_add_science_pack_tech_prerequisite( sciencePackItemName, sciencePackTechName, skipList )
	if not data.raw.tool[ sciencePackItemName ] then
		error( "Failed to find a science pack with given name in QLuaLibrary function 'globally_add_science_pack_tech_prerequisite(...)'" )
	end
	if not data.raw.technology[ sciencePackTechName ] then
		error( "Failed to find a technology with given name in QLuaLibrary function 'globally_add_science_pack_tech_prerequisite(...)'" )
	end

	--Make skipList an empty table if it doesn't have members already:
	if type( skipList ) ~= "table" then
		skipList = {}
	end

	--This function looks at a technology & returns one of the following codes: 0, 1, 2
	--0 means that this technology neither requires nor unlocks the science pack specified
	--1 means that this technology requires the science pack specified
	--2 means that this technology is the one that unlocks the science pack specified
	--3 means that the argument passed to the function was a false-like value (false or nil; these are the only ones in Lua)
	--Pass in the actual tech object itself, not just the name:
	function examine_tech( tech )
		if not tech then
			return 3
		end
		if tech.name == sciencePackTechName then
			return 2
		end
		local requiresThePack = false
		for _, ingred in pairs( tech.unit.ingredients ) do
			if ingred[ 1 ] == sciencePackItemName then
				requiresThePack = true
				break
			end			
		end
		if requiresThePack then
			return 1
		end
		--Else:
		return 0
	end

	--Returns whether or not the specified tech should have the prereq added or not, based solely on its prerequisites:
	--Pass in the actual tech object itself, not just the name:
	--Uses recursion, uses the level variable to count recursion.  If level goes over 20, returns true.
	--So the only situation in which there could be an error is if the recursion gets out of hand.  This is to avoid endless loops from circular prerequisites, etc.
	function examine_all_prerequisites_of( tech, level )
		if level > 20 then
			log( "Reached recursion level 20 in function QLuaLibrary.globally_add_science_pack_tech_prerequisite(...)" )
			return true
		end

		local shouldAdd = true
		if tech.prerequisites then
			for _, v in pairs( tech.prerequisites ) do
				local examined = examine_tech( data.raw.technology[ v ])
				if examined ~= 0 then
					shouldAdd = false
					break
				end
				--Now examine prereqs of prereqs:
				local prereqExamined = examine_all_prerequisites_of( data.raw.technology[ v ], level + 1 )
				if shouldAdd and not prereqExamined then
					shouldAdd = false
					break
				end
			end
		end
		return shouldAdd
	end

	--This function determines if the tech we're looking at requires the one specified in sciencePackTechName
	--Pass in the actual tech object itself, not just the name:
	function does_tech_need_prerequisite( tech )
		--Firstly, is this the tech we would add?
		if tech.name == sciencePackTechName then
			return false
		end
		--Secondly, is this tech one of the ones we're supposed to skip?
		local onSkipList = false
		for _, skipName in pairs( skipList ) do
			if skipName == tech.name then
				onSkipList = true
				break
			end
		end
		if onSkipList then
			return false
		end
		--Thirdly, does this tech require the science pack we are working with?
		local requiresThePack = false
		for _, ingred in pairs( tech.unit.ingredients ) do
			if ingred[ 1 ] == sciencePackItemName then
				requiresThePack = true
				break
			end			
		end
		if not requiresThePack then
			return false
		end
		--Next, does this tech have any prerequisites at all?  If it has none, then it definitely needs the science pack tech added!
		if not tech.prerequisites then
			return true
		end
		--Otherwise, this tech has prerequisites.  So let's loop through all of the prereqs.
		--The result of the loop will determine whether we add the tech or not:
		return examine_all_prerequisites_of( tech, 0 )
	end

	--Now loop through ALL technologies:
	local addedList = ""
	local addedCount = 0
	for _, v in pairs( data.raw.technology ) do
		if does_tech_need_prerequisite( v ) then
			QLuaLibrary.add_tech_prerequisite( v.name, sciencePackTechName )
			addedCount = addedCount + 1
			if #addedList == 0 then
				addedList = v.name
			else
				addedList = addedList..", "..v.name
			end
		end
	end
	
	if #addedList == 0 then
		addedList = "<none>"
	end

	log( "QLuaLibrary.globally_add_science_pack_tech_prerequisite(...) auto-added prerequisite of "..sciencePackTechName.." to "..addedCount.." technologies: "..addedList )
end