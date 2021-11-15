extends Node

var current_stage := 1
var timesteps_remaining := current_stage * 5
var advance_stage_cost := 25

onready var next_stage_label := $"NextStageLabel"
onready var building_select_panel := $"BuildingSelectPanel  "
onready var antimatter_label := $"AntimatterLabel"
onready var back_button := $"BackButton"

func _ready() -> void:
	building_select_panel.show()

func timestep_advance():
	timesteps_remaining -= 1
		
	if timesteps_remaining == 0:
		if Manager.antimatter < advance_stage_cost:
			print("LOSE")
			return
		
		timesteps_remaining = current_stage * 5
		advance_stage_cost *= 5
	else:
		building_select_panel.show()
		next_stage_label.text = "Next Stage: " + str(advance_stage_cost)

func _on_TimestepButton_pressed() -> void:
	Manager.timestep()
