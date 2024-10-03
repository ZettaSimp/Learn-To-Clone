extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globs.game_state > 0:
		if get_self_modulate()[3] < 0.7:
			set_self_modulate(Color(0,0,0,get_self_modulate()[3] + 0.7*delta))
		else:
			Globs.game_state = 2
	else:
		set_self_modulate(Color(0,0,0,0))
	pass
