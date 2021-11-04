extends PopupPanel

onready var building_select_container := $"Wrapper/Container"

func show():
	for building_select in building_select_container.get_children():
		building_select.set_random_building()
	popup()
