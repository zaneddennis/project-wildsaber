extends Node


func _on_main_menu_start_game(slot: String):
	$ActiveGame.StartGame(slot)


func _on_active_game_exit_to_main_menu():
	$MainMenu.show()
	$MainMenu.Activate()
