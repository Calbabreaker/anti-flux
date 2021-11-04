class_name BuildingData

var description: String
var world_prefab: PackedScene

func _init(p_description: String, world_prefab_scene_name: String) -> void:
	description = p_description
	world_prefab = load("res://scenes/buildings/" + world_prefab_scene_name)
