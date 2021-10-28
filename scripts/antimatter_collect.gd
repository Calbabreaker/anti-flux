extends Sprite

var target_pos = Vector2(32, 32)
var speed := 500

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position = position.move_toward(target_pos, delta * speed)
	rotation += 10
	
	if position == target_pos:
		queue_free()
		Manager.add_antimatter()
