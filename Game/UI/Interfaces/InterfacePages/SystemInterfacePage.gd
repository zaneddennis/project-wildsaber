extends "res://Game/UI/Interfaces/InterfacePages/InterfacePage.gd"


signal exit_to_main_menu
signal save_game(slot: String)


@onready var sub_pages = [
	$Content/Save, $Content/MainMenu, $Content/Quit
]


func ClearSubpages():
	for sp in sub_pages:
		sp.hide()


func _on_save_pressed():
	ClearSubpages()
	$Content/Save.show()

func _on_main_menu_pressed():
	ClearSubpages()
	$Content/MainMenu.show()

func _on_quit_pressed():
	ClearSubpages()
	$Content/Quit.show()


func _on_mm_confirm_pressed():
	exit_to_main_menu.emit()

func _on_quit_confirm_pressed():
	get_tree().quit()


func _on_save_current_pressed():
	save_game.emit("")
