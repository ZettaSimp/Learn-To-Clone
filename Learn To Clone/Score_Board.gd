extends Sprite2D

@onready var day = 1
@onready var dl = $Distance_Label
@onready var hl = $Height_Label
@onready var du = $Duration_Label
@onready var tot = $Total
@onready var dc = $Di_Cash
@onready var hc = $MH_Cash
@onready var duc = $Du_Cash
@onready var totc = $Total_Cash
@onready var day_l = $Day_Label
var rt = 0
var height_max = 0
var dur_ratio = 30
var multy = 0
var d_cash = 0
var h_cash = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globs.game_state == 0:
		Globs.flight_time += delta
	day_l.text = 'Day ' + str(day)
	if -Globs.glob_pos_jester[1] + 455 > height_max:
		height_max = -Globs.glob_pos_jester[1] + 455
	if Globs.game_state == 1:
		dc.text = ''
		hc.text = ''
		duc.text = ''
		totc.text = ''
		rt = 0
	if Globs.game_state == 2:
		position.y += -300 * delta
		if position.y < 0:
			position.y = 0
			Globs.game_state = 3
	if Globs.game_state == 3:
		multy = 1+float(floor((Globs.flight_time/dur_ratio)*100))/100
		h_cash = floor(height_max/100)
		d_cash = floor(Globs.glob_pos_jester[0]/100)
		rt += delta*0.25
		if rt >= 0.2 and rt < 0.4:
			dc.text = str(floor(d_cash*((rt-0.2)/0.2)))
		elif rt >= 0.4 and rt < 0.6:
			dc.text = str(d_cash)
			hc.text = str(floor(h_cash*((rt-0.4)/0.2)))
		elif rt >= 0.6 and rt < 0.8:
			hc.text = str(h_cash)
			duc.text = 'x'+str(floor((multy*((rt-0.6)/0.2))*100)/100)
		elif rt >= 0.8 and rt < 1.0:
			duc.text = 'x'+str(multy)
		elif rt >= 1.0 and rt < 1.2:
			totc.text = str(floor(((int(dc.text)+int(hc.text))*multy)))
		elif rt >= 1.2 and Input.is_action_just_pressed("ui_accept"):
			Globs.money += floor((h_cash+d_cash)*multy)
			Globs.game_state = 4
			rt = 0
	pass
