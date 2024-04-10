extends "res://Game/UI/Interfaces/InterfacePages/InterfacePage.gd"


@export var galaxy: Galaxy

@export var EmptySectorIcon: PackedScene
@export var SolarSystemIcon: PackedScene

const GRID_SIZE = 32

const RING_ICON_SIZE = 36
const RING_ICON_IXES = {
	"": 0,
	"planet": 2,
	"belt": 3
}


enum MAP_LEVEL {PLANET, SECTOR, GALAXY}
var selected_level: MAP_LEVEL = MAP_LEVEL.GALAXY


func Activate(ag: ActiveGame):
	super(ag)
	
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
	if sector.major_object == Sector.MAJOR_OBJECT_SUN:
		iconScene = SolarSystemIcon
	var icon = iconScene.instantiate()
	$HBoxContainer/Map/VBoxContainer/Map/GridContainer.add_child(icon)
	icon.mouse_entered.connect(_on_sector_hovered.bind(sector))
	
	if coords == ag.current_sector_coords:
		icon.ShowPlayerIcon()


func RenderSectorDetails(sector: Sector):
	$HBoxContainer/Sector_Details/Name.text = sector.GetName()
	$HBoxContainer/Sector_Details/Asteroids.text = "Asteroid Density: %.2f" % sector.asteroid_density
	
	if sector.major_object == Sector.MAJOR_OBJECT_SUN:
		$HBoxContainer/Sector_Details/Rings.show()
		$HBoxContainer/Sector_Details/Rings/Sun.texture.region.position.x = RING_ICON_SIZE
		
		for r in range(Sector.MAX_RINGS):
			var ri = $HBoxContainer/Sector_Details/Rings.get_node("RingIcon" + str(r))
			
			ri.texture.region.position.x = RING_ICON_SIZE * RING_ICON_IXES[sector.rings[r]]
		
	else:
		$HBoxContainer/Sector_Details/Rings.hide()


func _on_sector_hovered(sector: Sector):
	RenderSectorDetails(sector)
