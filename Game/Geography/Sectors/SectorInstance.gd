extends Node2D
class_name SectorInstance


# scenes
var star_instance_scene = preload("res://Game/Geography/Sectors/MajorObjects/StarInstance.tscn")
var planet_instance_scene = preload("res://Game/Geography/Sectors/Planets/planet_instance.tscn")

# constants
const RING_SIZE = 1024


var sector: Sector


func Activate(s: Sector):
	for n in get_children():
		n.queue_free()
	
	sector = s
	
	match sector.major_object:
		"star":
			RenderStar()
		_:
			pass
	
	print(sector.rings)
	for ring in sector.rings:
		if ring is Planet:
			RenderPlanet(ring.location.to_position(RING_SIZE))
		elif ring == "belt":
			pass


func RenderStar():
	print("\tRendering star")
	var star_instance = star_instance_scene.instantiate()
	add_child(star_instance)


func RenderPlanet(pos: Vector2):
	print("\tRendering Planet")
	var pi = planet_instance_scene.instantiate()
	add_child(pi)
	pi.position = pos
