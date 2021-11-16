extends Node

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator"),
	"Enhancer": BuildingData.new("Surrounding buildings have their production mutliplied by 1.5 times", "enhancer")
}

var building_names := building_data.keys()

var building_grid := Utils.grid_create(4, 3)
var antimatter := 0
var current_stage := 1
var timesteps_left := current_stage * 5
var advance_stage_cost := 25

onready var building_prefab := preload("res://scenes/building.tscn")
onready var main_scene := $"/root/Main"
onready var building_grid_node := main_scene.get_node("BuildingGrid")
onready var particle_storage := main_scene.get_node("ParticleStorage")
onready var canvas_layer := main_scene.get_node("CanvasLayer")

onready var building_select_panel := canvas_layer.get_node("BuildingSelectPanel")
onready var antimatter_label := canvas_layer.get_node("AntimatterLabel")

func _setup():
	randomize() # set new seed (based on time)

func create_building(cell_pos: Vector2, building_name: String):
	var building_node = building_prefab.instance()
	building_node.set_script(building_data[building_name].script_file) # sets generate functionality
	building_node.texture = building_data[building_name].texture
	
	building_grid_node.add_child(building_node)
	building_node.position = cell_pos * BuildingWorld.SIZE
	building_grid[cell_pos.y][cell_pos.x] = building_node

func can_place_building(cell_pos: Vector2) -> bool:
	return Utils.grid_inside_bounds(Manager.building_grid, cell_pos) and building_grid[cell_pos.y][cell_pos.x] == null

func timestep():
	Utils.grid_loop_through(building_grid, funcref(self, "building_timestep"))
	# if no antimatter has been generated
	if particle_storage.get_child_count() == 0:
		timestep_advance()
		
func building_timestep(building_node, x: int, y: int):
	building_node.timestep(x, y)
	
func timestep_advance():
	timesteps_left -= 1
	
	if timesteps_left == 0:
		if antimatter < advance_stage_cost:
			print("LOSE")
			return
		
		timesteps_left = current_stage * 5
		advance_stage_cost *= 5
	else:
		building_select_panel.show()
	
func add_antimatter(count: int ):
	Manager.antimatter += count
	antimatter_label.text = str(Manager.antimatter)
