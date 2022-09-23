extends Control

func _ready() -> void:
	$Buttons/Play.grab_focus()

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/Classroom.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()


