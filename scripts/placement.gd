extends Node2D

var building_prefab := preload("res://scenes/building.tscn")
var building_grid := Utils.create_grid(15, 18)
onready var offset: Vector2 = ($"BuildingGrid").position - Building.SIZE_VECTOR / 2

var selected_building := SimpleGenerator
var antimatter := 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		var offseted_mouse_pos = get_global_mouse_position() - offset
		var mouse_cell_pos = (offseted_mouse_pos / Building.SIZE).floor()
		place_building(mouse_cell_pos)
		
# place building only if not already exist at position
func place_building(position: Vector2):
	if Utils.inside_grid_bounds(building_grid, position) and building_grid[position.y][position.x] == null:
		var building_node = building_prefab.instance()
		building_node.building = selected_building.new()
		building_node.global_position = position * Building.SIZE
		$"BuildingGrid".add_child(building_node)
		building_grid[position.y][position.x] = building_node

func _on_Button_pressed() -> void:
	Utils.loop_through_grid(building_grid, funcref(self, "building_generate"))
	
	var text_label = $"CanvasLayer/AntimatterLabel"
	text_label.text = str(antimatter)

func building_generate(building_node, x: int, y: int):
	antimatter += building_node.building.generate()
