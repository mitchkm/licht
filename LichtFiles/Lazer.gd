extends RayCast2D

# Declare member variables here. Examples:
onready var drawLazer = get_node("DrawLazer")
var lp = 8
var color = Color(1, 1, 1)
var la = 0
var default_target
var old_collide

# Called when the node enters the scene tree for the first time.
func _ready():
	la = self.position.angle_to(self.cast_to)
	default_target = self.cast_to - self.position

func _physics_process(delta):
	#update()
	if self.is_colliding() and (not old_collide or old_collide.name != self.get_collider().name):
		if old_collide:
			old_collide.call("lazer_off", lp, la)
		old_collide = self.get_collider()
		old_collide.call("lazer_on", lp, la)
	elif not self.is_colliding():
		if old_collide:
			old_collide.call("lazer_off", lp, la)
		old_collide = null
	draw_Lzr()

func draw_Lzr():
	drawLazer.width = lp
	drawLazer.color = color
	if old_collide:
		drawLazer.target = old_collide.position -  self.get_parent().position
		drawLazer.target.y += self.position.y
		drawLazer.target.x += self.position.x
	else:
		drawLazer.target = default_target
