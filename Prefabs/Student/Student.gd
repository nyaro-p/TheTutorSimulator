extends StaticBody2D

onready var timer = $"%Timer"
onready var person = $"%Person"

onready var TimeEffect = preload("res://Effects/TimeEffect.tscn")

func _ready():
	randomize()
	person.frame = randi() % 7

func start_timer(time):
	var timeEffect = TimeEffect.instance()
	add_child(timeEffect)
	#timer.start(time)
