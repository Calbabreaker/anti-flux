extends Sprite
class_name BuildingWorld

const SIZE := 64
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")
onready var particle_system: Particles2D = get_node_or_null("Particles2D")

var antimatter_collect: Node

func _enter_tree() -> void:
	fit_to_cell_size()
	
func fit_to_cell_size():
	var size = texture.get_size()
	scale = SIZE_VECTOR / size

func timestep(x: int, y: int) -> void:
	antimatter_collect = null
	var amount = on_timestep(x, y)
	if amount != 0:
		antimatter_collect = antimatter_collect_prefab.instance()
		antimatter_collect.set_amount(amount)
		Manager.particle_storage.add_child(antimatter_collect)
		antimatter_collect.global_position = global_position
		particle_system.restart()
	
# override this function to do something on timestep
# should return number of antimatter to generate (0 for none)
func on_timestep(x: int, y: int) -> int:
	return 0

# calls a function with surrounding buildings
func loop_through_surrounding(callback: FuncRef, self_x: int, self_y: int) -> void:
	for offset_x in range(-1, 2):
		for offset_y in range(-1, 2):
			if offset_x != 0 or offset_y != 0: # not itself
				var cell_pos = Vector2(self_x + offset_x, self_y + offset_y)
				var building = Utils.grid_get(Manager.building_grid, cell_pos)
				if building != null:
					callback.call_func(building)
