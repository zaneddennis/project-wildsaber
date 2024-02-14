extends Node
class_name Galaxy


const MAX_SIZE = 20

var size: Vector2i
var sectors: Array


func Activate(slot: String):
	LoadGalaxy(slot)


func LoadGalaxy(slot: String):
	var file = FileAccess.open("%s/%s/galaxy.save" % [Util.SAVE_LOCATION, slot], FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	size = Vector2i(data["size_x"], data["size_y"])
	
	sectors = []
	for x in range(size.x):
		sectors.append([])
		for y in range(size.y):
			var mo = ""
			if "%d,%d" % [x, y] in data["sectors"]:
				mo = data["sectors"]["%d,%d" % [x, y]]
			sectors[x].append(
				Sector.new(mo)
			)
