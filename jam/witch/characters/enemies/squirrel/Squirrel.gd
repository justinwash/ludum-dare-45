extends Enemy

class_name Squirrel

# Called when the node enters the scene tree for the first time.
func _ready():
	self.aggressive = false
	self.health = 5

func _process(deltatime):
	if check_kill():
		.kill()

func kill():
	print("kill from Squirrel.gd")