extends BuildingWorld

var cell_pos_list: Array

func on_timestep(cell_pos: Vector2) -> void:
	cell_pos_list = []
	loop_through_surrounding(funcref(self, "cell_get"), cell_pos, true)
	
	if cell_pos_list:
		var rand_cell_pos = cell_pos_list[randi() % len(cell_pos_list)]
		var building_name = Global.random_building_name()
		Global.emit_signal("create_building", rand_cell_pos, building_name)

func cell_get(_a, cell_pos: Vector2):
	cell_pos_list.append(cell_pos)
