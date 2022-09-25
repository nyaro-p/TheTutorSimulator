extends Control

onready var arrow := $ArrowPivot as Node2D
onready var tut_time := 20.0

onready var WinScreen = preload("res://Prefabs/UI/WinScreen.tscn")

func _ready() -> void:
	do_one_tick()

#Calls itself until the arrow makes a full rotation.
func do_one_tick() -> void:
	var new_rotation = arrow.rotation_degrees + 6.0
	
	if new_rotation > 360.0:
		if GlobalStats.get_level_status() == GlobalStats.GAME_ON:
			print("global time finished")
			get_tree().paused = true
			var winScreen = WinScreen.instance()
			(get_parent() as CanvasLayer).add_child(winScreen)
			GlobalStats.set_level_status(GlobalStats.GAME_STOPPED)
	else:
		var time = tut_time / 60.0
		var tween := create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(arrow, "rotation_degrees", new_rotation, time)
		if GlobalStats.get_level_status() == GlobalStats.GAME_ON:
			tween.connect("finished", self, "do_one_tick")

#Setter function called from Game Controller.
func set_tut_time(value: float) -> void:
	tut_time = value
