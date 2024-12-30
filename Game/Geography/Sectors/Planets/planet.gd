extends RefCounted
class_name Planet


enum PLANET_TYPE {PLANET, MOON}

var id: int
var name: String
var planet_type: PLANET_TYPE = PLANET_TYPE.PLANET

var location: GeoUtil.RingLocation
var atmosphere: float = 0.0  # [0.0, 1.0] where 0.7 (?) is Earthlike sea level
var temperature: float = 0.0  # [0.0, 1.0] where 0.5 is temperate Earthlike (this is going to end up being a nonlinear function)
var moisture: float = 0.0  # [0.0, 1.0] where 0.5 is average Earthlike (???)
# heightmap
# biomes


static func ParsePlanet(data: Dictionary) -> Planet:
	var p = Planet.new()
	p.id = data["id"]
	p.name = data["name"]
	
	p.location = GeoUtil.RingLocation.new(data["location"][0], data["location"][1])
	
	p.atmosphere = data["atmosphere"]
	p.temperature = data["temperature"]
	p.moisture = data["moisture"]
	
	return p


func _to_string() -> String:
	return "<Planet:%d:%s>" % [id, name]
