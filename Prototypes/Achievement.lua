data:extend(
{
  {
    type = "build-entity-achievement",
    name = "ore-what-ore-where",
    order = "a[progress]-z[ore-what-ore-where]",
    to_build = "advanced-burner-mining-drill",
    icon = "__LongerBurnerPhase__/Graphics/Achievements/ore-what-ore-where.png",
    icon_size = 128
  },
  {
    type = "produce-achievement",
    name = "clean-air-act",
    order = "d[production]-z[clean-air-act]",
    item_product = "air-filter",
    limited_to_one_game = false,
    amount = 500,
    icon = "__LongerBurnerPhase__/Graphics/Achievements/clean-air-act.png",
    icon_size = 128
  },
  {
    type = "dont-build-entity-achievement",
    name = "electricity-is-optional",
    order = "f[limitation]-z[electricity-is-optional]",
    dont_build = { "electric-mining-drill", "assembling-machine-1", "electric-furnace", "chemical-plant", "oil-refinery", "laser-turret" },
    icon = "__LongerBurnerPhase__/Graphics/Achievements/electricity-is-optional.png",
    icon_size = 128
  },
})
