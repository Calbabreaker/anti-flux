extends Button

var current_building_name: String
onready var description_label := $"Description"
onready var title_label := $"Title"
onready var texture_rect := $"TextureRect"
onready var rarity_label := $"RarityLabel"

func set_building(building_name: String):
    current_building_name = building_name
    var building = Global.building_data[building_name]

    title_label.text = building_name
    description_label.bbcode_text = building.description_bbcode
    rarity_label.bbcode_text = building.rarity.bbcode_text
    texture_rect.texture = building.texture

func set_random_building():
    var building_name = Global.random_building_name()
    var building_prob = Global.building_data[building_name].rarity.probablity
    if randi() % 100 < building_prob:
        set_building(building_name)
    else:
        set_random_building()

func _on_BuildingSelect_pressed() -> void:
    Global.emit_signal("select_building", current_building_name)
    Global.emit_signal("bsp_visible", false)
