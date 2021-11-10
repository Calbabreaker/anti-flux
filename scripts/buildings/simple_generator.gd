extends BuildingWorld

var times = 2

func on_timestep():
	generate_antimatter(times)
	times *= 2
