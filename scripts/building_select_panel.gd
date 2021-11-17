extends PopupPanel

onready var building_select_container := $"Wrapper/Container"
onready var stage_label := $"Wrapper/StageLabel"

func show():
	stage_label.text = "Stages: " + str(Manager.current_stage) + "/" + str(Manager.end_stage) 
	for building_select in building_select_container.get_children():
		building_select.set_random_building()
	popup()
