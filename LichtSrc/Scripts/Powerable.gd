extends CollisionShape2D

class PowerData:
	var lp = 0
	var la
	var color
	var collision_point
	var norm

# Declare member variables here. Examples:
var p_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	self.disabled = true;
	
func powered():
	return not self.p_data.empty()
	
func get_p_data(index):
	return self.p_data.get(self.p_data.keys()[index])

func lazer_on(name, power, angle, color,  collision_point, norm):
	if not self.p_data.has(name):
		self.p_data[name] = PowerData.new()
	var pd: PowerData = self.p_data[name]
	pd.lp = power
	pd.la = angle
	pd.color = color
	pd.collision_point = collision_point
	pd.norm = norm
	
func lazer_off(name, power, angle, color, collision_point, norm):
	if self.p_data.has(name):
		self.p_data.erase(name)