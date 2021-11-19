extends Node

const antimatter_icon_bbcode = "[font=res://assets/bbcode_font.tres][img]res://assets/antimatter.svg[/img][/font]"

var Common := Rarity.new(100, "Common", "#dedede")
var Uncommon := Rarity.new(60, "Uncommon", "#888888")
var Rare := Rarity.new(25, "Rare", "#f2da39")
var SuperRare := Rarity.new(10, "Super Rare", "#b037e1")

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator", Common),
	"Enhancer": BuildingData.new("Surrounding buildings have their production doubled", "enhancer", Rare)
}
var building_names := building_data.keys()

signal timestep
signal collect_antimatter(amount)
signal stage_advance
signal bsp_visible(is_visible)
signal add_particle(particle, gen_node)
signal select_building(building_name)

func connect_signal_funcs(target: Object, funcs: Array):
	for function in funcs:
		connect(function, target, function)
