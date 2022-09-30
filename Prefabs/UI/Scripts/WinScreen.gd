extends Control

func _ready() -> void:
	var value = GlobalStats.happiness
	$StudentHappiness.text = "Student Happiness: " + str(stepify(value * 100, 0.1)) + "%"
	var left = 7 - round(7 * value)
	$StudentLeftClass.text = "Students Left Class: " + str(left)
	$Buttons/NextButton.grab_focus()
	
#	var timer = Timer.new()
#	timer.connect("timeout",self,"_on_timer_timeout") 
#	add_child(timer)
#	timer.start(5.0)

func _on_timer_timeout():
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn")


func _on_HomeButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn")

func _on_RestartButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(get_tree().current_scene.filename)


func _on_NextButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene())


func _on_HomeButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_RestartButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_NextButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")
