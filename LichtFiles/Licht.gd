extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var lazerz = [1]
var skelies = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	skelies = 200
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var placePlane = get_parent()
	if(placePlane):
		var testSpace = placePlane.get_world_2d().direct_space_state
		#testLight(testSpace, self.position+(Vector2(1,0).normalized())*128, self.position+Vector2(64,0), 1)
	