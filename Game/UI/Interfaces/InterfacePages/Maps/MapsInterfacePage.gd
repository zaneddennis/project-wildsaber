extends "res://Game/UI/Interfaces/InterfacePages/InterfacePage.gd"


@export var galaxy: Galaxy

@export var EmptySectorIcon: PackedScene
@export var SolarSystemIcon: PackedScene


const GRID_SIZE = 32


enum MAP_LEVEL {PLANET, SECTOR, GALAXY}
var selected_level: MAP_LEVEL = MAP_LEVEL.GALAXY


func Activate():
	super()
	
	if galaxy:
		$HBoxContainer/Map/VBoxContainer/Map/GridContainer.columns = galaxy.size.x
		$HBoxContainer/Map/VBoxContainer/Map/GridContainer.size = galaxy.size * GRID_SIZE
		$HBoxContainer/Map/VBoxContainer/Map/GridContainer.position = Vector2.ONE * (galaxy.MAX_SIZE - galaxy.size.x) / 2 * GRID_SIZE
		Select(MAP_LEVEL.GALAXY)


func Select(level: MAP_LEVEL):
	match level:
		MAP_LEVEL.GALAXY:
			RenderGalaxy()
		_:
			assert(false)


func ClearGalaxy():
	for n in $HBoxContainer/Map/VBoxContainer/Map/GridContainer.get_children():
		n.queue_free()


func RenderGalaxy():
	ClearGalaxy()
	print("Rendering Galaxy to Maps Interface Page")
	for y in range(galaxy.size.y):
		for x in range(galaxy.size.x):
			var sector = galaxy.sectors[x][y] as Sector
			RenderSector(sector, Vector2i(x, y))


func RenderSector(sector: Sector, coords: Vector2i):
	var iconScene = EmptySectorIcon
	if sector.major_object == "Sun":
		iconScene = SolarSystemIcon
	var icon = iconScene.instantiate()
	$HBoxContainer/Map/VBoxContainer/Map/GridContainer.add_child(icon)
