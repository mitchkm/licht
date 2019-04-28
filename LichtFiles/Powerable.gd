extends CollisionShape2D

# Declare member variables here. Examples:
var lp = 0
var la = 0
var color = Color(1,1,1)
var collision_point = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.disabled = true;
	
func powered():
	return self.lp > 0

func lazer_on(power, angle, color,  collision_point):
	self.lp = power
	self.la = angle
	self.color = color
	self.collision_point = collision_point
	
func lazer_off(power, angle, color, collision_point):
	self.lp = 0