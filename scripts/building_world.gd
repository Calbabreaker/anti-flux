extends Sprite

var building: Building

func _enter_tree() -> void:
	# make sprite fit to the building size
	var size = texture.get_size()
	scale = Building.SIZE_VECTOR / size
