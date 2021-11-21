extends Node2D

onready var click := $Click
onready var collect := $Collect
onready var generate := $Generate
onready var destroy := $Destroy

func _ready():
	# make all buttons play click sound
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")
	# connect all buttons that were created before _ready
	for child in $"/root".get_children():
		if child is BaseButton:
			connect_button(child)
		connect_button_recursive(child)

func _on_SceneTree_node_added(node):
	if node is BaseButton:
		node.connect("pressed", self, "_on_Button_pressed")

# recursively connect all buttons
func connect_button_recursive(root):
	for child in root.get_children():
		if child is BaseButton:
			connect_button(child)
		connect_button_recursive(child)

func connect_button(button):
	button.connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	click.play()
