extends Panel

onready var pay_label = $"PayButton/RichTextLabel"
onready var restart_button = $"RestartButton"
onready var title_label = $"TitleLabel"
onready var description_label = $"DescriptionLabel"
onready var go_endless_button = $"GoEndlessButton"

func update_show(antimatter: int, advance_stage_cost: int, at_end_stage: bool) -> void:
	if antimatter < advance_stage_cost:
		# lose
		restart_button.show()
		pay_label.get_parent().hide()
		title_label.text = "Unable to pay!"
		description_label.text = "The factory has been destroyed because you were unable to pay for it!"
	elif at_end_stage:
		pay_label.get_parent().hide()
		go_endless_button.show()
		title_label.text = "Yay win!"
		description_label.text = "You have got through all the stages and won!"
	else:
		# pass
		pay_label.get_parent().show()
		pay_label.bbcode_text = "[center]Pay {} {}[/center]".format([Global.antimatter_icon_bbcode, advance_stage_cost], "{}")
		title_label.text = "Pay for factory!"
		description_label.text = "The payment for the factory is due."
	
	show()

func stage_advance() -> void:
	hide()
	Global.emit_signal("stage_advance")

func _on_RestartButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")
