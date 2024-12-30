extends TextureRect


func ShowPlayerIcon():
	$PlayerIcon.show()


func _on_mouse_entered():
	$ReferenceRect.show()


func _on_mouse_exited():
	$ReferenceRect.hide()
