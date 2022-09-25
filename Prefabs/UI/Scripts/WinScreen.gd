extends Node2D

func _ready() -> void:
	var value = GlobalStats.happiness
	$StudentHappiness.text = "Student Happiness: " + str(stepify(value * 100, 0.1)) + "%"
	var left = 7 - round(7 * value)
	$StudentLeftClass.text = "Student Left Class: " + str(left)
	
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.start(5.0)

func _on_timer_timeout():
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn")
