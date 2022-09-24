extends Node2D

onready var arrow := $ArrowPivot as Node2D
onready var tut_time := 20.0

onready var WinScreen = preload("res://Prefabs/UI/WinScreen.tscn")

func _ready() -> void:
	time_finished()

#Calls itself until the arrow makes a full rotation.
func time_finished() -> void:
	var new_rotation = arrow.rotation_degrees + 6.0
	
	if new_rotation > 360.0:
		print("global time finished")
		get_tree().paused = true
		var winScreen = WinScreen.instance()
		(get_parent() as CanvasLayer).add_child(winScreen)
	else:
		var time = tut_time / 60
		var tween := create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(arrow, "rotation_degrees", new_rotation, time)
		tween.connect("finished", self, "time_finished")

#Setter function called from Game Controller.
func set_tut_time(value: float) -> void:
	tut_time = value
