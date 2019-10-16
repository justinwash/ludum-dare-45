extends State

class_name Attack

const _Updates = Updates

export var attack_cooldown : float

var cooldown = 0

var attack_areas
var left_attack
var right_attack
var up_attack
var down_attack


func enter():
	.enter()
	
	print("attack")

	attack_areas = actor.get_node("AttackAreas")
	left_attack = attack_areas.get_node("LeftAttackArea")
	right_attack = attack_areas.get_node("RightAttackArea")
	up_attack = attack_areas.get_node("UpAttackArea")
	down_attack = attack_areas.get_node("DownAttackArea")

	if actor.facing_dir == actor.Directions.LEFT:
		do_directional_attack(left_attack)
	elif actor.facing_dir == actor.Directions.RIGHT:
		do_directional_attack(right_attack)
	elif actor.facing_dir == actor.Directions.UP:
		do_directional_attack(up_attack)
	elif actor.facing_dir == actor.Directions.DOWN:
		do_directional_attack(down_attack)
	
	

func do_directional_attack(area):
	if cooldown == 0:
		var bodies = area.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Enemy"):
				body.damage(2)
				print("Attacked %s, %d hp remaining" % [body.name, body.health])
		cooldown = attack_cooldown

func _process(delta):
	if cooldown > 0:
		cooldown = max(0, cooldown - delta)

func update():
	if _Updates.check_walk():
		emit_signal("change_state", "walk")
	if _Updates.check_grab():
		emit_signal("change_state", "grabbing")
	if _Updates.check_menu():
		emit_signal("change_state", "menu")
	else:
		emit_signal("change_state", "idle")
