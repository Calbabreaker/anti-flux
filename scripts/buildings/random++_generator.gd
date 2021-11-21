extends BuildingWorld

func on_timestep(_cell_pos: Vector2) -> void:
    if randi() % 2 == 0:
        gen_antimatter(20)
    else:
        gen_antimatter(-15)
