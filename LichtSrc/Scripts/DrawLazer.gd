extends Node2D

# Declare member variables here. Examples:
var target = Vector2()
var color = Color(255, 255, 255)
var width = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _draw():
	if target:
		draw_line(Vector2(), target, color, width)