extends RayCast2D

# Declare member variables here. Examples:
onready var drawLazer = get_node("DrawLazer")
var lp = 1
var color = Color(1, 1, 1)
var la = 0
var default_target
var cur_collider

func powered():
	return self.lp > 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.default_target = self.cast_to - self.position
	self.z_index = self.position.y+10

func calc_cast_to():
	self.cast_to = default_target.rotated(self.la)
	self.cast_to += self.position

func snap_angle():
	self.la = floor(self.la / (PI/4)) * PI/4

func _physics_process(delta):
	#update()
	if cur_collider and not is_instance_valid(cur_collider):
		cur_collider = null
	if self.is_colliding() and (not cur_collider or cur_collider.name != self.get_collider().name):
		lazer_call(cur_collider, "lazer_off")
		cur_collider = self.get_collider()
		lazer_call(cur_collider, "lazer_on", self.get_collision_point(), self.get_collision_normal())
	elif cur_collider and not self.is_colliding():
		lazer_call(cur_collider, "lazer_off")
		cur_collider = null
	draw_lzr()

func lazer_call(collider, event, point = null, norm = null):
	if not collider:
		return
	var powerable = collider.get_node("Powerable")
	if powerable:
		powerable.call(event, self.get_parent().name, lp, la, color, point, norm)

func draw_lzr():
	drawLazer.width = lp
	drawLazer.color = color
	if cur_collider:
		drawLazer.target = self.to_local(self.get_collision_point())
	else:
		drawLazer.target = self.cast_to - self.position
