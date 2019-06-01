extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var placing = false
onready var licht = get_parent().get_node("Licht")
# Called when the node enters the scene tree for the first time.
func placePeice():
	var placement = load("res://Scenes/Placeable.tscn").instance()
	placement.position = get_local_mouse_position()
	placement.position.x = -64 + (128*(int(placement.position.x)/128))
	placement.position.y = -32 + (64*(int(placement.position.y)/64))
	add_child(placement)
func _ready():
	self.position = self.get_viewport().size/float(2)
	self.z_index = self.position.y+1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("mouse_right_click") && !placing):
		if(licht):
			if(licht.skelies >= 10):
				placePeice()
				licht.skelies -= 10
				placing = true;
		else:
			placePeice()
			placing = true;
		
	elif(Input.is_action_just_pressed("mouse_click") && get_global_mouse_position().x && placing):
		placing = false
		

