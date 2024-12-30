extends Node
class_name Galaxy


const MAX_SIZE = 20

var size: Vector2i
var sectors: Array
var planets: Array


func Activate(slot: String):
	LoadGalaxy(slot)


func GetSectorV(v: Vector2i) -> Sector:
	return sectors[v.x][v.y]


func LoadGalaxy(slot: String):
	var data = Util.LoadJSON(slot, "galaxy.json")
	
	size = Vector2i(data["size_x"], data["size_y"])
	
	LoadPlanets(slot)
	LoadSectors(slot)


func LoadPlanets(slot: String):
	var data = Util.LoadJSON(slot, "planets.json")
	
	planets = []
	for p_data in data:
		planets.append(Planet.ParsePlanet(p_data))


func LoadSectors(slot: String):
	var data = Util.LoadJSON(slot, "sectors.json")
	
	sectors = []
	for x in range(size.x):
		sectors.append([])
		for y in range(size.y):
			var s = data["%d,%d" % [x, y]]
			var sector = Sector.new()
			sector.ParseSector(Vector2i(x, y), s, planets)
			sectors[x].append(sector)
