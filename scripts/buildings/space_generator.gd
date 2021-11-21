extends BuildingWorld

var empty_cells: int

func on_timestep(cell_pos: Vector2) -> void:
	empty_cells = 0
	loop_through_surrounding(funcref(self, "cell_get"), cell_pos, true)
	gen_antimatter(empty_cells)

func cell_get(_a, _cell_pos: Vector2):
	empty_cells += 1
