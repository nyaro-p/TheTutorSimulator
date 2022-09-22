extends Node2D

onready var arrow = $ArrowPivot
onready var tut_time = 20.0

func _ready():
	time_finished()

func time_finished():
	var new_rotation = arrow.rotation_degrees + 6.0
	if new_rotation > 360.0:
		print("global time finished")
	else:
		var time = tut_time / 60
		var tween := create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(arrow, "rotation_degrees", new_rotation, time)
		tween.connect("finished", self, "time_finished")
