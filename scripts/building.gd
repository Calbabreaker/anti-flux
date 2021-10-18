extends Resource

class_name Building

const SIZE := 50
const SIZE_VECTOR := Vector2(SIZE, SIZE)

var cell_size: Vector2

func _init(p_cell_size: Vector2) -> void:
	cell_size = p_cell_size
