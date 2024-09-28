extends Node2D

@onready var Jest = $Jester_Sprite
var accel = 1500
var speed = [0,0]
var bounce_constant = 0.6
var floor_constant = 0.9
var drag = 0.25
var glider_constant = 0.9
var glide = [0,0]
var bounces = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	glider_constant = 0.8 * delta
	if Input.is_action_pressed('ui_left') == true:
		Jest.rotation_degrees = Jest.rotation_degrees - delta * 90
	if Input.is_action_pressed('ui_right') == true:
		Jest.rotation_degrees = Jest.rotation_degrees + delta * 90
	if Input.is_action_pressed('ui_accept') == true:
		speed[0] += accel * sin(Jest.rotation) * delta
		speed[1] += accel * -cos(Jest.rotation) * delta
	if glider_constant > 0:
		glide = [sqrt(speed[0]*speed[0]+speed[1]*speed[1]),sqrt(speed[0]*speed[0]+speed[1]*speed[1])]
	speed = [speed[0]-speed[0]*drag*delta,speed[1]-speed[1]*drag*delta]
	global_position.x += speed[0] * delta
	if global_position.y + speed[1] * delta < 455:
		speed[1] += 1000 * delta
		global_position.y += speed[1] * delta
	else:
		if speed[1] > 10:
			speed[0] = speed[0] * bounce_constant
			speed[1] = -speed[1] * bounce_constant
			global_position.y += speed[1] * delta
			bounces += 1
		else:
			speed[0] = speed[0] - speed[0] * floor_constant * delta
			speed[1] = 0
			global_position.y = 455
	Globs.glob_pos_jester = [global_position.x,global_position.y]
	Globs.spd_jester = [speed[0],speed[1]]
	Globs.plpos = [floor(global_position.x/16),floor(global_position.y/16)]
