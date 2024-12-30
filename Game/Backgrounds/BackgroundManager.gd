extends ParallaxBackground


const MAX_DENSITY = 512


func SetBackground(s: Sector):
	var layers = [
		$Stars_Far/Sprite2D,
		$Stars_Mid/Sprite2D,
		$Stars_Near/Sprite2D
	]
	for i in len(layers):
		print(i)
		var bkg_sprite = layers[i]
		SetStarLayer(bkg_sprite, s.background_densities[i])

func SetStarLayer(s: Sprite2D, d: float):
	var image = Image.create(3840, 3840, false, Image.FORMAT_RGB8)
	
	# set star pixels here
	print("Layer density: ", d)
	for i in range(MAX_DENSITY):
		image.set_pixel(randi() % 3840, randi() % 3840, Color.WHITE)
	
	var tx = ImageTexture.create_from_image(image)
	s.texture = tx
