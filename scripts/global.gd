extends Node

const antimatter_icon_bbcode = "[font=res://assets/bbcode_font.tres][img]res://assets/textures/antimatter.svg[/img][/font]"

var Common := Rarity.new(100, "Common", "#dedede")
var Uncommon := Rarity.new(55, "Uncommon", "#888888")
var Rare := Rarity.new(22, "Rare", "#f2da39")
var SuperRare := Rarity.new(8, "Super Rare", "#8530b9")

var building_data := {
    "Simple Generator": BuildingData.new("Gives {} 2.", "simple_generator", Common),
    "Random Generator": BuildingData.new("Gives {} 0 to {} 5.", "random_generator", Common),
    "Delayed Generator": BuildingData.new("Gives {} 20 every 4 timesteps. Gives {} -2 every timestep.", "delayed_generator", Common),
    "Storage": BuildingData.new("Gives {} 10 when destroyed.", "storage", Common),
    "Unstable Generator": BuildingData.new("Gives {} 5. 20% to destroy itself and surrounding buildings.", "unstable_generator", Uncommon),
    "Space Generator": BuildingData.new("Gives {} 1 for every empty surrounding cells.", "space_generator", Uncommon),
    "Random++ Generator": BuildingData.new("Gives {} 20 or {} -15.", "random++_generator", Uncommon),
    "Enhancer": BuildingData.new("Surrounding buildings gives 2 times more {}.", "enhancer", Rare),
    "Magic Enhancer": BuildingData.new("Surrounding buildings gives 5 times more {}. Makes a random surrounding building's production negative.", "magic_enhancer", Rare),
    "Vacuum": BuildingData.new("Destroys surrounding buildings. Gives {} 2 for every destroyed building.", "vacuum", Rare),
    "Building Generator": BuildingData.new("Creates a random building inside a surrounding cell.", "building_generator", SuperRare),
    "Destructive Enhancer": BuildingData.new("Surrounding buildings gives 15 times more {}. Destroys itself and surrounding buildings.", "destructive_enhancer", SuperRare),
}
var building_names := building_data.keys()

signal timestep
signal collect_antimatter(amount)
signal stage_advance
signal bsp_visible(is_visible)
signal add_particle(particle, gen_node)
signal select_building(building_name)
signal destroy_building(cell_pos)
signal create_building(cell_pos, building_name)

func connect_signal_funcs(target: Object, funcs: Array):
    for function in funcs:
        connect(function, target, function)

func random_building_name() -> String:
    return building_names[randi() % building_names.size()]
