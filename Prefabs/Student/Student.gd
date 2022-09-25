extends StaticBody2D

onready var person := $"%Person" as Sprite
onready var blinkPerson := $"%PersonBlinking" as Sprite
onready var blinkTimer := $BlinkTimer as Timer

onready var TimeEffect := preload("res://Effects/TimeEffect.tscn")

var is_on_timer_bool := false

var timeEffect

signal happy
signal unhappy

func _ready() -> void:
	randomize()
	#randomly gives student a laptop.
	$Laptop.visible = bool(randi() % 2)
	
	blinkPerson.visible = false
	blinkTimer.start(3.0 + randi() % 10)
	blinkTimer.connect("timeout", self, "blink")

func assign_frame(i: int) -> void:
	person.frame = i
	blinkPerson.frame = i
#Adds th Time Effect.
#Called from Game Controller.
func start_question() -> void:
	is_on_timer_bool = true
	timeEffect = TimeEffect.instance()
	add_child(timeEffect)
	timeEffect.connect("timer_finished", self, "timer_finished")
	timeEffect.connect("question_answered", self, "question_answered")

#Getter function, called from Game Controller to check
#if the student is already having a question.
func is_on_timer() -> bool:
	return is_on_timer_bool

#Setter function.
#Listened by GameController
func timer_finished() -> void:
	emit_signal("unhappy")
	is_on_timer_bool = false

#Setter function.
#Listened by GameController
func question_answered() -> void:
	emit_signal("happy")
	is_on_timer_bool = false

#Restarts itself and toggles blink.
func blink() -> void:
	blinkPerson.visible = !blinkPerson.visible
	if blinkPerson.visible:
		blinkTimer.start(0.1)
	else:
		blinkTimer.start(3.0 + randi() % 4)
	
