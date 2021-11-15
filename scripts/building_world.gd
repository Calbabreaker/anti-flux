extends Sprite
class_name BuildingWorld

const SIZE := 64
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")

var cell_size = Vector2.ONE
onready var particle_system: Particles2D = $"Particles2D"

func _enter_tree() -> void:
	fit_to_cell_size()
	
func fit_to_cell_size():
	var size = texture.get_size()
	scale = (SIZE_VECTOR / size) * cell_size

func timestep(x: int, y: int) -> void:
	on_timestep(x, y)
	
# override this function to do something on timestep
func on_timestep(x: int, y: int) -> void:
	pass

func generate_antimatter(amount: int = 1) -> void:
	var antimatter_collect = antimatter_collect_prefab.instance()
	antimatter_collect.amount = amount
	Manager.antimatter_collects.add_child(antimatter_collect)
	antimatter_collect.global_position = global_position
	particle_system.restart()
