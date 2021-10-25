class_name Utils

static func create_grid(rows: int, cols: int) -> Array:
	var grid = []
	for i in range(rows):
		var array = []
		array.resize(cols)
		grid.append(array)
	return grid

static func inside_grid_bounds(grid: Array, position: Vector2):
	if position.y < 0 or position.y >= len(grid):
		return false
	elif position.x < 0 or position.x >= len(grid[0]):
		return false
	else:
		return true

# loops through a 2d array calling callback only if the value is not null
static func loop_through_grid(grid: Array, callback: FuncRef):
	for y in range(len(grid)):
		if grid[y] != null:
			for x in range(len(grid[y])):
				if grid[y][x] != null:
					callback.call_func(grid[y][x], x, y)
