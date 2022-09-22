extends Node2D

onready var pivot = $YellowPivot
onready var target_rotation = 0.0

func decrease(value):
	pivot.rotation_degrees += value
	pivot.rotation_degrees = clamp(pivot.rotation_degrees, 0, 90)

func increase(value):
	target_rotation -= value
	var new_rotation = pivot.rotation_degrees + target_rotation
	new_rotation = clamp(new_rotation, 0, 90)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(pivot, "rotation_degrees", new_rotation, 0.4)
	#prevents "coffee loss" when collecting multiple coffeees at the same time
	tween.connect("finished", self, "finished", [value])

func finished(value):
	target_rotation += value
