extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_mouse_button_pressed(1)):
		if(	!self.position)
		clicked = true
	elif(!clicked):	
		self.position = get_global_mouse_position()
		self.position.x = 32 + (64*(int(self.position.x)/64))
		self.position.y = 32 + (64*(int(self.position.y)/64))
	
