extends Sprite2D

var speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('ui_left') == true:
		rotation_degrees = rotation_degrees - delta * 90
	if Input.is_action_pressed('ui_right') == true:
		rotation_degrees = rotation_degrees + delta * 90
	if Input.is_action_pressed('ui_accept') == true:
		position.x += speed * sin(rotation) * delta
		position.y += speed * -cos(rotation) * delta
	Globs.plpos = [floor(global_position.x/16),floor(global_position.y/16)]
	pass
