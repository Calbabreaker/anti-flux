class_name BuildingData

var description_bbcode: String
var script_file: Script
var texture: Texture
var rarity: Rarity

const small_icon_bbcode = "[font=res://assets/bbcode_font.tres][img=25]res://assets/textures/antimatter.svg[/img][/font]"

func _init(description: String, asset_name: String, p_rarity: Rarity) -> void:
    var description_with_icons := description.replace("{}", small_icon_bbcode)
    description_bbcode = "[center]{}[/center]".format([description_with_icons], "{}")
    script_file = load("res://scripts/buildings/" + asset_name + ".gd")
    texture = load("res://assets/textures/" + asset_name + ".svg")
    rarity = p_rarity
