extends Sprite

var target_collect: Sprite
var speed := 350
onready var target_pos := target_collect.position

func _process(delta: float) -> void:
	position = position.move_toward(target_pos, delta * speed)
	if position == target_pos:
		target_collect.set_amount(ceil(target_collect.amount * 1.5))
		queue_free()
