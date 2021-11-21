extends Control

var target_collect: Control
var speed := 250
var multiplier: float
onready var target_pos := target_collect.rect_position

func _process(delta: float) -> void:
	rect_position = rect_position.move_toward(target_pos, delta * speed)
	if rect_position == target_pos:
		# ensure that generated amount stays negative
		if target_collect.amount < 0:
			multiplier = abs(multiplier)

		target_collect.set_amount(ceil(target_collect.amount * multiplier))
		queue_free()
