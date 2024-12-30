extends Node
class_name Util


const SAVE_LOCATION = "user://save_data"


static func LoadJSON(slot: String, filename: String):  # --> Dictionary or Array
	var file = FileAccess.open("%s/%s/%s" % [SAVE_LOCATION, slot, filename], FileAccess.READ)
	return JSON.parse_string(file.get_as_text())
