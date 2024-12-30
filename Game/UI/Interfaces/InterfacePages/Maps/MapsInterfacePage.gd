extends "res://Game/UI/Interfaces/InterfacePages/InterfacePage.gd"


@export var galaxy: Galaxy
var current_sector: Sector

@export var EmptySectorIcon: PackedScene
@export var SolarSystemIcon: PackedScene

const GALAXY_GRID_SIZE = 32
const GALAXY_RING_ICON_SIZE = 36
const GALAXY_RING_ICON_IXES = {
	"": 0,
	"planet": 2,
	"belt": 3
}

const SECTOR_RING_SIZE = 32


enum MAP_LEVEL {PLANET, SECTOR, GALAXY}
var selected_level: MAP_LEVEL = MAP_LEVEL.GALAXY


func _ready() -> void:
	for r in range(8):
		var smri: SectorMapRingObjectIcon = $HBoxContainer/Map/VBoxContainer/SectorMap/SubViewportContainer/SubViewport.get_node("Ring%d" % r)
		print(smri)
		smri.hovered.connect(_on_sector_map_ring_icon_hovered.bind(r))


func Activate(ag: ActiveGame):
	super(ag)
	
	if galaxy:
		$HBoxContainer/Map/VBoxContainer/GalaxyMap/GridContainer.columns = galaxy.size.x
		$HBoxContainer/Map/VBoxContainer/GalaxyMap/GridContainer.size = galaxy.size * GALAXY_GRID_SIZE
		$HBoxContainer/Map/VBoxContainer/GalaxyMap/GridContainer.position = Vector2.ONE * (galaxy.MAX_SIZE - galaxy.size.x) / 2 * GALAXY_GRID_SIZE
		Select(MAP_LEVEL.GALAXY)
		
		current_sector = galaxy.GetSectorV(ag.current_sector_coords)


func Select(level: MAP_LEVEL):
	match level:
		MAP_LEVEL.GALAXY:
			RenderGalaxy()
		MAP_LEVEL.SECTOR:
			RenderSector()
		_:
			assert(false)


func ClearGalaxy():
	for n in $HBoxContainer/Map/VBoxContainer/GalaxyMap/GridContainer.get_children():
		n.queue_free()

func RenderGalaxy():
	$HBoxContainer/RingDetails.hide()
	$HBoxContainer/SectorDetails.show()
	
	$HBoxContainer/Map/VBoxContainer/SectorMap.hide()
	$HBoxContainer/Map/VBoxContainer/GalaxyMap.show()
	
	ClearGalaxy()
	print("Rendering Galaxy to Maps Interface Page")
	if galaxy:
		for y in range(galaxy.size.y):
			for x in range(galaxy.size.x):
				var sector = galaxy.sectors[x][y] as Sector
				RenderGalaxySector(sector, Vector2i(x, y))

func RenderGalaxySector(sector: Sector, coords: Vector2i):
	var iconScene = EmptySectorIcon
	if sector.major_object == Sector.MAJOR_OBJECT_STAR:
		iconScene = SolarSystemIcon
	var icon = iconScene.instantiate()
	$HBoxContainer/Map/VBoxContainer/GalaxyMap/GridContainer.add_child(icon)
	icon.mouse_entered.connect(_on_sector_hovered.bind(sector))
	
	if coords == ag.current_sector_coords:
		icon.ShowPlayerIcon()

func RenderGalaxySectorDetails(sector: Sector):
	$HBoxContainer/SectorDetails/Name.text = sector.GetName()
	$HBoxContainer/SectorDetails/Asteroids.text = "Asteroid Density: %.2f" % sector.asteroid_density
	
	if sector.major_object == Sector.MAJOR_OBJECT_STAR:
		$HBoxContainer/SectorDetails/Rings.show()
		$HBoxContainer/SectorDetails/Rings/Star.texture.region.position.x = GALAXY_RING_ICON_SIZE
		
		for r in range(Sector.MAX_RINGS):
			var ri = $HBoxContainer/SectorDetails/Rings.get_node("RingIcon" + str(r))
			var ring_object = ""
			if sector.rings[r] is Planet:
				ring_object = "planet"
			elif sector.rings[r] == "belt":
				ring_object = "belt"
			
			ri.texture.region.position.x = GALAXY_RING_ICON_SIZE * GALAXY_RING_ICON_IXES[ring_object]
		
	else:
		$HBoxContainer/SectorDetails/Rings.hide()


func RenderSector():
	$HBoxContainer/SectorDetails.hide()
	$HBoxContainer/RingDetails.show()
	
	$HBoxContainer/Map/VBoxContainer/GalaxyMap.hide()
	$HBoxContainer/Map/VBoxContainer/SectorMap.show()
	
	print("Rendering Sector to Maps Interface Page")
	
	if current_sector:
		if current_sector.major_object == "star":
			$HBoxContainer/Map/VBoxContainer/SectorMap/SubViewportContainer/SubViewport/Star.show()
		else:
			hide()
		
		var r = 0
		for ring in current_sector.rings:
			var ring_object_icon: SectorMapRingObjectIcon = get_node("HBoxContainer/Map/VBoxContainer/SectorMap/SubViewportContainer/SubViewport/Ring%d" % r)
			if ring is Planet:
				ring_object_icon.ActivatePlanet(ring.location.to_position(SECTOR_RING_SIZE))
			elif ring == "belt":
				ring_object_icon.ActivateBelt(Vector2(320, 320), r)
			else:
				ring_object_icon.Deactivate()
			r += 1


func _on_sector_hovered(sector: Sector):
	RenderGalaxySectorDetails(sector)


func _on_sector_map_ring_icon_hovered(r: int):
	var ring = current_sector.rings[r]
	
	if ring is Planet:
		$HBoxContainer/RingDetails/Name.text = ring.name
		$HBoxContainer/RingDetails/Atmosphere.show()
		$HBoxContainer/RingDetails/Atmosphere/ProgressBar.value = ring.atmosphere
		$HBoxContainer/RingDetails/Temperature.show()
		$HBoxContainer/RingDetails/Temperature/ProgressBar.value = ring.temperature
		$HBoxContainer/RingDetails/Moisture.show()
		$HBoxContainer/RingDetails/Moisture/ProgressBar.value = ring.moisture
	elif ring == "belt":
		$HBoxContainer/RingDetails/Name.text = "Asteroid Belt"
		$HBoxContainer/RingDetails/Atmosphere.hide()
		$HBoxContainer/RingDetails/Temperature.hide()
		$HBoxContainer/RingDetails/Moisture.hide()


func _on_sector_pressed() -> void:
	Select(MAP_LEVEL.SECTOR)


func _on_galaxy_pressed() -> void:
	Select(MAP_LEVEL.GALAXY)
