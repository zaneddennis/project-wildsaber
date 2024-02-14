extends CanvasLayer


func _process(delta):
	$Label.text = "v%s || %.4f FPS" % [
		Debug.version,
		delta ** -1
	]
