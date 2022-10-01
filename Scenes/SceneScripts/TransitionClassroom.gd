extends Node2D

onready var students := $"%Students" as YSort

func _input(_event) -> void:
	#Escape game
	if Input.is_action_just_pressed("pause_screen"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func _ready() -> void:
	var children = students.get_children()
	
	#Assign student sprite frame
	for i in children.size():
		children[i].assign_frame(i)
