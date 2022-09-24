extends Node2D

onready var Coffee := preload("res://Prefabs/Items/Coffee/Coffee.tscn")
onready var CoffeeEffect := preload("res://Effects/CoffeeEffect.tscn")

onready var player := $"%Player" as KinematicBody2D
onready var students := $"%Students" as YSort
#Timers
onready var questionTimer := $"%Timer" as Timer
onready var itemTimer := $ItemTimer as Timer
#UI
onready var clock := $"%Clock" as Node2D
onready var manometer := $"%Manometer" as Node2D
onready var happyOMeter := $"%HappyOMeter" as Node2D


#time to be "survived"
var tut_time := 50.0
#rate of questions
var question_rate_time := 2
#rate of tem drops
var item_rate_time := 1

func _ready() -> void:
	randomize()
	#Student questions
	questionTimer.start(4.0 + float(randi() % question_rate_time))
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
				child.start_question()
				if !child.is_connected("happy", self, "adjust_happy"):
					child.connect("happy", self, "adjust_happy", [true])
				if !child.is_connected("unhappy", self,"adjust_happy"):
					child.connect("unhappy", self, "adjust_happy", [false])
				break
	
#Called by itemTimer when coffee should be spawned in.
func on_itemTimeout() -> void:
	#instanciates a coffee at different places in map,
	#animates it, and restarts the itemTimer.
	var coffee = Coffee.instance()
	$Items.add_child(coffee)
	coffee.visible = false
	coffee.set_monitorable(false)
	var end_position
	var direction
	
	var coffeeEffect = CoffeeEffect.instance()
	add_child(coffeeEffect)
	
	match randi() % 4:
		0:
			coffee.global_position = Vector2(210, 20)
			coffeeEffect.global_position = Vector2(210, 25)
			end_position = Vector2(210, 285)
			direction = Vector2(0, -1)
		1:
			coffee.global_position = Vector2(305, 20)
			coffeeEffect.global_position = Vector2(308, 25)
			end_position = Vector2(305, 285)
			direction = Vector2(0, -1)
		2:
			coffee.global_position = Vector2(80, 105)
			coffeeEffect.global_position = Vector2(90, 105)
			coffeeEffect.rotation_degrees = -90
			end_position = Vector2(425, 105)
			direction = Vector2(-1, 0)
		3:
			coffee.global_position = Vector2(80, 200)
			coffeeEffect.global_position = Vector2(90, 200)
			coffeeEffect.rotation_degrees = -90
			end_position = Vector2(425, 200)
			direction = Vector2(-1, 0)
	
	coffeeEffect.connect("finished", self, "start_coffee_animation", [coffee, end_position, direction])
	
	itemTimer.start(2.0 + float(randi() % item_rate_time))

#sets cofee flying
func start_coffee_animation(coffee : Node2D, end_position : Vector2, direction : Vector2) -> void:
	coffee.visible = true
	GlobalAudio.play("EjectCoffee")
	coffee.set_monitorable(true)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(coffee, "position", end_position, 1.0)
	tween.connect("finished", self, "animation_finished", [coffee, direction])

#Called after end of coffee flying animation.
func animation_finished(coffee : Node2D, direction : Vector2) -> void:
	if coffee != null:
		#Cnock back coffee.
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

#Adjust HappyOMeter according to signal from student.
func adjust_happy(happy) -> void:
	if happy:
		happyOMeter.adjust(1.0)
	else:
		happyOMeter.adjust(-1.0)
