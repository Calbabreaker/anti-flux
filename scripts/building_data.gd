class_name BuildingData

var description: String
var world_prefab: PackedScene

func _init(p_description: String, p_world_prefab: PackedScene) -> void:
	description = p_description
	world_prefab = p_world_prefab
