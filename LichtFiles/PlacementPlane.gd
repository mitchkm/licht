extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var placing = false
# Called when the node enters the scene tree for the first time.
func placePeice():
	var placement = load("res://Placeable.tscn").instance()
	placement.position = get_global_mouse_position()
	add_child(placement)
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_mouse_button_pressed(2) && !placing):
		if(self.find_node("Licht")):
			var licht = self.find_node("Licht")
			if(licht.skelies >= 10):
				placePeice()
				licht.skelies -= 10
				placing = true;
		else:
			placePeice()
			placing = true;
		
	if(Input.is_mouse_button_pressed(1) && placing):
		placing = false
