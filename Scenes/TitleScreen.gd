extends Control

func _ready() -> void:
	$Buttons/Play.grab_focus()

func _on_Play_pressed() -> void:
	var fade = GlobalStats.FadeOut.instance()
	add_child(fade)
	fade.set_next_scene("res://Scenes/TransitionScene.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()


