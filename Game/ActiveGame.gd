extends Node2D
class_name ActiveGame


signal exit_to_main_menu


@export var ui: CanvasLayer


var save_slot: String
var session_start_time: float  # seconds
var character_first: String
var character_last: String
var total_playtime: float


func StartGame(slot: String):
	save_slot = slot
	
	LoadGame(slot)
	$Galaxy.Activate(slot)
	
	show()
	ui.show()
	$ParallaxBackground.show()
	$TestCamera.enabled = true
	
	session_start_time = Time.get_unix_time_from_system()


func LoadGame(slot: String):
	var meta_file = FileAccess.open("%s/%s/meta.save" % [Util.SAVE_LOCATION, slot], FileAccess.READ)
	var data = JSON.parse_string(meta_file.get_as_text())
	
	character_first = data["character_name"]["first"]
	character_last = data["character_name"]["last"]
	total_playtime = data["total_playtime"]

func SaveGame(slot: String):
	var session_time = Time.get_unix_time_from_system() - session_start_time
	
	var meta_file = FileAccess.open(Util.SAVE_LOCATION + "/" + slot + "/meta.save", FileAccess.WRITE)
	var save_dict = {
		"character_name": {
			"first": character_first,
			"last": character_last
		},
		"last_played": Time.get_datetime_string_from_system(false, true),
		"total_playtime": total_playtime + session_time
	}
	meta_file.store_string(JSON.stringify(save_dict))


func _on_exit_to_main_menu():
	for n in get_children():
		n.queue_free()
	ui.hide()
	
	exit_to_main_menu.emit()


func _on_system_save_game(slot: String):
	if !slot:
		slot = save_slot
	SaveGame(slot)
