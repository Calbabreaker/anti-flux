extends Node

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator"),
	"Enhancer": BuildingData.new("Surrounding buildings have their production mutliplied by 1.5 times", "enhancer")
}

var building_names := building_data.keys()

var building_grid := Utils.grid_create(10, 20)
var antimatter := 0

onready var building_prefab := preload("res://scenes/building.tscn")
onready var main_scene := $"/root/Main"
onready var building_grid_node := main_scene.get_node("BuildingGrid")
onready var antimatter_collects := main_scene.get_node("AntimatterCollects")
onready var ui := main_scene.get_node("CanvasLayer")

func create_building(cell_pos: Vector2, building_name: String):
	var building_node = building_prefab.instance()
	building_node.set_script(building_data[building_name].script_file) # sets generate functionality
	building_node.texture = building_data[building_name].texture # sets generate functionality
	
	building_grid_node.add_child(building_node)
	building_node.position = cell_pos * BuildingWorld.SIZE
	building_grid[cell_pos.y][cell_pos.x] = building_node

func can_place_building(cell_pos: Vector2) -> bool:
	return Utils.grid_inside_bounds(Manager.building_grid, cell_pos) and building_grid[cell_pos.y][cell_pos.x] == null

func timestep():
	Utils.grid_loop_through(building_grid, funcref(self, "building_timestep"))

func building_timestep(building_node, x: int, y: int):
	building_node.timestep(x, y)
	
func add_antimatter(count: int ):
	Manager.antimatter += count
	ui.antimatter_label.text = str(Manager.antimatter)
