extends KinematicBody2D

# Declare member variables here. Examples:
onready var lazer = get_node("Lazer")
var skelies = 0
var lp = 8
var space 
# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.y = self.get_viewport().size.y/2
	skelies = 200
	lazer.color = Color(0.1, 0.8, 0.3, 0.9) # green
	lazer.lp = self.lp
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var placePlane = get_parent()
	if(not space and placePlane):
		space = placePlane.get_world_2d().direct_space_state
		
func addSkelies():
	skelies += 10
	