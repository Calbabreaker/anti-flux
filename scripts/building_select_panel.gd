extends Panel

onready var building_select_container := $"Wrapper/Container"
onready var stage_label := $"Wrapper/StageLabel"

func update_show(current_stage: int, end_stage: int) -> void:
    stage_label.text = "Stages: {}/{}".format([current_stage, end_stage], "{}")
    for building_select in building_select_container.get_children():
        building_select.set_random_building()
    show()

func _on_SkipButton_pressed() -> void:
    hide()
    Global.emit_signal("timestep")
