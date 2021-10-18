extends Node2D

export var rows := 5
export var cols := 10

var building_prefab := preload("res://scenes/building.tscn")
var building_grid := Utils.create_2d_array(rows, cols)

var selected_building := Buildings.data["Simple Generator"]

func _ready() -> void:
	# offset buildings to make mouse pos not be offseted
	position = Building.SIZE_VECTOR / 2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		var mouse_cell_pos = (get_global_mouse_position() / Building.SIZE).floor()
		
		var building_in_cell = Utils.get_2d_array(building_grid, mouse_cell_pos)
		if build:
			var building_node = building_prefab.instance()
			building_node.global_position = mouse_cell_pos * Building.SIZE
			add_child(building_node)
