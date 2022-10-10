extends Control

onready var pivot := $YellowPivot as Node2D
#Saves how much coffee should be added to the meter.
onready var target_rotation := 0.0

onready var LoseScreen = preload("res://Prefabs/UI/LoseScreen.tscn")

#Called from Game Controller in physics_process,
#decreases the coffee level with a small value.
func decrease(value: float) -> void:
	pivot.rotation_degrees += value
	pivot.rotation_degrees = clamp(pivot.rotation_degrees, 0, 90)
	if pivot.rotation_degrees == 90:
		print("coffee finished")
		GlobalAudio.play_sound("Lost")
		GlobalStats.set_level_status(GlobalStats.GAME_STOPPED)
		get_tree().paused = true
		var loseScreen = LoseScreen.instance()
		#(get_parent().clock as Control).pause_mode = PAUSE_MODE_INHERIT
		(get_parent() as CanvasLayer).add_child(loseScreen)

#Called from Game Controller in physics_process,
#increases the coffee level with a value of a coffe cup.
func increase(value: float) -> void:
	target_rotation -= value
	var new_rotation = pivot.rotation_degrees + target_rotation
	new_rotation = clamp(new_rotation, 0, 90)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(pivot, "rotation_degrees", new_rotation, 0.4)
	#prevents "coffee loss" when collecting multiple coffeees at the same time
	tween.connect("finished", self, "finished", [value])

#Subtracts the value from target_rotation when the value was filled.
func finished(value: float) -> void:
	target_rotation += value
