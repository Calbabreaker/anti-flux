extends BuildingWorld

var timesteps_done := 0

func on_timestep(_cell_pos: Vector2) -> void:
    timesteps_done += 1
    var antimatter := -2

    if timesteps_done == 4:
        antimatter += 20
        timesteps_done = 0

    gen_antimatter(antimatter)
