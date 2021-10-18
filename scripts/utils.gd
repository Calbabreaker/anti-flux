extends Node

static func create_2d_array(rows: int, cols: int) -> Array:
	var array = []
	for i in range(rows):
		array.append([])
		array[i].resize(cols)
	return array

static func inside_2d_array_bounds(array: Array, position: Vector2):
	if position.y < 0 or position.y >= len(array):
		return false
	elif position.x < 0 or position.x >= len(array[0]):
		return false
	else:
		return true

# sets a cell in the 2d array using a position vector 
# if inside bounds and something doesn't already exist there
# will return false if so else true
static func set_2d_array(array: Array, position: Vector2, value) -> bool:
	if inside_2d_array_bounds(array, position) or array[position.y][position.x] != null:
		array[position.y][position.x] = value
		return true
	else:
		return false
