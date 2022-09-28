extends Control

func _ready() -> void:
	var value = GlobalStats.happiness
	$StudentHappiness.text = "Student Happiness: " + str(stepify(value * 100, 0.1)) + "%"
	var left = 7 - round(7 * value)
	$StudentLeftClass.text = "Students Left Class: " + str(left)
	$Buttons/RestartButton.grab_focus()


func _on_HomeButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn")


func _on_RestartButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/Classroom.tscn")


func _on_NextButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	pass # Replace with function body.


func _on_HomeButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_RestartButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_NextButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")
