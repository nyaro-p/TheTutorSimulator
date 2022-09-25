extends ColorRect

var next_scene := "res://Scenes/TitleScreen.tscn"

func set_next_scene(scene: String) -> void:
	next_scene = scene

func change_scene():
	get_tree().change_scene(next_scene)
