class_name BuildingData

var description: String
var script_file: Script
var texture: Texture
var rarity: Rarity

func _init(p_description: String, asset_name: String, p_rarity: Rarity) -> void:
	description = p_description
	script_file = load("res://scripts/buildings/" + asset_name + ".gd")
	texture = load("res://assets/" + asset_name + ".svg")
	rarity = p_rarity
