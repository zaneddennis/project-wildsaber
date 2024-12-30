extends CanvasLayer


func _process(delta):
	$Label.text = "v%s  ||  %.3f FPS" % [
		Debug.version,
		delta ** -1
	]
