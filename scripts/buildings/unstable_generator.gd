extends BuildingWorld

func on_timestep(cell_pos: Vector2) -> void:
	gen_antimatter(5)
	if randi() % 5 == 1:
		loop_through_surrounding(funcref(self, "destroy_building"), cell_pos)

func destroy_building(_building: BuildingWorld, cell_pos: Vector2) -> void:
	Global.emit_signal("destroy_building", cell_pos)
