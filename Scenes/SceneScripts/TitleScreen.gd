extends Control

func _ready() -> void:
	GlobalAudio.play_track("TitleScreenMusic")
	$Buttons/Play.grab_focus()

func _on_Play_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TransitionScene.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()


