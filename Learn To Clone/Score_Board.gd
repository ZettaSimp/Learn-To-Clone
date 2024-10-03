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
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	day_l.text = 'Day ' + str(day)
	if Globs.game_state == 2:
		position.y += -300 * delta
		if position.y < 400:
			position.y = 400
			Globs.game_state = 3
	if Globs.game_state == 3:
		totc.text = '100'
	pass
