extends Node2D

const building_prefab := preload("res://scenes/building.tscn")
const destruction_ps_prefab := preload("res://scenes/destruction_ps.tscn")
const invalid_color := Color(0.8, 0, 0)

export var back_button_path: NodePath
onready var back_button := get_node(back_button_path) as Button

onready var building_ghost := $"BuildingGhost"
onready var place_guides := $"PlaceGuides"
onready var camera := $"Camera2D"
onready var offset: Vector2 = BuildingWorld.SIZE_VECTOR / 2

var grid_size = Vector2(5, 4)
var grid := Utils.grid_create(grid_size) 
var selected_building

func _ready() -> void:
	place_guides.rect_size = grid_size * BuildingWorld.SIZE_VECTOR
	place_guides.rect_position = Vector2(-32, -32)
	camera.position = place_guides.rect_size / 2 - offset
	Global.connect_signal_funcs(self, ["select_building", "destroy_building", "create_building"])

func _input(event: InputEvent) -> void:
	var offseted_mouse_pos = get_local_mouse_position() + offset
	var mouse_cell_pos = (offseted_mouse_pos / BuildingWorld.SIZE).floor()
	var can_place = can_place_building(mouse_cell_pos)
	
	if event is InputEventMouseMotion && selected_building:
		building_ghost.position = mouse_cell_pos * BuildingWorld.SIZE
		# tint red if can't place at mouse pos
		building_ghost.modulate = Color.white if can_place else invalid_color
		
	if event.is_action_pressed("ui_click") && selected_building && can_place:
		create_building(mouse_cell_pos, selected_building)
		select_building(null)
		Global.emit_signal("timestep")

func create_building(cell_pos: Vector2, building_name: String):
	var building_node = building_prefab.instance()
	building_node.set_script(Global.building_data[building_name].script_file) # sets generate functionality
	building_node.texture = Global.building_data[building_name].texture
	building_node.grid = grid
	
	add_child(building_node)
	building_node.position = cell_pos * BuildingWorld.SIZE
	grid[cell_pos.y][cell_pos.x] = building_node
	
func destroy_building(cell_pos: Vector2):
	var building_node = Utils.grid_get(grid, cell_pos)
	if building_node:
		building_node.on_destroy()
		yield(get_tree(), "idle_frame") # wait one frame to let enhancers enhance the potential generated antmatter
		
		var ps = destruction_ps_prefab.instance()
		add_child(ps)
		ps.global_position = building_node.global_position
		ps.texture = building_node.texture
		ps.restart()
		SoundManager.destroy.play()
		
		building_node.queue_free()
		grid[cell_pos.y][cell_pos.x] = null
		
		yield(get_tree().create_timer(ps.lifetime), "timeout")
		ps.queue_free()
		
	
func can_place_building(cell_pos: Vector2) -> bool:
	return Utils.grid_inside_bounds(grid, cell_pos) && !grid[cell_pos.y][cell_pos.x]

func select_building(building_name) -> void:
	selected_building = building_name
	if !building_name:
		# hide ghost building
		building_ghost.hide()
		back_button.hide()
	else:
		# show ghost building
		building_ghost.texture = Global.building_data[selected_building].texture
		building_ghost.fit_to_cell_size()
		building_ghost.show()
		back_button.show()
