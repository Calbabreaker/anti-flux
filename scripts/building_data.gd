class_name BuildingData

var description: String
var world_prefab: PackedScene
var texture: Texture

func _init(p_description: String, asset_name: String) -> void:
	description = p_description
	world_prefab = load("res://scenes/buildings/" + asset_name + ".tscn")
	texture = load("res://assets/" + asset_name + ".svg")
