extends Node2D

onready var students = $"%Students"
onready var timer = $"%Timer"

func _ready():
	randomize()
	timer.start(float(randi() % 5))
	timer.connect("timeout", self, "on_timeout")


func on_timeout():
	var children = students.get_children()
	if children.size() > 0:
		var child = children[randi() % children.size()]
		child.start_timer(5)




