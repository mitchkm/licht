extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var refresh = 0
var refreshRate = 4
var middle 
var topSpawn
# Called when the node enters the scene tree for the first time.
func _ready():
	middle = self.get_viewport().size.y/2
	topSpawn = middle-128
	randomize() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	refresh += delta
	if(refresh >= refreshRate):
		var spot = (randi()%5)+1
		var newEnemy = load("res://Scenes/Enemy.tscn").instance()
		newEnemy.position = Vector2(1000, (spot*64)+topSpawn)
		var scene = get_parent()
		if(scene):
			scene.add_child(newEnemy)
		refresh = 0
		
	
