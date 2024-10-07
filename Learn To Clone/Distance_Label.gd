extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(floor(Globs.glob_pos_jester[0])) + ' Distance\n' + str(floor(Globs.glob_pos_jester[1])-455) + ' Height\n' + str(floor(Globs.spd_jester[0])) + ' Speed (X)\n' + str(floor(Globs.spd_jester[1])) + ' Speed (Y)\n' + str(Globs.flight_time)
	text = ''
