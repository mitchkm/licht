extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var lazerz = [1]
var skelies = 0
var lp = 2
var la
onready var lazer = get_node("Lazer")
var space
var old_collide
# Called when the node enters the scene tree for the first time.
func _ready():
	skelies = 200
	la = lazer.position.angle_to(lazer.cast_to)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var placePlane = get_parent()
	if(not space and placePlane):
		space = placePlane.get_world_2d().direct_space_state
		#testLight(testSpace, self.position+(Vector2(1,0).normalized())*128, self.position+Vector2(64,0), 1)

func _draw():
	if old_collide:
		draw_line(Vector2(), old_collide.position -  self.position, Color(255, 255, 255), lp)
	else:
		draw_line(Vector2(), Vector2(1000, 0), Color(255, 255, 255), lp)

func _physics_process(delta):
	update()
	if lazer.is_colliding() and (not old_collide or old_collide.name != lazer.get_collider().name):
		if old_collide:
			old_collide.call("lazer_off", lp, la)
		old_collide = lazer.get_collider()
		old_collide.call("lazer_on", lp, la)
	elif not lazer.is_colliding():
		if old_collide:
			old_collide.call("lazer_off", lp, la)
		old_collide = null
		