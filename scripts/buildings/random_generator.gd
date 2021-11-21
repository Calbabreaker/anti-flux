extends BuildingWorld

func on_timestep(_cell_pos: Vector2) -> void:
    gen_antimatter(randi() % 6)
