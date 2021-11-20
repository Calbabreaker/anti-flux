extends Sprite
class_name BuildingWorld

const SIZE := 64
const SIZE_VECTOR := Vector2(SIZE, SIZE)

const antimatter_collect_prefab = preload("res://scenes/antimatter_collect.tscn")
const enhancer_particle_prefab := preload("res://scenes/enhancer_particle.tscn")
onready var particle_system: Particles2D = get_node_or_null("Particles2D")

var antimatter_collect: Node
var grid: Array

func _enter_tree() -> void:
	fit_to_cell_size()
	
func fit_to_cell_size():
	var size = texture.get_size()
	scale = SIZE_VECTOR / size

func timestep(cell_pos: Vector2) -> void:
	antimatter_collect = null
	on_timestep(cell_pos)
	
func gen_antimatter(amount: int) -> void:
	if amount != 0:
		antimatter_collect = antimatter_collect_prefab.instance()
		antimatter_collect.set_amount(amount)
		Global.emit_signal("add_particle", antimatter_collect, self)
		particle_system.restart()
	
# override this function to do something on timestep
func on_timestep(_cell_pos: Vector2) -> void:
	pass
	
# override this function to do something last frame before it is destroyed
func on_destroy() -> void:
	pass

# calls a function with surrounding buildings
func loop_through_surrounding(callback: FuncRef, self_cell_pos: Vector2, only_empty: bool = false) -> void:
	for offset_x in range(-1, 2):
		for offset_y in range(-1, 2):
			var cell_pos = Vector2(offset_x, offset_y) + self_cell_pos
			if Utils.grid_inside_bounds(grid, cell_pos):
				var building = Utils.grid_get(grid, cell_pos)
				if only_empty && !building || building && !only_empty:
					callback.call_func(building, cell_pos)
