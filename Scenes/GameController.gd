extends Node2D

onready var students = $"%Students"
onready var timer = $"%Timer"
onready var clock = $"%Clock"

var rate_time = 1
var active_time = 10.0

func _ready():
	randomize()
	timer.start(2.0 + float(randi() % rate_time))
	timer.connect("timeout", self, "on_timeout")
	
	var children = students.get_children()
	
	for i in children.size():
		children[i].person.frame = i


func on_timeout():
	var children = students.get_children()
	if children.size() > 0:
		while true:
			print("checking")
			var child = children[randi() % children.size()]
			if !child.is_on_timer:
				child.start_timer(active_time)
				break
			print("check failed")
