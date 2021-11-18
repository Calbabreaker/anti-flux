extends Control

const speed := 750
const time_to_start := 0.5

var target_pos: Vector2
var amount: int

var time := 0.0

func set_antimatter_label_pos(position: Vector2):
	target_pos = position + $"TextureRect".rect_size / 2

func set_amount(antimatter: int) -> void:
	amount = antimatter
	modulate.s = log(float(amount)) / 8
	
func _process(delta: float) -> void:
	rect_rotation += 10
	
	if time > time_to_start:
		rect_position = rect_position.move_toward(target_pos, delta * speed)
		if rect_position == target_pos:
			# delete self
			get_parent().remove_child(self)
			queue_free()
			Global.emit_signal("collect_antimatter", amount)
	else:
		time += delta
