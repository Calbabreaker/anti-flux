extends Panel

onready var pay_label = $"PayButton/RichTextLabel"
onready var restart_button = $"RestartButton"
onready var title_label = $"TitleLabel"
onready var description_label = $"DescriptionLabel"

func update_show() -> void:
	if Manager.antimatter < Manager.advance_stage_cost:
		# lose
		restart_button.show()
		pay_label.get_parent().hide()
		title_label.text = "Unable to pay!"
		description_label.text = "The factory has been destroyed because you were unable to pay for it!"
	else:
		# pass
		restart_button.hide()
		pay_label.get_parent().show()
		pay_label.bbcode_text = "[center]Pay {} {}[/center]".format([Manager.antimatter_icon, Manager.advance_stage_cost], "{}")
		title_label.text = "Pay for factory!"
		description_label.text = "The payment for the factory is due."
	
	show()

func _on_PayButton_pressed() -> void:
	hide()
	Manager.stage_advance()

func _on_RestartButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")
