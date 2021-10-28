extends Node

const building_prefabs: Dictionary = {
	"Simple Generator": preload("res://scenes/buildings/simple_generator.tscn")
}

var building_grid := Utils.create_grid(15, 18)
var antimatter := 0

onready var main_scene_node = $"/root/Main"

# create building only if not already exist at position
func create_building(position: Vector2, prefab: PackedScene):
	if Utils.inside_grid_bounds(Manager.building_grid, position) and building_grid[position.y][position.x] == null:
		var building_node = prefab.instance()
		building_node.global_position = position * Building.SIZE
		main_scene_node.get_node("BuildingGrid").add_child(building_node)
		building_grid[position.y][position.x] = building_node

func timestep():
	Utils.loop_through_grid(building_grid, funcref(self, "building_timestep"))

func building_timestep(building_node, x: int, y: int):
	building_node.timestep()
	
func add_antimatter(count: int = 1):
	Manager.antimatter += count
	var text_label = main_scene_node.get_node("CanvasLayer/AntimatterLabel")
	text_label.text = str(Manager.antimatter)
