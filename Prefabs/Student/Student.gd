extends StaticBody2D

onready var person = $"%Person"

onready var TimeEffect = preload("res://Effects/TimeEffect.tscn")

var is_on_timer = false

func _ready():
	randomize()
	$Laptop.visible = bool(randi() % 2)
	
	#person.frame = randi() % 6

func start_timer(time):
	is_on_timer = true
	var timeEffect = TimeEffect.instance()
	add_child(timeEffect)
	timeEffect.animate_timer(time)
	timeEffect.connect("timer_finished", self, "timer_finished")

func is_on_timer():
	print(is_on_timer)
	return is_on_timer

func timer_finished():
	is_on_timer = false
