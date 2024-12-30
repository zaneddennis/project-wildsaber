extends Node2D
class_name SectorMapRingObjectIcon


signal hovered


var belt_radius: float = 0.0
var mouse_is_hovering_belt: bool = false


func _process(delta: float) -> void:
	if belt_radius > 0:
		CheckBeltHover()


func ActivatePlanet(pos: Vector2):
	$Belt.hide()
	belt_radius = 0
	$Planet.show()
	position = pos

func ActivateBelt(pos: Vector2, ring: int):
	$Planet.hide()
	$Belt.show()
	position = pos
	$Belt.region_rect.position.x = 576 * ring
	belt_radius = (ring + 1.5) * 32

func Deactivate():
	$Planet.hide()
	$Belt.hide()
	belt_radius = 0


func CheckBeltHover():
	var mpos = get_viewport().get_mouse_position() - Vector2(320, 320)
	var mdist = mpos.length()
	
	if abs(mdist - belt_radius) <= 8.0 and not mouse_is_hovering_belt:
		mouse_is_hovering_belt = true
		hovered.emit()
	else:
		mouse_is_hovering_belt = false


func _on_planet_hovered() -> void:
	hovered.emit()
