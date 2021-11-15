extends Node2D

const invalid_color := Color(0.8, 0, 0)

var building_prefab := preload("res://scenes/building.tscn")
onready var building_ghost := $"BuildingGhost"
onready var offset: Vector2 = BuildingWorld.SIZE_VECTOR / 2

var selected_building

func _input(event: InputEvent) -> void:
	var offseted_mouse_pos = get_local_mouse_position() + offset
	var mouse_cell_pos = (offseted_mouse_pos / BuildingWorld.SIZE).floor()
	var can_place = Manager.can_place_building(mouse_cell_pos)
	
	if event is InputEventMouseMotion and selected_building:
		building_ghost.position = mouse_cell_pos * BuildingWorld.SIZE
		# tint red if can't place at mouse pos
		building_ghost.modulate = Color.white if can_place else invalid_color
		
	if event.is_action_pressed("ui_click") and selected_building and can_place:
		Manager.create_building(mouse_cell_pos,  selected_building)
		select_building(null)
		Manager.timestep()

func select_building(building_name):
	selected_building = building_name
	if building_name == null:
		# hide ghost building
		building_ghost.hide()
		Manager.ui.back_button.hide()
	else:
		# show ghost building
		building_ghost.texture = Manager.building_data[selected_building].texture
		building_ghost.fit_to_cell_size()
		building_ghost.show()
		Manager.ui.building_select_panel.hide()
		Manager.ui.back_button.show()

func _on_SkipButton_pressed() -> void:
	Manager.ui.building_select_panel.hide()
	Manager.timestep()

func _on_BackButton_pressed():
	select_building(null)
	Manager.ui.building_select_panel.popup()
