extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var refresh = 0
var refreshRate = 2
var numGen = (RandomNumberGenerator)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	refresh += delta
	if(refresh >= refreshRate):
		var spot = randi()%8
		var newEnemy = load("res://Enemy.tscn").instance()
		newEnemy.position = Vector2(1000, (spot*128)+128)
		var scene = get_parent()
		if(scene):
			scene.add_child(newEnemy)
		refresh = 0
		
	
