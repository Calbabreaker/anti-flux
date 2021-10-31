extends Node

const stages := [
	[25, 50, 100]
]

const building_prefabs := {
	"Simple Generator": preload("res://scenes/buildings/simple_generator.tscn")
}

var building_grid := Utils.create_grid(10, 20)
var antimatter := 0

onready var main_scene_node = $"/root/Main"

# create building only if not already exist at position
func create_building(cell_pos: Vector2, prefab: PackedScene):
	if Utils.inside_grid_bounds(Manager.building_grid, cell_pos) and building_grid[cell_pos.y][cell_pos.x] == null:
		var building_node = prefab.instance()
		main_scene_node.get_node("BuildingGrid").add_child(building_node)
		building_node.position = cell_pos * Building.SIZE
		building_grid[cell_pos.y][cell_pos.x] = building_node

func timestep():
	Utils.loop_through_grid(building_grid, funcref(self, "building_timestep"))

func building_timestep(building_node, x: int, y: int):
	building_node.timestep()
	
func add_antimatter(count: int = 1):
	Manager.antimatter += count
	var text_label = main_scene_node.get_node("CanvasLayer/AntimatterLabel")
	text_label.text = str(Manager.antimatter)
