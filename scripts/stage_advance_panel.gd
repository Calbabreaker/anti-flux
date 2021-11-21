extends Panel

onready var pay_label = $"PayButton/RichTextLabel"
onready var restart_button = $"RestartButton"
onready var title_label = $"TitleLabel"
onready var description_label = $"DescriptionLabel"
onready var go_endless_button = $"GoEndlessButton"

func hide_buttons() -> void:
	pay_label.get_parent().hide()
	restart_button.hide()
	go_endless_button.hide()

func update_show(antimatter: int, advance_stage_cost: int) -> void:
	hide_buttons()
	if antimatter < advance_stage_cost:
		# lose
		restart_button.show()
		title_label.text = "Unable to pay!"
		description_label.bbcode_text = "[center]The factory has been closed because you were unable to pay for it![/center]"
	else:
		# pass
		pay_label.get_parent().show()
		pay_label.bbcode_text = "[center]Pay {} {}[/center]".format([Global.antimatter_icon_bbcode, advance_stage_cost], "{}")
		title_label.text = "Pay for factory!"
		description_label.bbcode_text = "[center]The payment for the factory is due.[/center]"
	
	show()
	
func show_win() -> void:
	hide_buttons()
	go_endless_button.show()
	title_label.text = "Yay you win!"
	description_label.bbcode_text = "[center]You have got through all the stages and won!\n [url=https://reward.calbabreaker.repl.co]Here's your reward :)[/url][/center]"
	show()

func _on_RestartButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")

func _on_PayButton_pressed() -> void:
	hide()
	Global.emit_signal("stage_advance")

func _on_GoEndlessButton_pressed() -> void:
	hide()
	Global.emit_signal("bsp_visible", true)

func _on_DescriptionLabel_meta_clicked(meta) -> void:
	OS.shell_open(meta)
