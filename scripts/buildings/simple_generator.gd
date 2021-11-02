extends BuildingWorld

var times = 2

func timestep():
	generate_antimatter(times)
	times *= 2
