extends Node2D

onready var arrow = $ArrowPivot

func _ready():
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(arrow, "rotation_degrees", 360.0, 20.0)
	tween.connect("finished", self, "time_finished")

func time_finished():
	print("global time finish")
