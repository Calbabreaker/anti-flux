extends Building

var times = 1

func timestep():
	generate_antimatter(times)
	times = ceil(times * 1.5)
