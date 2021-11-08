extends Node

var current_timestep := 1
var current_stage := 1
var timesteps_in_stage := 5
var advance_stage_cost := 25

onready var next_stage_label := $"NextStageLabel"
onready var building_select_panel := $"BuildingSelectPanel"
onready var antimatter_label := $"AntimatterLabel"

func _ready() -> void:
	building_select_panel.show()

func timestep_advance():
	building_select_panel.show()
	next_stage_label.text = "Next Stage: " + str(advance_stage_cost)
		
	if current_timestep == timesteps_in_stage:
		if Manager.antimatter < advance_stage_cost:
			print("LOSE")
			return
		
		current_timestep = 1
		timesteps_in_stage += 5
		advance_stage_cost *= 5

func _on_TimestepButton_pressed() -> void:
	Manager.timestep()
