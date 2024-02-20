extends Object
class_name Sector


const BACKGROUND_COLORS = [
	Color("000000"), Color("242424"), Color("261325"), Color("260e0e"),
	Color("261d0d"), Color("331d0c"), Color("101b26"), Color("0d1a09")
]

const MAX_RINGS = 8
const MAJOR_OBJECT_SUN = "sun"

var coords: Vector2i
var asteroid_density: float  # (0, 1)
var background_color_ix: int  # corresponds to BACKGROUND_COLORS
var background_densities: Array  # [far, middle, near]

var name: String
var major_object: String

var rings: Array


func GetName():
	if name:
		return name + " System"
	else:
		return "Sector %d-%d" % [coords.x, coords.y]


func ParseSector(c: Vector2i, dict: Dictionary):
	coords = c
	
	asteroid_density = dict["asteroid_density"]
	background_color_ix = dict["background_color_ix"]
	background_densities = dict["background_densities"]
	major_object = dict["major_object"]
	
	name = dict["name"]
	rings = dict["rings"]
