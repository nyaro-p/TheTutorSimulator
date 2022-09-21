extends StaticBody2D

onready var timer = $"%Timer"

onready var TimeEffect = preload("res://Effects/TimeEffect.tscn")

func start_timer(time):
	var timeEffect = TimeEffect.instance()
	add_child(timeEffect)
	#timer.start(time)
