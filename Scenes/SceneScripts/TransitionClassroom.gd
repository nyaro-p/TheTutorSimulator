extends Node2D

onready var students := $"%Students" as YSort

func _ready() -> void:
	var children = students.get_children()
	
	#Assign student sprite frame
	for i in children.size():
		children[i].assign_frame(i)
