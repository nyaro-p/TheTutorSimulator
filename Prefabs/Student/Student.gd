extends StaticBody2D

onready var person := $"%Person" as Sprite

onready var TimeEffect := preload("res://Effects/TimeEffect.tscn")

var is_on_timer_bool := false

func _ready() -> void:
	randomize()
	#randomly gives student a laptop.
	$Laptop.visible = bool(randi() % 2)

#Sets a timer for a question / adds th Time Effect.
#Called from Game Controller.
func start_timer(time: float) -> void:
	is_on_timer_bool = true
	var timeEffect = TimeEffect.instance()
	add_child(timeEffect)
	timeEffect.animate_timer(time)
	timeEffect.connect("timer_finished", self, "timer_finished")

#Getter function, called from Game Controller to check
#if the student is already having a question.
func is_on_timer() -> bool:
	return is_on_timer_bool

#Setter function.
func timer_finished() -> void:
	is_on_timer_bool = false
