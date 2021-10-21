extends Resource

class_name Building

const SIZE := 50
const SIZE_VECTOR := Vector2(SIZE, SIZE)

var cell_size: Vector2

# to create a building, make a script that inherits this script
func _init(p_cell_size: Vector2 = Vector2(1, 1)) -> void:
	cell_size = p_cell_size

# override this function to have generator fuctionality 
func generate() -> int:
	return 0
