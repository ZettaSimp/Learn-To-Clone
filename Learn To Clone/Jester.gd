extends Node2D

@onready var Jest = $Jester_Sprite
@onready var cb = $Cannon_Bar
@onready var cbb = $Cannon_Bar/Cannon_Bar_Bar
var pos_collected = false
var cbb_starting_pos = 0
var cbb_speed = 0
var bar_delay = 2
var accel = 2500
var fuel = 4
var speed = [0,0]
var speed_mag = 0
var speed_ang = 0
var bounce_constant = 0.6
var floor_constant = 0.9
var drag = 0.1
var dragV = Vector2(0,0)
var dragV2 = Vector2(0,0)
var glider_constant = 1.0
var glide = 0
var glide_ang = 0
var bounces = 0
var cannon_state = -3
var cannon_power = 1000

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pos_collected == false:
		cbb_starting_pos = cbb.position.x
		pos_collected = true
		return
	if cannon_state == -4:
		return
	if cannon_state == -3:
		cb.frame = 1
		if Input.is_action_just_pressed("ui_accept"):
			cannon_state = -2
			cbb.position.x = cbb_starting_pos
		return
	if cannon_state == -2:
		if cb.position.y < -200:
			cb.position.y += delta * 200
		else:
			cb.position.y = -200
			cannon_state = -1
		return
	if cannon_state == -1:
		cbb.position.x += cbb_speed
		cbb_speed += delta * 6
		cannon_power = Globs.cannon_level * (int(1000 * (float(cbb.position.x+100)/float(210))) % 1000)
		Globs.text = str(cannon_power) + '\n' + str(cbb.position.x+100)
		if Input.is_action_just_pressed("ui_accept") or (cbb.position.x > 10 and (cannon_power)/float(Globs.cannon_level) < 50):
			speed = [cannon_power+100,-cannon_power-100]
			Jest.rotation_degrees = 45
			cannon_state = 0
			bar_delay = 2
			cb.frame = 0
		return
	if cannon_state == 0:
		cbb_speed = 0
		if bar_delay > 0:
			bar_delay += -delta
		else:
			cannon_state = 1
	if cannon_state == 1:
		if cb.position.y > -400:
			cb.position.y += -delta * 200
	if Input.is_action_pressed('ui_left') == true:
		Jest.rotation_degrees = Jest.rotation_degrees - delta * 90
	if Input.is_action_pressed('ui_right') == true:
		Jest.rotation_degrees = Jest.rotation_degrees + delta * 90
	if Input.is_action_pressed('ui_accept') == true and fuel > 0:
		fuel += -delta
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
	dragV = Vector2(drag+10*abs(sin(glide_ang)),drag+10*abs(cos(glide_ang)))
	dragV2 = Vector2(-10*sin(glide_ang),-10*cos(glide_ang))
	if glider_constant == 0:
		dragV = Vector2(drag,drag)
		dragV2 = Vector2(0,0)
	if global_position.y + speed[1] * delta < 455:
		speed[1] += 1000 * delta
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
			if abs(speed[0]) < 5:
				cannon_state = -4
				Globs.game_state = 1
	speed = [speed[0]-speed[0]*dragV.x*delta+speed[1]*dragV2.y*delta*sign(sin(glide_ang)),speed[1]-speed[1]*dragV.y*delta+speed[0]*dragV2.x*delta]
	global_position.x += speed[0] * delta
	global_position.y += speed[1] * delta
	Globs.glob_pos_jester = [global_position.x,global_position.y]
	Globs.spd_jester = [speed[0],speed[1]]
	Globs.plpos = [floor(global_position.x/16),floor(global_position.y/16)]
	Globs.text = str(fuel)
