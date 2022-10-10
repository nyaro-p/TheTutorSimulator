extends StaticBody2D

onready var person := $"Person" as Sprite
onready var blinkPerson := $"PersonBlinking" as Sprite
onready var specialSprite := $"SpecialSprite" as Sprite
onready var blinkTimer := $BlinkTimer as Timer

onready var TimeEffect := preload("res://Effects/TimeEffect.tscn")

var is_on_timer_bool := false

var timeEffect

signal happy
signal unhappy

func _ready() -> void:
	blinkPerson.visible = false
	blinkTimer.start(3.0 + randi() % 10)
	blinkTimer.connect("timeout", self, "blink")
	
	assign_frame(1)

#Assigns a frame to all sprite sheets.
func assign_frame(i: int) -> void:
	person.frame = i
	blinkPerson.frame = i
	specialSprite.frame = i
	#Question student
	if i == 3:
		$Laptop.visible = false

func blink() -> void:
	blinkPerson.visible = !blinkPerson.visible
	person.visible = !blinkPerson.visible
	if blinkPerson.visible:
		blinkTimer.start(0.1)
	else:
		blinkTimer.start(3.0 + randi() % 4)
