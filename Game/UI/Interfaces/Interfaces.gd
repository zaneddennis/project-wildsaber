extends Panel


func ActivateInterface(interface: Control):
	if interface.visible:
		hide()
		interface.Close()
	
	else:
		ClearInterfaces()
		show()
		interface.Activate()


func ClearInterfaces():
	for n in get_children():
		n.hide()


func _on_character_pressed():
	ActivateInterface($Character)

func _on_inventories_pressed():
	ActivateInterface($Inventories)

func _on_maps_pressed():
	ActivateInterface($Maps)

func _on_system_pressed():
	ActivateInterface($System)
