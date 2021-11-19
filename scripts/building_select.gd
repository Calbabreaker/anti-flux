extends Button

var current_building_name: String
onready var description_label := $"Description" 
onready var title_label := $"Title" 
onready var texture_rect := $"TextureRect"
onready var rarity_label := $"RarityLabel"

func set_building(name: String):
	var building = Global.building_data[name]
	description_label.text = building.description
	title_label.text = name
	texture_rect.texture = Global.building_data[name].texture
	rarity_label.bbcode_text = building.rarity.bbcode_text
	current_building_name = name

func set_random_building():
	var rand_num = randi() % Global.building_names.size()
	var building_name = Global.building_names[rand_num]
	var building_prob = Global.building_data[building_name].rarity.probablity
	if randi() % 100 < building_prob:
		set_building(building_name)
	else:
		set_random_building()

func _on_BuildingSelect_pressed() -> void:
	Global.emit_signal("select_building", current_building_name)
	Global.emit_signal("bsp_visible", false)
