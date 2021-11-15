extends Sprite

var target_pos = Vector2(32, 32)
var speed := 750
var time_to_start := 0.5
var amount: int

var time := 0.0

func set_amount(antimatter: int) -> void:
	amount = antimatter
	modulate.s = log(float(amount)) / 10
	
func _process(delta: float) -> void:
	rotation += 10
	
	if time > time_to_start:
		position = position.move_toward(target_pos, delta * speed)
		if position == target_pos:
			collect()
	else:
		time += delta

func collect() -> void:
	Manager.add_antimatter(amount)
	queue_free()
	
	# last antimatter collect so continue timestep
	if get_parent().get_child_count() == 1:
		Manager.ui.timestep_advance()
