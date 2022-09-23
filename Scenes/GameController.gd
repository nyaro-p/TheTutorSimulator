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
	itemTimer.start(5.0 + float(randi() % item_rate_time))
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
	if randi() % 2 == 1:
		coffee.global_position = Vector2(210, 20)
		end_position = Vector2(210, 290)
	else:
		coffee.global_position = Vector2(300, 20)
		end_position = Vector2(300, 290)
	
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(coffee, "position", end_position, 4.0)
	
	itemTimer.start(5.0 + float(randi() % item_rate_time))

func _physics_process(delta: float) -> void:
	#constantly decreases coffee level
	manometer.decrease(4.0 * delta)
	
#Called from Player with a signal,
#adds coffee level upon collecting coffee item.
func adjust_manometer() -> void:
	manometer.increase(10.0)
