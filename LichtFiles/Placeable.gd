extends KinematicBody2D

# Declare member variables here. Examples:
onready var lazer = get_node("Lazer")
onready var powerable = get_node("Powerable")
var lazer_effect = preload("res://lazer_end_effect.tscn")
var clicked = false
var timer = 0
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
	efct.set_emitting(false);
	self.add_child(efct)
	efct.scale *= 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	var sprite = self.get_node("Sprite")
	if(Input.is_mouse_button_pressed(1)):
		placed = true
		powerable.set_disabled(false)
	elif(!placed):	
		self.position = get_parent().get_local_mouse_position()
		self.position.x = -64 + (128*(int(self.position.x)/128))
		self.position.y =  (64*(int(self.position.y)/64))
		self.z_index = self.position.y+1		
		
	if(Input.is_action_just_pressed("mouse_middle_click") && !placed):
		self.powerable.rotate(PI/2)
		currentText += 1
		currentText = currentText%4
		sprite.texture = textures[currentText]
		
func _physics_process(delta):
	if powerable.powered() and not lazer.enabled:
		efct.position = self.to_local(powerable.collision_point)
		efct.set_emitting(true)
		lazer.position = self.to_local(powerable.collision_point)
		var angle = powerable.la + PI/2 * get_flip()
		lazer.la = angle
		lazer.snap_angle()
		lazer.lp = powerable.lp
		lazer.calc_cast_to()
		lazer.enabled = true
		lazer.get_node("DrawLazer").visible = true
	elif not powerable.powered():
		lazer.enabled = false
		lazer.get_node("DrawLazer").visible = false
		efct.set_emitting(false)
	
func get_flip():
	if currentText == 1:
		return -1
	else:
		return 1