extends Sprite
class_name BuildingWorld

const SIZE := 64
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")
onready var particle_system: Particles2D = get_node_or_null("Particles2D")

var acumulattor_start := 1
var acumulattor: int # gets set to acumulattor_start every timestep to be used for acumulation like enhancing

func _enter_tree() -> void:
	fit_to_cell_size()
	
func fit_to_cell_size():
	var size = texture.get_size()
	scale = SIZE_VECTOR / size

func timestep(x: int, y: int) -> void:
	acumulattor = acumulattor_start
	on_timestep(x, y)
	
# override this function to do something on timestep
func on_timestep(x: int, y: int) -> void:
	pass

# calls a function with surrounding buildings 	
func loop_through_surrounding(callback: FuncRef, self_x: int, self_y: int) -> void:
	for x in range(self_x - 1, self_x + 1):
		for y in range(self_y - 1, self_y + 1):
			if x != self_x and self_y != 0:
				var building = Manager.building_grid[y][x]
				if building != null:
					callback.call_func(building)

func generate_antimatter(amount: int) -> void:
	var antimatter_collect = antimatter_collect_prefab.instance()
	antimatter_collect.set_amount(amount)
	Manager.antimatter_collects.add_child(antimatter_collect)
	antimatter_collect.global_position = global_position
	particle_system.restart()
