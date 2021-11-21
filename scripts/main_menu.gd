extends CanvasLayer

func _on_PlayButton_pressed() -> void:
    get_tree().change_scene("res://scenes/main.tscn")

func _on_Links_pressed() -> void:
    OS.shell_open("https://github.com/Calbabreaker")

func _on_Credit_pressed() -> void:
    OS.shell_open("https://freesound.org/people/Clacksberg/sounds/506324/")
