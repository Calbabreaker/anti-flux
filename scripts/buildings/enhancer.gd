extends BuildingWorld

const particle_prefab := preload("res://scenes/enhancer_particle.tscn")

func on_timestep(x: int, y: int) -> void:
	loop_through_surrounding(funcref(self, "enhance"), x, y)

func enhance(building):
	building.acumulattor = ceil(building.acumulattor * 1.5)
	var particle = particle_prefab.instance()
