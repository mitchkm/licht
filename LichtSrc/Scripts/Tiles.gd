extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = self.get_viewport().size/2 # Replace with function body.
	self.position.x += 64
	self.position.y += 48

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
