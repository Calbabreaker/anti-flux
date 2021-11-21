extends BuildingWorld

func on_timestep(cell_pos: Vector2) -> void:
    call_deferred("loop_through_surrounding", funcref(self, "enhance"), cell_pos)

func enhance(building: BuildingWorld, _cell_pos: Vector2):
    if building.antimatter_collect: # antimatter was generated
        var particle = enhancer_particle_prefab.instance()
        particle.target_collect = building.antimatter_collect
        particle.multiplier = 2.0
        particle.modulate = Color("#cc0000")
        Global.emit_signal("add_particle", particle, self)

