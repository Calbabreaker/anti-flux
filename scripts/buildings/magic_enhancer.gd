extends BuildingWorld

var particles: Array

func on_timestep(cell_pos: Vector2) -> void:
    call_deferred("do_enhancing", cell_pos)

func do_enhancing(cell_pos):
    particles = []
    loop_through_surrounding(funcref(self, "enhance"), cell_pos)
    if particles:
        particles[randi() % len(particles)].multiplier *= -1

func enhance(building: BuildingWorld, cell_pos: Vector2):
    if building.antimatter_collect: # antimatter was generated:
        var particle = enhancer_particle_prefab.instance()
        particle.target_collect = building.antimatter_collect
        particle.multiplier = 5.0
        particle.modulate = Color("#ad956a")
        particles.append(particle)
        Global.emit_signal("add_particle", particle, self)
