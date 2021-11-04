extends Node

var building_data := {
	"Simple Generator": BuildingData.new("Generates 1 antimatter", "simple_generator.tscn")
}

var building_names := building_data.keys()

var building_grid := Utils.create_grid(10, 20)
var selected_building = "Simple Generator"
var antimatter := 0

var current_timestep := 1
var current_stage := 1
var timesteps_in_stage := 5
var advance_stage_cost := 25

onready var main_scene := $"/root/Main"
onready var building_grid_node := main_scene.get_node("BuildingGrid")
onready var canvas_layer := main_scene.get_node("CanvasLayer")
onready var antimatter_label := canvas_layer.get_node("AntimatterLabel")
onready var next_stage_label := canvas_layer.get_node("NextStageLabel")
onready var building_select_panel := canvas_layer.get_node("BuildingSelectPanel")

# create building only if not already exist at position
func create_building(cell_pos: Vector2, building_name: String):
	if Utils.inside_grid_bounds(Manager.building_grid, cell_pos) and building_grid[cell_pos.y][cell_pos.x] == null:
		var building_node = building_data[building_name].world_prefab.instance()
		building_grid_node.add_child(building_node)
		building_node.position = cell_pos * BuildingWorld.SIZE
		building_grid[cell_pos.y][cell_pos.x] = building_node

func timestep():
	Utils.loop_through_grid(building_grid, funcref(self, "building_timestep"))
	current_timestep += 1
	
	building_select_panel.show()
	next_stage_label.text = "Next Stage: " + str(advance_stage_cost)
		
	if current_timestep == timesteps_in_stage:
		if antimatter < advance_stage_cost:
			print("LOSE")
			return
		
		current_timestep = 1
		timesteps_in_stage += 5
		advance_stage_cost *= 5

func select_building(building_name: String):
	selected_building= building_name
	building_select_panel.hide()

func building_timestep(building_node, x: int, y: int):
	building_node.timestep()
	
func add_antimatter(count: int = 1):
	Manager.antimatter += count
	antimatter_label.text = str(Manager.antimatter)
