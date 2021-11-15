extends BuildingWorld

const particle_prefab := preload("res://scenes/enhancer_particle.tscn")

func on_timestep(x: int, y: int) -> int:
	call_deferred("loop_through_surrounding", funcref(self, "enhance"), x, y)
	return 0

func enhance(building: BuildingWorld):
	if building.antimatter_collect != null: # antimatter was generated:
		var particle = particle_prefab.instance()
		particle.target_collect = building.antimatter_collect
		Manager.particle_storage.add_child(particle)
		particle.global_position = global_position
	
