extends Sprite2D

var cloud_max = 140
# Called when the node enters the scene tree for the first time.
func _ready():
	while Globs.cloud_count < cloud_max:
		_make_cloud(randi_range(-12,12),randi_range(-12,12))
		Globs.cloud_count += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	while Globs.cloud_count < cloud_max:
		var circ = randf_range(0,2) * PI
		_make_cloud(13*cos(circ),13*sin(circ))
		Globs.cloud_count += 1
	pass

func _make_cloud(location_x,location_y):
	var cloud = preload("res://clouds.tscn")
	var clouded = cloud.instantiate()
	self.add_child(clouded)
	clouded.position.x = location_x
	clouded.position.y = location_y
	clouded.frame = randi_range(0,5)
	clouded.rotation = randf_range(0,PI*2)
