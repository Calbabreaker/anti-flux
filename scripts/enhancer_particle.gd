extends Sprite

var target_pos: Vector2
var speed := 750

func _process(delta: float) -> void:
	rotation += 10
	position = position.move_toward(target_pos, delta * speed)
