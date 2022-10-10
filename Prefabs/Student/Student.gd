extends StaticBody2D

onready var person := $"%Person" as Sprite
onready var blinkPerson := $"%PersonBlinking" as Sprite
onready var specialSprite := $"%SpecialSprite" as Sprite
onready var blinkTimer := $BlinkTimer as Timer

onready var TimeEffect := preload("res://Effects/TimeEffect.tscn")

var is_on_timer_bool := false

var timeEffect

signal happy
signal unhappy

func _ready() -> void:
	#randomly gives student a laptop.
	$Laptop.visible = bool(randi() % 2)
	
	blinkPerson.visible = false
	blinkTimer.start(3.0 + randi() % 10)
	blinkTimer.connect("timeout", self, "blink")

#Assigns a frame to all sprite sheets.
func assign_frame(i: int) -> void:
	person.frame = i
	blinkPerson.frame = i
	specialSprite.frame = i
	#Question student
	if i == 3:
		$Laptop.visible = false

#Adds th Time Effect.
#Called from Game Controller.
func start_question() -> void:
	change_to_special_sprite()
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
	if person.frame == 3:
		change_to_special_sprite()
	emit_signal("unhappy")
	is_on_timer_bool = false

#Setter function.
#Listened by GameController
func question_answered() -> void:
	if person.frame == 3:
		change_to_special_sprite()
	emit_signal("happy")
	is_on_timer_bool = false

#Restarts itself and toggles blink.
func blink() -> void:
	blinkPerson.visible = !blinkPerson.visible
	person.visible = !blinkPerson.visible
	if blinkPerson.visible:
		blinkTimer.start(0.1)
	else:
		blinkTimer.start(3.0 + randi() % 4)

#Switches to a special sprite for the student if one is available.
func change_to_special_sprite() -> void:
	match person.frame:
#		0:
#			specialSprite.visible = !specialSprite.visible
#			person.visible = !person.visible
#			blinkPerson.visible = (!specialSprite.visible and !person.visible)
		3:
			specialSprite.visible = !specialSprite.visible
			person.visible = !specialSprite.visible
			blinkPerson.visible = (!specialSprite.visible and !person.visible)
		6:
			if !blinkPerson.visible:
				specialSprite.visible = !specialSprite.visible
				person.visible = (!specialSprite.visible and !blinkPerson.visible)
				blinkPerson.visible = (!specialSprite.visible and !person.visible)
				blinkTimer.paused = !blinkTimer.paused
				
				var timer = get_node_or_null("Timer")
				if timer == null:
					timer = Timer.new()
					add_child(timer)
				timer.start(6 + randi() % 3)
				if !timer.is_connected("timeout", self,"change_to_special_sprite"):
					timer.connect("timeout",self,"change_to_special_sprite")
			else:
				yield(get_tree().create_timer(0.1), "timeout")
