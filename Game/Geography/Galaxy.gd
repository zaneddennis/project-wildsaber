extends Node
class_name Galaxy


const MAX_SIZE = 20

var size: Vector2i
var sectors: Array


func Activate(slot: String):
	LoadGalaxy(slot)


func GetSectorV(v: Vector2i):
	return sectors[v.x][v.y]


func LoadGalaxy(slot: String):
	var file = FileAccess.open("%s/%s/galaxy.save" % [Util.SAVE_LOCATION, slot], FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	size = Vector2i(data["size_x"], data["size_y"])
	
	LoadSectors(slot)


func LoadSectors(slot: String):
	var file = FileAccess.open("%s/%s/sectors.save" % [Util.SAVE_LOCATION, slot], FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	sectors = []
	for x in range(size.x):
		sectors.append([])
		for y in range(size.y):
			var s = data["%d,%d" % [x, y]]
			var sector = Sector.new()
			sector.ParseSector(Vector2i(x, y), s)
			sectors[x].append(sector)
