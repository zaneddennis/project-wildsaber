extends Camera2D


func _process(delta):
	if enabled:
		var v = Input.get_vector(
			"move_left", "move_right", "move_up", "move_down"
		)
		translate(v * 256 * delta)
		
		if Input.is_action_just_pressed("zoom_out") and zoom.x > 0.5:
			zoom *= 0.5
		elif Input.is_action_just_pressed("zoom_in") and zoom.x < 2.0:
			zoom *= 2.0
