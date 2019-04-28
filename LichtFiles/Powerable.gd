extends CollisionShape2D

# Declare member variables here. Examples:
var lp = 0
var la = 0
var collision_point = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lazer_on(power, angle, collision_point):
	print_debug(angle)
	self.lp = power
	self.la = angle
	self.collision_point = collision_point
	
func lazer_off(power, angle, collision_point):
	self.lp = 0