extends Sprite

var target_pos = Vector2(32, 32)
var speed := 750
var amount := 1

func _ready() -> void:
	modulate.s = log(float(amount)) / 10

func _process(delta: float) -> void:
	position = position.move_toward(target_pos, delta * speed)
	rotation += 10
	
	if position == target_pos:
		Manager.add_antimatter(amount)
		queue_free()
		
		# last antimatter collect so show select building stuff
		if get_parent().get_child_count() == 1:
			Manager.ui.timestep_advance()
