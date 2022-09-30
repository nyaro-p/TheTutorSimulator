extends Node2D

onready var Coffee := preload("res://Prefabs/Items/Coffee/Coffee.tscn")
onready var CoffeeEffect := preload("res://Effects/CoffeeEffect.tscn")
onready var LevelEffect := preload("res://Prefabs/UI/LevelName.tscn")

onready var player := $"%Player" as KinematicBody2D
onready var students := $"%Students" as YSort
#Timers
onready var questionTimer := $"%Timer" as Timer
onready var itemTimer := $ItemTimer as Timer
#UI
onready var UI := $"%UI" as CanvasLayer

#for Label at Beginning
export var level_id := 0
#time to be "survived"
export var tut_time := 50.0
#rate of questions
export var min_question_rate_time := 4.0
export var max_question_rate_time := 2
#rate of tem drops
export var min_item_rate_time := 2.0
export var max_item_rate_time := 1

func _ready() -> void:
	GlobalStats.set_current_scene_id(self)
	GlobalStats.set_level_status(GlobalStats.GAME_ON)
	#GlobalAudio.play_track("ClassroomMusic")
	var fadeIn = GlobalStats.FadeIn.instance()
	$UI.add_child(fadeIn)
	
	var levelEffect = LevelEffect.instance()
	levelEffect.set_level(level_id)
	$UI.add_child(levelEffect)
	
	get_tree().paused = true
	UI.connect("animation_finished", self, "start_finished")
	
	randomize()
	#Student questions
	questionTimer.start(min_question_rate_time + randi() % max_question_rate_time)
	questionTimer.connect("timeout", self, "on_questionTimeout")
	#Coffee dropping
	itemTimer.start(min_item_rate_time + float(randi() % max_item_rate_time))
	itemTimer.connect("timeout", self, "on_itemTimeout")
	
	var children = students.get_children()
	
	#Assign student sprite frame
	for i in children.size():
		children[i].assign_frame(i)
		#Special frames
		match i:
#			0:
#				if randi() % 2 == 1:
#					children[i].change_to_special_sprite()
			6:
				children[i].change_to_special_sprite()
	
	player.connect("coffee_collected", self, "adjust_manometer")
	
	UI.clock.set_clock_time(tut_time)
	
	#fixes impossible level 1
	if level_id == 1:
		UI.happyOMeter.adjust(1.0)
	

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
	
	itemTimer.start(min_item_rate_time + float(randi() % max_item_rate_time))

#sets cofee flying
func start_coffee_animation(coffee : Node2D, end_position : Vector2, direction : Vector2) -> void:
	coffee.visible = true
	GlobalAudio.play_sound("EjectCoffee")
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
	UI.manometer.decrease(4.0 * delta)
	
#Called from Player with a signal,
#adds coffee level upon collecting coffee item.
func adjust_manometer() -> void:
	UI.manometer.increase(10.0)

#Adjust HappyOMeter according to signal from student.
func adjust_happy(happy) -> void:
	if happy:
		UI.happyOMeter.adjust(1.0)
	else:
		UI.happyOMeter.adjust(-1.0)

#Called by UI at the beginning.
func start_finished():
	get_tree().paused = false
