extends Enemy

class_name Squirrel

var flee_timer

var player

var total_time = 0

var current_tree

export var roam_timeout : float
var current_roam_timeout : float

export var max_tree_distance : float
export var node_removal_distance : float


var nav_2d

var collision_shape

var roam_path = []

func _init():
	self.aggressive = false
	self.health = 5
	self.fleeing = false
	self.flee_timer = 5.0
	self.current_roam_timeout = roam_timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main/Player")
	nav_2d = get_tree().get_root().get_node("Main/Navigation2D")
	collision_shape = get_node("CollisionShape2D")
	

func _physics_process(delta):
	total_time += delta
	current_roam_timeout = max(0, current_roam_timeout - delta)

	if self.fleeing:
		flee()

		flee_timer -= delta
		if flee_timer <= 0:
			fleeing = false
	else: # roaming
		roam()
		pass

	if check_kill():
		.kill()

func flee():
	var flee_dir = get_direction_away_from_player()
	self.move_and_slide(flee_dir * self.move_speed * self.fleeing_move_speed_mult, Vector2(0, -1))

func roam():
	if not current_tree || dist_to_current_tree() < node_removal_distance || current_roam_timeout <= 0:
		current_tree = select_tree()
		current_roam_timeout = roam_timeout
		roam_path = PoolVector2Array()
	
	var start_pos = self.position
	var end_pos = current_tree.position

	if not roam_path || roam_path.size() == 0:
		print("roam_path was empty, trying to find path")
		roam_path = nav_2d.get_simple_path(start_pos, end_pos)
		if roam_path.size() == 0:
			print("failed to find path, selecting new target tree")
			current_tree = select_tree()
	else:
		var distance_to_current_node = self.position.distance_to(roam_path[0])
		if distance_to_current_node <= node_removal_distance:
			roam_path.remove(0)
		if not roam_path.size() == 0:
			var roam_dir = (roam_path[0] - self.position).normalized()
			self.move_and_slide(roam_dir * self.move_speed * self.roaming_move_speed_mult, Vector2(0, -1))
	
func dist_to_current_tree():
	if current_tree:
		return self.position.distance_to(current_tree.position)

func select_tree():
	var trees = get_tree().get_nodes_in_group("Tree")
	rng.randomize()
	return trees[rng.randi() % trees.size()]
	# var distance = self.position.distance_to(pick.position)
	# while distance > max_tree_distance:
	# 	pick = trees[rng.randi() % trees.size()]
	# 	distance = self.position.distance_to(pick.position)
	# 	print("pick was %f away" % distance)
	# return pick


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



	