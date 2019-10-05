
static func check_walk() -> bool: 
	if Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"):
		return true
	if Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		return true
	return false
		
static func check_grab() -> bool: 
	if Input.is_action_just_pressed("player_interact"): 
		return true
	return false