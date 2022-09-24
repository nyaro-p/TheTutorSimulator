extends Node2D

onready var Coffee := preload("res://Prefabs/Items/Coffee/Coffee.tscn")

onready var player := $"%Player" as KinematicBody2D
onready var students := $"%Students" as YSort
#Timers
onready var questionTimer := $"%Timer" as Timer
onready var itemTimer := $ItemTimer as Timer
#UI
onready var clock := $"%Clock" as Node2D
onready var manometer := $"%Manometer" as Node2D


#time to be "survived"
var tut_time := 50.0
#rate of questions
var question_rate_time := 1
#time to answer a question
var active_time := 10.0
#rate of tem drops
var item_rate_time := 1

func _ready() -> void:
	randomize()
	#Student questions
	questionTimer.start(2.0 + float(randi() % question_rate_time))
	questionTimer.connect("timeout", self, "on_questionTimeout")
	#Coffee dropping
	itemTimer.start(2.0 + float(randi() % item_rate_time))
	itemTimer.connect("timeout", self, "on_itemTimeout")
	
	var children = students.get_children()
	
	#Assign student sprite frame
	for i in children.size():
		children[i].person.frame = i
	
	player.connect("coffee_collected", self, "adjust_manometer")
	
	clock.set_tut_time(tut_time)

#Called by questionTimer, picks a student to start a question,
#studen must not be busy with another question.
func on_questionTimeout() -> void:
	var children = students.get_children()
	if children.size() > 0:
		while true:
			var child = children[randi() % children.size()]
			if !child.is_on_timer():
				child.start_timer(active_time)
				break
	
#Called by itemTimer when coffee should be spawned in.
func on_itemTimeout() -> void:
	#instanciates a coffee at different places in map,
	#animates it, and restarts the itemTimer.
	var coffee = Coffee.instance()
	$Items.add_child(coffee)
	var end_position
	var directrion
	match randi() % 4:
		0:
			coffee.global_position = Vector2(210, 20)
			end_position = Vector2(210, 285)
			directrion = Vector2(0, -1)
		1:
			coffee.global_position = Vector2(305, 20)
			end_position = Vector2(305, 285)
			directrion = Vector2(0, -1)
		2:
			coffee.global_position = Vector2(80, 105)
			end_position = Vector2(425, 105)
			directrion = Vector2(-1, 0)
		3:
			coffee.global_position = Vector2(80, 200)
			end_position = Vector2(425, 200)
			directrion = Vector2(-1, 0)
	
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(coffee, "position", end_position, 1.0)
	tween.connect("finished", self, "animation_finished", [coffee, directrion])
	
	itemTimer.start(2.0 + float(randi() % item_rate_time))

#Called after end of coffee animation.
func animation_finished(coffee : Node2D, direction : Vector2) -> void:
	if coffee != null:
		#Throw back coffee.
		var new_position = coffee.position + direction * Vector2(10, 5)
		var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.tween_property(coffee, "position", new_position, 0.4)
		#Play spill animation.
		coffee.spill_animation()

func _physics_process(delta: float) -> void:
	#constantly decreases coffee level
	manometer.decrease(4.0 * delta)
	
#Called from Player with a signal,
#adds coffee level upon collecting coffee item.
func adjust_manometer() -> void:
	manometer.increase(10.0)
