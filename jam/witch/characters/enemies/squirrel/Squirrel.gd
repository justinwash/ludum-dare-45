extends Enemy

class_name Squirrel

var flee_timer

var player

func _init():
	self.aggressive = false
	self.health = 5
	self.fleeing = false
	self.flee_timer = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main/Player")

	

func _process(deltatime):
	if self.fleeing:
		flee()

		flee_timer -= deltatime
		if flee_timer <= 0:
			fleeing = false

	if check_kill():
		.kill()

func flee():
	var flee_dir = get_direction_away_from_player()
	self.move_and_slide(flee_dir * self.move_speed, Vector2(0, -1))
	
func set_health(hp):
	.set_health(hp)
	print("setting health in Squirrel.gd")

func damage(amount):
	.damage(amount)
	self.health -= amount
	self.fleeing = true
	self.flee_timer = 5.0

func kill():
	print("kill from Squirrel.gd")

func get_direction_away_from_player():
	return (self.position - player.position).normalized()