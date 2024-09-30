extends Sprite2D

var pre_pos = Globs.glob_pos_jester
var c_pos = Globs.glob_pos_jester
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += delta * 0.1 + (pre_pos[0] - c_pos[0])/500
	position.y += (pre_pos[1] - c_pos[1])/200
	pre_pos = c_pos
	c_pos = Globs.glob_pos_jester
	if abs(position.x) > 13 or abs(position.y) > 13:
		Globs.cloud_count += -1
		queue_free()
