extends KinematicBody2D

class_name Enemy

export var aggressive : bool
export var fleeing : bool
export var health : int setget set_health, get_health

var drops

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	drops = $Drops
	

func _process(deltatime):
	if health <= 0:
		kill()

func check_kill():
	return health <= 0

func kill():
	rng.randomize()
	print("kill from Enemy.gd")
	for enemy_drop in drops.get_children():
		if randf() < enemy_drop.probability:
			var inst = enemy_drop.item.instance()
			inst.position = self.position
			inst.position.x += rng.randf_range(-5, 5)
			inst.position.y += rng.randf_range(-5, 5)
			get_tree().get_root().get_node("Main/Items").add_child(inst)
	queue_free()

func set_health(hp):
	health = max(0, hp)

func get_health():
	return health
