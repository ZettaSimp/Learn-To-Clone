extends Sprite2D

@onready var dl = $Day_Label
@onready var des = $Description
@onready var cl1 = $Cost_Label_1
@onready var cl2 = $Cost_Label_2
@onready var cl3 = $Cost_Label_3
@onready var cl4 = $Cost_Label_4
@onready var cur = $Cursor
@onready var cp = $Cash_Profit
var day = 1
var selection = [0,0]
var items = [0,0,0,0]
var cost = [[250,500,1000,2000,4000,8000,16000,32000,64000],[50,500,2500,7500,15000,50000],[1000,4000,9000,160000,25000,36000],[1000,4000,16000,64000]]
var description = ["Increases cannon launch power, for better initial speed.","Upgrades the glider to be more aerodynamic, increasing airspeed and decreasing drag.","Improves the thrusters, allowing you to gain more speed per second of fuel. Press space during flight to use.","Increases the amount of fuel you can bring with you, providing an extra second of thrust per upgrade.","Proceed to the next day","Proceed to the next day"]
var wait = 0
var cur_pos = [Vector2(-164,-72),Vector2(80,-72),Vector2(-164,85),Vector2(80,85),Vector2(136,232),Vector2(136,232)]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Globs.item_l = items
	if Globs.game_state == 4:
		visible = true
		wait += -delta
	else:
		visible = false
		wait = 0.5
	if Input.is_action_just_pressed("ui_right") == true:
		selection[0] = selection[0] + 1
	if Input.is_action_just_pressed("ui_left") == true:
		selection[0] = selection[0] - 1
	if Input.is_action_just_pressed("ui_down") == true:
		selection[1] = selection[1] + 1
	if Input.is_action_just_pressed("ui_up") == true:
		selection[1] = selection[1] - 1
	if selection[0] < 0:
		selection[0] = 0
	if selection[0] > 1:
		selection[0] = 1
	if selection[1] < 0:
		selection[1] = 0
	if selection[1] > 2:
		selection[1] = 2
	des.text = description[selection[0]+selection[1]*2]
	cp.text = "Current Cash:\n" + str(Globs.money)
	dl.text = str(day)
	for c in range(0,4):
		if items[c] < len(cost[c]):
			if c == 0:
				cl1.text = "Cost:\n" + str(cost[c][items[c]]) + "\nLevel: " + str(items[c])
			if c == 1:
				cl2.text = "Cost:\n" + str(cost[c][items[c]]) + "\nLevel: " + str(items[c])
			if c == 2:
				cl3.text = "Cost:\n" + str(cost[c][items[c]]) + "\nLevel: " + str(items[c])
			if c == 3:
				cl4.text = "Cost:\n" + str(cost[c][items[c]]) + "\nLevel: " + str(items[c])
		else:
			if c == 0:
				cl1.text = "MAX"
			if c == 1:
				cl2.text = "MAX"
			if c == 2:
				cl3.text = "MAX"
			if c == 3:
				cl4.text = "MAX"
	cur.position = cur_pos[selection[0]+selection[1]*2]
	if selection[0]+selection[1]*2 >= 4:
		cur.rotation_degrees = 270
	else:
		cur.rotation_degrees = 0
	if Input.is_action_just_pressed("ui_accept") == true and wait < 0:
		if selection[1] < 2:
			if items[selection[0]+selection[1]*2] < len(cost[selection[0]+selection[1]*2]):
				if Globs.money > cost[selection[0]+selection[1]*2][items[selection[0]+selection[1]*2]]:
					Globs.money += -cost[selection[0]+selection[1]*2][items[selection[0]+selection[1]*2]]
					items[selection[0]+selection[1]*2] += 1
		else:
			day += 1
			Globs.days = day
			Globs.game_state = 5
	pass
