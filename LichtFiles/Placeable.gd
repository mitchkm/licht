extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clicked = false
var timer = 0
var lazer_effect = preload("res://lazer_end_effect.tscn")
onready var powerable = get_node("Powerable")
var efct
var placed = false
var currentText = 0
var textures =  \
[load("res://normSkelieDL.png"),
 load("res://normSkelieUL.png"),
 load("res://normSkelieUR.png"),
 load("res://normSkelieDR.png")]
# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("Sprite").texture = textures[currentText]
	efct = lazer_effect.instance()
	self.get_parent().add_child(efct)
	efct.scale *= 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	var sprite = self.get_node("Sprite")
	if(Input.is_mouse_button_pressed(1)):
		placed = true
	elif(!placed):	
		var mouse_pos = get_parent().get_local_mouse_position()
		self.position = mouse_pos
		self.position.x = 128*((int(self.position.x))/128)
		self.position.y = 64*(int(self.position.y)/64)
		self.z_index = self.position.y+1
		powerable.set_disabled(false)
		
	if(Input.is_action_just_pressed("mouse_middle_click") && !placed):
		self.get_node("Powerable").rotate(PI/2)
		currentText += 1
		currentText = currentText%4
		sprite.texture = textures[currentText]
		
func _physics_process(delta):
	efct.position = powerable.collision_point
	efct.set_emitting(powerable.lp > 0)
		
func _draw():
	if powerable.lp > 0:
		draw_line(Vector2(), Vector2(1000, 0).rotated(powerable.la + PI/2 - currentText%2 * PI), Color(255, 255, 255), powerable.lp)