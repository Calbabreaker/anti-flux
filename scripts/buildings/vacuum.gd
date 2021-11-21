extends BuildingWorld

var destroyed_count := 0

func on_timestep(cell_pos: Vector2) -> void:
    loop_through_surrounding(funcref(self, "destroy_building"), cell_pos)
    gen_antimatter(destroyed_count * 2)

func destroy_building(building: BuildingWorld, cell_pos: Vector2) -> void:
    if not Utils.same_obj(building, self):
        Global.emit_signal("destroy_building", cell_pos)
        destroyed_count += 1
