class_name Utils

static func grid_create(size: Vector2) -> Array:
	var grid = []
	for _i in range(size.y):
		var array = []
		array.resize(size.x)
		grid.append(array)
	return grid

static func grid_inside_bounds(grid: Array, cell_pos: Vector2) -> bool:
	if cell_pos.y < 0 or cell_pos.y >= len(grid):
		return false
	elif cell_pos.x < 0 or cell_pos.x >= len(grid[0]):
		return false
	else:
		return true

static func grid_get(grid: Array, cell_pos: Vector2):
	return grid[cell_pos.y][cell_pos.x] if grid_inside_bounds(grid, cell_pos) else null

# returns random position in grid
static func grid_random(grid: Array) -> Vector2:
	return Vector2(randi() % len(grid[0]), randi() % len(grid))

static func same_obj(obj1, obj2) -> bool:
	return obj1.get_instance_id() == obj2.get_instance_id()
