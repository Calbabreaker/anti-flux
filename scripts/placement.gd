extends Node2D

var rows := 20
var cols := 30

var building_prefab := preload("res://scenes/building.tscn")
onready var offset := position - Building.SIZE_VECTOR / 2

var selected_building := SimpleGenerator

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		var offseted_mouse_pos = get_global_mouse_position() - offset
		var mouse_cell_pos = (offseted_mouse_pos / Building.SIZE).floor()
		
		if Manager.place_building(mouse_cell_pos, selected_building):
			var building_node = building_prefab.instance()
			building_node.global_position = mouse_cell_pos * Building.SIZE
			add_child(building_node)

func _on_Button_pressed() -> void:
	Manager.timestep()
