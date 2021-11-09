extends Node2D

var building_prefab := preload("res://scenes/building.tscn")
onready var building_ghost := $"BuildingGhost"
onready var offset: Vector2 = BuildingWorld.SIZE_VECTOR / 2

var selected_building

func _ready() -> void:
	randomize() # set new seed (based on time)
	
	# create starting buildings
	#for i in range(2):
		#Manager.create_building(Utils.random_in_grid(Manager.building_grid), "Simple Generator")

func _input(event: InputEvent) -> void:
	var offseted_mouse_pos = get_local_mouse_position() + offset
	var mouse_cell_pos = (offseted_mouse_pos / BuildingWorld.SIZE).floor()
	
	if event is InputEventMouseMotion and selected_building:
		building_ghost.position = mouse_cell_pos * BuildingWorld.SIZE
		# thint red if can't place at mouse pos
		building_ghost.self_modulate = Color.white if Manager.can_place_building(mouse_cell_pos) else Color.red
		
	if event.is_action_pressed("ui_click") and selected_building:
		Manager.create_building(mouse_cell_pos,  selected_building)
		select_building(null)
		Manager.timestep()

func select_building(building_name):
	selected_building = building_name
	if building_name == null:
		# hide ghost building
		building_ghost.hide()
	else:
		# show ghost building
		building_ghost.texture = Manager.building_data[selected_building].texture
		building_ghost.show()
		Manager.ui.building_select_panel.hide()
