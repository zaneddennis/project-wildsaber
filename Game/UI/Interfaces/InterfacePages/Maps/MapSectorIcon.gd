extends TextureRect


func _on_mouse_entered():
	$ReferenceRect.show()


func _on_mouse_exited():
	$ReferenceRect.hide()
