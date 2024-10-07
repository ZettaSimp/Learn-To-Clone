extends Node2D

var cloud_count = 0
var plpos = [0,0]
var glob_pos_jester = [0,0]
var spd_jester = [0,0]
var text = ''
var cannon_level = 1
var game_state = 0
var flight_time = 0
var money = 0
var fuel_max = 0
var cloud_reset = false
var item_l = [0,0,0,0]
var item_do = [[1,2,3,4,5,6,7,8,9,10],[0.3,0.3,0.25,0.2,0.15,0.1,0.05],[0,1500,2000,2500,3000,3500,4000],[1,2,3,4,5]]
var drag_correction = 0.3
var accel_correction = 0
var days = 0
var time_played = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_state != 6:
		time_played += delta
	cannon_level = item_do[0][item_l[0]]
	drag_correction = item_do[1][item_l[1]]
	accel_correction = item_do[2][item_l[2]]
	fuel_max = item_do[3][item_l[3]]
	if glob_pos_jester[0] >= 2000000:
		game_state = 6
	pass
