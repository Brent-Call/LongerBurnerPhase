--Item_group.lua
--This file adds a new item subgroup to Factorio specifically for labs.
--This file also contains code that moves the lab & burner lab into this new item subgroup.
data:extend({
{
	type = "item-subgroup",
	name = "laboratory",
	group = "production",
	order = "f"
}
})

--This new item subgroup will go in between the groups "production-machine" & "module."
--So move the group "module" out of the way:
data.raw[ "item-subgroup" ][ "module" ].order = "g"

--Now move the lab & the burner lab into this new group, with the burner lab first:
data.raw.item[ "burner-lab" ].subgroup = "laboratory"
data.raw.item[ "burner-lab" ].order = "a[ burner-lab ]"
data.raw.recipe[ "uncraft-burner-lab" ].subgroup = "laboratory"
data.raw.recipe[ "uncraft-burner-lab" ].order = "b[ uncraft-burner-lab ]"
data.raw.item[ "lab" ].subgroup = "laboratory"
data.raw.item[ "lab" ].order = "c[ lab ]"