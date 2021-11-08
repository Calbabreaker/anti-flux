extends Node

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator")
}

var building_names := building_data.keys()

var building_grid := Utils.create_grid(10, 20)
var antimatter := 0

onready var main_scene := $"/root/Main"
onready var building_grid_node := main_scene.get_node("BuildingGrid")
onready var antimatter_collecs := main_scene.get_node("AntimatterCollects")
onready var ui := main_scene.get_node("CanvasLayer")

# create building only if not already exist at position
func create_building(cell_pos: Vector2, building_name: String):
	if Utils.inside_grid_bounds(Manager.building_grid, cell_pos) and building_grid[cell_pos.y][cell_pos.x] == null:
		var building_node = building_data[building_name].world_prefab.instance()
		building_grid_node.add_child(building_node)
		building_node.position = cell_pos * BuildingWorld.SIZE
		building_grid[cell_pos.y][cell_pos.x] = building_node

func timestep():
	Utils.loop_through_grid(building_grid, funcref(self, "building_timestep"))

func building_timestep(building_node, x: int, y: int):
	building_node.timestep()
	
func add_antimatter(count: int = 1):
	Manager.antimatter += count
	ui.antimatter_label.text = str(Manager.antimatter)
