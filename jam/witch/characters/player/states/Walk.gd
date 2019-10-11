extends "res://utilities/State.gd"

class_name Walk

const Updates = preload("Updates.gd")

func enter():
	.enter()

	print("walk")

func update():
	if Input.is_action_pressed("ui_right"):
		actor.move_dir.x = 1
		$"../../AnimatedSprite".play("walkright");
	elif Input.is_action_pressed("ui_left"):
		actor.move_dir.x = -1
		$"../../AnimatedSprite".play("walkleft");
	else:
		actor.move_dir.x = 0

	if Input.is_action_pressed("ui_up"):
		actor.move_dir.y = -1
		if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
			$"../../AnimatedSprite".play("walkup");
	elif Input.is_action_pressed("ui_down"):
		actor.move_dir.y = 1
		if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
			$"../../AnimatedSprite".play("walkdown");
	else:
		actor.move_dir.y = 0

	if Updates.check_grab():
		emit_signal("change_state", "grabbing")

	actor.move_and_slide(Vector2(actor.move_dir.x, actor.move_dir.y).normalized() * actor.MOVE_SPEED, Vector2(0, -1))

	if actor.move_dir.x == 0 && actor.move_dir.y == 0:
		$"../../AnimatedSprite".stop();
		$"../../AnimatedSprite".set_frame(1);
		emit_signal("change_state", "idle")