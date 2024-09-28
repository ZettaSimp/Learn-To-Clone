extends Node2D

@onready var Jest = $Jester_Sprite
var accel = 1500
var speed = [0,0]
var speed_mag = 0
var speed_ang = 0
var bounce_constant = 0.6
var floor_constant = 0.9
var drag = 0.0015
var glider_constant = 2
var glide = 0
var glide_ang = 0
var bounces = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('ui_left') == true:
		Jest.rotation_degrees = Jest.rotation_degrees - delta * 90
	if Input.is_action_pressed('ui_right') == true:
		Jest.rotation_degrees = Jest.rotation_degrees + delta * 90
	if Input.is_action_pressed('ui_accept') == true:
		speed[0] += accel * sin(Jest.rotation) * delta
		speed[1] += accel * -cos(Jest.rotation) * delta
	speed_mag = sqrt(speed[0]*speed[0]+speed[1]*speed[1])
	if abs(speed[0]) > 0:
		speed_ang = sign(speed[0]) * atan(-speed[1]/speed[0])
		if speed[0] < 0:
			speed_ang = sign(-speed[1]) * 3.14159265358 - speed_ang
	else:
		speed_ang = sign(-speed[1]) * 3.14159265358 / 2
	glide_ang = -(Jest.rotation - 3.14159265358 / 2)
	glide = speed_mag*glider_constant*delta*sin(glide_ang-speed_ang)
	Globs.text = str(floor(speed_ang * 180 / 3.14159265358)) + '\n' + str(floor(glide_ang * 180 / 3.14159265358)) + '\n' + str(glide) + '\n' + str(floor(speed[0])) + '\n' + str(floor(speed[1]))
	speed[0] += glide * -cos(glide_ang)
	speed[1] += glide * -sin(glide_ang)
	if glider_constant > 0:
		glide = 0
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
