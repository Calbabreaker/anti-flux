extends Sprite
class_name Building

const SIZE := 50
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")

var cell_size = Vector2.ONE

func _enter_tree() -> void:
	# make sprite fit to the building size
	var size = texture.get_size()
	scale = (SIZE_VECTOR / size) * cell_size
	
# override this function to do something on timestep
func timestep():
	pass

func generate_antimatter(antimatter: int = 1):
	for _i in range(antimatter):
		var antimatter_collect = antimatter_collect_prefab.instance()
		antimatter_collect.position = position
		Manager.main_scene_node.add_child(antimatter_collect)
