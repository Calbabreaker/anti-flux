class_name Utils

static func grid_create(rows: int, cols: int) -> Array:
	var grid = []
	for _i in range(rows):
		var array = []
		array.resize(cols)
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

# loops through a 2d array calling callback only if the value is not null
static func grid_loop_through(grid: Array, callback: FuncRef):
	for y in range(len(grid)):
		if grid[y] != null:
			for x in range(len(grid[y])):
				if grid[y][x] != null:
					callback.call_func(grid[y][x], x, y)

# returns random position in grid
static func grid_random(grid: Array) -> Vector2:
	return Vector2(randi() % len(grid[0]), randi() % len(grid)) 
