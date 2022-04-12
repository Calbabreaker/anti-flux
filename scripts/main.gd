extends Node2D

onready var building_grid := $BuildingGrid
onready var particle_storage := $CanvasLayer/ParticleStorage
onready var building_select_panel := $CanvasLayer/BuildingSelectPanel
onready var antimatter_label := $CanvasLayer/AntimatterLabel
onready var timestep_cost_label := $CanvasLayer/TimestepCostLabel
onready var stage_advance_panel := $CanvasLayer/StageAdvancePanel
onready var back_button := $CanvasLayer/BackButton

var antimatter: int
var current_stage := 1
var timesteps_left: int
var advance_stage_cost := 20
var asc_increase := 30
var end_stage := 8

func _ready() -> void:
	randomize()
	set_antimatter(0)
	set_timesteps_left()
	bsp_visible(true)
	Global.connect_signal_funcs(self, ["timestep", "collect_antimatter", "stage_advance", "bsp_visible", "add_particle"])

func timestep_advance():
	if building_select_panel.visible:
		return

	set_timesteps_left(timesteps_left - 1)
	if timesteps_left == 0:
		stage_advance_panel.update_show(antimatter, advance_stage_cost)
	else:
		bsp_visible(true)

func set_antimatter(value: int):
	antimatter = value
	antimatter_label.bbcode_text = "{} {}".format([Global.antimatter_icon_bbcode, antimatter], "{}")

func set_timesteps_left(value: int = current_stage / 2 + 5):
	timesteps_left = value
	timestep_cost_label.bbcode_text = "[right]{} {} due in {} turns[/right] ".format([Global.antimatter_icon_bbcode, advance_stage_cost, timesteps_left], "{}")

func timestep() -> void:
	for x in range(building_grid.grid_size.x):
		for y in range(building_grid.grid_size.y):
			timestep_building(Vector2(x, y))

	# if no antimatter was generated there would be no collects to trigger timestep advance
	if particle_storage.get_child_count() == 0:
		yield(get_tree().create_timer(0.5), "timeout")
		timestep_advance()
	else:
		SoundManager.generate.play()

func timestep_building(cell_pos: Vector2):
	var building = Utils.grid_get(building_grid.grid, cell_pos)
	if building:
		building.on_timestep(cell_pos)

func collect_antimatter(amount: int) -> void:
	set_antimatter(antimatter + amount)
	if particle_storage.get_child_count() == 0 && !building_select_panel.visible:
		timestep_advance()

func stage_advance() -> void:
	current_stage += 1
	set_antimatter(antimatter - advance_stage_cost)
	advance_stage_cost += asc_increase
	asc_increase += 30
	set_timesteps_left()

	if current_stage == end_stage + 1:
		stage_advance_panel.show_win()
	else:
		bsp_visible(true)

func bsp_visible(is_visible) -> void:
	if is_visible:
		building_select_panel.update_show(current_stage, end_stage)
	else:
		building_select_panel.hide()

func add_particle(particle, gen_node) -> void:
	particle.rect_position = gen_node.get_global_transform_with_canvas().origin
	if particle.has_method("set_antimatter_label_pos"):
		particle.set_antimatter_label_pos(antimatter_label.rect_position)
	particle_storage.add_child(particle)

func _on_BackButton_pressed():
	building_grid.select_building(null)
	building_select_panel.show()
