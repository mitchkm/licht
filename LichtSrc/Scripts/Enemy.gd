extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 20
var health = 800;
var efct
var particles
signal enemyKilled
onready var powerable = get_node("Powerable")
var lazer_effect = preload("res://Scenes/lazer_end_effect.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	efct = lazer_effect.instance()
	efct.set_emitting(false);
	self.add_child(efct)
	efct.scale *= 2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x -= speed*delta
	self.z_index = self.position.y-1
	if(health <= 0):
		die()
		

func _physics_process(delta):
	if powerable.powered():
		var pwr = powerable.get_p_data(0)
		efct.position = self.to_local(pwr.collision_point)
		efct.get_process_material().color = pwr.color + Color(0.05, 0, 0.05)
		efct.set_emitting(true)
		efct.global_position = self.global_position
		health -= pwr.lp;
	elif not powerable.powered():
		efct.set_emitting(false)
		
func die():
	emit_signal("enemyKilled")
	queue_free()