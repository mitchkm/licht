extends RayCast2D

# Declare member variables here. Examples:
onready var drawLazer = get_node("DrawLazer")
var lp = 8
var color = Color(1, 1, 1)
var la = 0
var default_target
var cur_collider

# Called when the node enters the scene tree for the first time.
func _ready():
	la = self.position.angle_to(self.cast_to)
	default_target = self.cast_to - self.position

func _physics_process(delta):
	#update()
	if self.is_colliding() and (not cur_collider or cur_collider.name != self.get_collider().name):
		lazer_call(cur_collider, "lazer_off")
		cur_collider = self.get_collider()
		lazer_call(cur_collider, "lazer_on", self.get_collision_point())
	elif not self.is_colliding():
		lazer_call(cur_collider, "lazer_off")
		cur_collider = null
	draw_lzr()

func lazer_call(collider, event, point = null):
	if not collider:
		return
	var powerable = collider.get_node("Powerable")
	if powerable:
		powerable.call(event, lp, la, point)

func draw_lzr():
	drawLazer.width = lp
	drawLazer.color = color
	if cur_collider:
		drawLazer.target = cur_collider.position -  self.get_parent().position
		drawLazer.target.y += self.position.y
		drawLazer.target.x += self.position.x
	else:
		drawLazer.target = default_target
