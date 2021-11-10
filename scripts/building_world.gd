extends Sprite
class_name BuildingWorld

const SIZE := 64
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")

var cell_size = Vector2.ONE
onready var particle_system: Particles2D = $"Particles2D"

func _enter_tree() -> void:
	# make sprite fit to the building size
	var size = texture.get_size()
	scale = (SIZE_VECTOR / size) * cell_size

func timestep() -> void:
	particle_system.restart()
	on_timestep()
	
# override this function to do something on timestep
func on_timestep() -> void:
	pass

func generate_antimatter(amount: int = 1) -> void:
	var antimatter_collect = antimatter_collect_prefab.instance()
	antimatter_collect.amount = amount
	Manager.antimatter_collects.add_child(antimatter_collect)
	antimatter_collect.global_position = global_position
