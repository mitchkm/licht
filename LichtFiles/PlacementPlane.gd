extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var placing = false
# Called when the node enters the scene tree for the first time.
func placePeice():
	var placement = load("res://Placeable.tscn").instance()
	placement.position = get_global_mouse_position()
	placement.position.x = 32 + (64*(int(placement.position.x)/64))
	placement.position.y = 32 + (64*(int(placement.position.y)/64))
	add_child(placement)
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("mouse_right_click") && !placing):
		if(self.find_node("LICHT")):
			var licht = self.find_node("LICHT")
			if(licht.skelies >= 10):
				placePeice()
				licht.skelies -= 10
				placing = true;
		else:
			placePeice()
			placing = true;
		
	elif(Input.is_action_just_pressed("mouse_click") && placing):
		placing = false
		

