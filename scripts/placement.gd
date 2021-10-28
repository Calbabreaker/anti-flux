extends Node2D

var building_prefab := preload("res://scenes/building.tscn")
onready var offset: Vector2 = ($"BuildingGrid").position - Building.SIZE_VECTOR / 2

var selected_building: PackedScene = Manager.building_prefabs["Simple Generator"]
var antimatter := 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		var offseted_mouse_pos = get_global_mouse_position() - offset
		var mouse_cell_pos = (offseted_mouse_pos / Building.SIZE).floor()
		Manager.create_building(mouse_cell_pos, selected_building)
		
func _on_Button_pressed() -> void:
	Manager.timestep()
