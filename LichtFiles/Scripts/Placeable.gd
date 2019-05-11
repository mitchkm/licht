extends KinematicBody2D

# Declare member variables here. Examples:
onready var lazer = get_node("Lazer")
onready var powerable = get_node("Powerable")
var lazer_effect = preload("res://Scenes/lazer_end_effect.tscn")
var efct
var offset = Vector2(1280, 640)
var placed = false
var currentText = 0
var textures =  \
[load("res://Sprites/normSkelieDL.png"),
 load("res://Sprites/normSkelieDR.png"),
 load("res://Sprites/normSkelieUR.png"),
 load("res://Sprites/normSkelieUL.png")]
# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("Sprite").texture = textures[currentText]
	efct = lazer_effect.instance()
	efct.set_emitting(false);
	self.add_child(efct)
	efct.scale *= 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):
	update()
	var sprite = self.get_node("Sprite")
	if(Input.is_mouse_button_pressed(1)):
		placed = true
		powerable.set_disabled(false)
	elif(!placed):	
		var mouse_pos = get_parent().get_local_mouse_position()
		self.position = mouse_pos
#warning-ignore:integer_division
		self.position.x = -offset.x + 128*(round((self.position.x + offset.x)/128))
#warning-ignore:integer_division
		self.position.y = -offset.y + 64*(round((self.position.y + offset.y)/64))
#warning-ignore:narrowing_conversion
		self.z_index = self.position.y+1
		powerable.set_disabled(true)
		
	if(Input.is_action_just_pressed("mouse_middle_click") && !placed):
		self.powerable.rotate(PI/2)
		currentText += 1
		currentText = currentText%4
		sprite.texture = textures[currentText]
		
#warning-ignore:unused_argument
func _physics_process(delta):
	if powerable.powered() and not lazer.enabled:
		efct.position = self.to_local(powerable.collision_point)
		efct.get_process_material().color = powerable.color + Color(0.05, 0, 0.05)
		efct.set_emitting(true)
		#lazer.position = self.to_local(powerable.collision_point)
		var angle = powerable.la + PI/2 * get_flip()
		lazer.la = angle
		lazer.snap_angle()
		lazer.lp = powerable.lp
		lazer.color = powerable.color
		lazer.calc_cast_to()
		lazer.enabled = true
		lazer.get_node("DrawLazer").visible = true
	elif not powerable.powered():
		lazer.enabled = false
		lazer.get_node("DrawLazer").visible = false
		efct.set_emitting(false)
	
func get_flip():
	if currentText%2 == 1:
		return 1
	else:
		return -1