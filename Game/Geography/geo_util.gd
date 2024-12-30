extends RefCounted
class_name GeoUtil


class RingLocation:
	var ring: int
	var radians: float  # radians
	
	func _init(r: int, rad: float) -> void:
		ring = r
		radians = rad
	
	func to_position(ring_size: int) -> Vector2:
		var angle = Vector2.from_angle(-1 * radians)
		return Vector2(320, 320) + (ring + 1.5) * ring_size * angle
