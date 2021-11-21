class_name Rarity

var probablity: int
var bbcode_text: String

func _init(p_probablity: int, ui_name: String, color_hex: String) -> void:
    probablity = p_probablity
    bbcode_text = "[center][color={}]{}[/color][/center]".format([color_hex, ui_name], "{}")
