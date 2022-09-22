extends Node2D

onready var Coffee = preload("res://Prefabs/Items/Coffee/Coffee.tscn")

onready var students = $"%Students"
onready var timer = $"%Timer"
onready var itemTimer = $ItemTimer
onready var clock = $"%Clock"
onready var manometer = $"%Manometer"
onready var player = $"%Player"

var tut_time = 50.0

var rate_time = 1
var item_rate_time = 1
var active_time = 10.0

func _ready():
	randomize()
	#Student questions
	timer.start(2.0 + float(randi() % rate_time))
	timer.connect("timeout", self, "on_timeout")
	#Coffee dropping
	itemTimer.start(5.0 + float(randi() % item_rate_time))
	itemTimer.connect("timeout", self, "on_itemTimeout")
	
	var children = students.get_children()
	
	for i in children.size():
		children[i].person.frame = i
	
	player.connect("coffee_collected", self, "adjust_manometer")
	
	clock.set_tut_time(tut_time)


func on_timeout():
	var children = students.get_children()
	if children.size() > 0:
		while true:
			var child = children[randi() % children.size()]
			if !child.is_on_timer:
				child.start_timer(active_time)
				break
	

func on_itemTimeout():
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

func _physics_process(delta):
	manometer.decrease(4.0 * delta)
	

func adjust_manometer():
	manometer.increase(10.0)
