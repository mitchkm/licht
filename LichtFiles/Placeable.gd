extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clicked = false
var timer = 0
var lazer_effect = preload("res://lazer_end_effect.tscn")
var efct
var lp = 0
var la
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
	update()
	var sprite = self.get_node("Sprite")
	if(Input.is_mouse_button_pressed(1)):
		placed = true
	elif(!placed):	
		self.position = get_global_mouse_position()
		self.position.x = 32 + (64*(int(self.position.x)/64))
		self.position.y = 32 + (64*(int(self.position.y)/64))
		
	if(Input.is_action_just_pressed("mouse_middle_click") && !placed):
		self.get_node("CollideBox").rotate(PI/2)
		currentText += 1
		currentText = currentText%4
		sprite.texture = textures[currentText]
		
func _draw():
	if lp > 0:
		draw_line(Vector2(), Vector2(1000, 0).rotated(la + PI/2 - currentText%2 * PI), Color(255, 255, 255), lp)

func lazer_on(power, angle):
	print_debug(angle)
	lp = power
	la = angle
	efct = lazer_effect.instance()	
	add_child(efct)
	efct.scale *= 2
	efct.set_emitting(true)
	
func lazer_off(power, angle):
	print_debug("exit")
	lp = 0
	if efct:
		efct.free()