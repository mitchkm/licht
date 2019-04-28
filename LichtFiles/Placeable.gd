extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clicked = false
var timer = 0
var placed = false
var currentText = 0
var textures =  \
[load("res://normSkelieDL.png"),
 load("res://normSkelieUL.png"),
 load("res://normSkelieUR.png"),
 load("res://normSkelieDR.png")]
# Called when the node enters the scene tree for the first time.
func _ready():
	 self.get_node("Sprite").texture = textures[currentText]# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sprite = self.get_node("Sprite")
	if(Input.is_mouse_button_pressed(1)):
		placed = true
	elif(!placed):	
		self.position = get_global_mouse_position()
		self.position.x = 32 + (64*(int(self.position.x)/64))
		self.position.y = 32 + (64*(int(self.position.y)/64))
		self.z_index = self.position.y
	if(Input.is_action_just_pressed("mouse_middle_click") && !placed):
		self.get_node("CollideBox").rotate(PI/2)
		currentText += 1
		currentText = currentText%4
		sprite.texture = textures[currentText]
		sprite.position = Vector2(sprite.position.x*(((currentText%2))), sprite.position.y*((-(currentText%2))))