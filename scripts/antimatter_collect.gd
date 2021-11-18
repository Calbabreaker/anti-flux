extends Control

const speed := 750
const time_to_start := 0.5

onready var target_pos = Manager.antimatter_label.rect_position + $"TextureRect".rect_size / 2
var amount: int

var time := 0.0

func set_amount(antimatter: int) -> void:
	amount = antimatter
	modulate.s = log(float(amount)) / 8
	
func _process(delta: float) -> void:
	rect_rotation += 10
	
	if time > time_to_start:
		rect_position = rect_position.move_toward(target_pos, delta * speed)
		if rect_position == target_pos:
			collect()
	else:
		time += delta

func collect() -> void:
	Manager.add_antimatter(amount)
	Manager.particle_storage.remove_child(self)
	queue_free()
	
	# last antimatter collect so continue timestep
	if Manager.particle_storage.get_child_count() == 0:
		Manager.timestep_advance()
