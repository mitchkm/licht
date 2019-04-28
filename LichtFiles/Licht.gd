extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var lazerz = [1]
var skelies = 0
# Called when the node enters the scene tree for the first time.
func testLight(testSpace, pos1, pos2, runs):
	var result = testSpace.intersect_ray(pos1, pos2)
	#var positions = [pos1, pos2]
	#lazerz[runs] = positions
	if(!result):
		runs += 1
		if(runs >= 100):
			return
		testLight(testSpace, pos1+pos1.normalized()*128, pos2+pos2.normalized()*128, runs)
	elif(result):
		if(result.normal == -(pos1+pos2).normalized()):
			return
		#testLight(testSpace, result.normal*128, result.position, runs)

func _ready():
	skelies = 200
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var placePlane = get_parent()
	if(placePlane):
		var testSpace = placePlane.get_world_2d().direct_space_state
		testLight(testSpace, self.position+(Vector2(1,0).normalized())*128, self.position+Vector2(64,0), 1)
	
func _draw():
	pass
	#for i in len(lazerz):
		#if(i):
			#draw_line(to_local(i), to_local(i), Color(1,1,1,1), 30, false)