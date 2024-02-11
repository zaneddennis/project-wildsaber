extends CanvasLayer


const SAVE_LOCATION = "user://save_data"

var saves: Dictionary
var save_names_sorted: Array


func _ready():
	saves = GetSaves()
	save_names_sorted = saves.keys()
	save_names_sorted.sort_custom(func(a, b): return saves[a]["last_played"] > saves[b]["last_played"])
	
	if len(saves) > 0:
		var most_recent_save = saves[save_names_sorted[0]]
		var last_played = most_recent_save["last_played"]
		
		$Buttons/Continue.text = "Continue Last Save:\n%s %s\n%s" % [
			most_recent_save["character_name"]["first"],
			most_recent_save["character_name"]["last"],
			last_played
		]


func _on_quit_pressed():
	get_tree().quit()


# todo: handle bad save files
func GetSaves() -> Dictionary:
	var saves_dir = DirAccess.open(SAVE_LOCATION)
	
	var result = {}
	for save_name in saves_dir.get_directories():
		var save_meta = JSON.parse_string(
			FileAccess.open(SAVE_LOCATION + "/" + save_name + "/meta.save", FileAccess.READ).get_as_text()
		)
		
		if save_meta:
			result[save_name] = save_meta
	
	return result
