extends Node2D

onready var pivot = $YellowPivot

func decrease(value):
	pivot.rotation_degrees += value
	pivot.rotation_degrees = clamp(pivot.rotation_degrees, 0, 90)

func increase(value):
	var new_rotation = pivot.rotation_degrees - value
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(pivot, "rotation_degrees", new_rotation, 0.4)
