extends Node2D

onready var building_grid := $"BuildingGrid"
onready var particle_storage := $"CanvasLayer/ParticleStorage"
onready var building_select_panel := $"CanvasLayer/BuildingSelectPanel"
onready var antimatter_label := $"CanvasLayer/AntimatterLabel"
onready var timestep_cost_label := $"CanvasLayer/TimestepCostLabel"
onready var stage_advance_panel := $"CanvasLayer/StageAdvancePanel"
onready var back_button := $"CanvasLayer/BackButton"

var antimatter: int
var current_stage := 1
var timesteps_left: int
var advance_stage_cost := 20
var end_stage := 8

func _ready() -> void:
	set_antimatter(0)
	set_timesteps_left(current_stage * 5)
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
	
func set_timesteps_left(value: int):
	timesteps_left = value
	timestep_cost_label.bbcode_text = "[right]{} {} due in {} timesteps[/right] ".format([Global.antimatter_icon_bbcode, advance_stage_cost, timesteps_left], "{}")

func timestep() -> void:
	Utils.grid_loop_through(building_grid.grid, funcref(self, "building_timestep"))
	yield(get_tree().create_timer(0.5), "timeout")
	collect_antimatter(0) # checks if no antimatter was created

func building_timestep(building_node, x: int, y: int):
	building_node.timestep(x, y)

func collect_antimatter(amount: int) -> void:
	set_antimatter(antimatter + amount)
	if particle_storage.get_child_count() == 0 and not building_select_panel.visible:
		timestep_advance()
		
func stage_advance() -> void:
	set_antimatter(antimatter - advance_stage_cost)
	current_stage += 1
	advance_stage_cost *= 5
	set_timesteps_left(current_stage * 5)
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
	bsp_visible(true)
