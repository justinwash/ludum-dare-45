extends ColorRect

var frame = 0
func _physics_process(delta):
	frame += 1
	
	if ((frame / 60) % 60 == 0):
		if ((frame / 60) % 120 == 0):
			self.visible = false
		else:
			self.visible = true
	
	
	
	
	
