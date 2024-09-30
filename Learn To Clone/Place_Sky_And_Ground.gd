extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	for c1 in range(-10,100):
		for c2 in range(-10,100):
			if c2 < 30:
				pass
			elif c2 == 30:
				set_cell(0,Vector2i(c1,c2),0,Vector2i(1,0))
			else:
				set_cell(0,Vector2i(c1,c2),1,Vector2i(0,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for c1 in range(-75+Globs.plpos[0],75+Globs.plpos[0]):
		for c2 in range(-25+Globs.plpos[1],50+Globs.plpos[1]):
			if c2 < 30:
				pass
			elif c2 == 30:
				set_cell(0,Vector2i(c1,c2),0,Vector2i(1,0))
			else:
				set_cell(0,Vector2i(c1,c2),1,Vector2i(0,0))
	pass
