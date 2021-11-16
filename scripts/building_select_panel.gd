extends PopupPanel

onready var building_select_container := $"Wrapper/Container"
onready var timestep_label := $"Wrapper/TimestepLabel"
onready var stage_cost_label := $"Wrapper/StageCostLabel"

func show():
	timestep_label.text = "Timesteps left: " + str(Manager.timesteps_left)
	stage_cost_label.text = "Stage cost: " + str(Manager.advance_stage_cost)
	
	for building_select in building_select_container.get_children():
		building_select.set_random_building()
	popup()
