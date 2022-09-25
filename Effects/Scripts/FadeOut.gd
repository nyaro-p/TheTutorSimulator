extends ColorRect

var next_scene := "res://Scenes/TitleScreen.tscn"

func configure(scene: String, t_color:= Color(1, 1, 1, 1)) -> void:
	next_scene = scene
	color = t_color

func change_scene():
	get_tree().change_scene(next_scene)
