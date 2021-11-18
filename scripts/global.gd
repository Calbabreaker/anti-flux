extends Node

const antimatter_icon_bbcode = "[font=res://assets/bbcode_font.tres][img]res://assets/antimatter.svg[/img][/font]"

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator"),
	"Enhancer": BuildingData.new("Surrounding buildings have their production mutliplied by 1.5 times", "enhancer")
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
