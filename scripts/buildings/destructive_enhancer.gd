extends BuildingWorld

func on_timestep(cell_pos: Vector2) -> void:
    call_deferred("loop_through_surrounding", funcref(self, "enhance"), cell_pos)

func enhance(building: BuildingWorld, cell_pos: Vector2):
    Global.emit_signal("destroy_building", cell_pos)
    if building.antimatter_collect: # antimatter was generated:
        var particle = enhancer_particle_prefab.instance()
        particle.target_collect = building.antimatter_collect
        particle.multiplier = 10.0
        particle.modulate = Color("#333333")
        Global.emit_signal("add_particle", particle, self)

