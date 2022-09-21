extends Node2D

onready var students = $"%Students"
onready var timer = $"%Timer"

var rate_time = 5
var active_time = 6.0

func _ready():
	randomize()
	timer.start(float(randi() % rate_time))
	timer.connect("timeout", self, "on_timeout")


func on_timeout():
	var children = students.get_children()
	if children.size() > 0:
		while true:
			print("checking")
			var child = children[randi() % children.size()]
			if !child.is_on_timer:
				child.start_timer(active_time)
				break




