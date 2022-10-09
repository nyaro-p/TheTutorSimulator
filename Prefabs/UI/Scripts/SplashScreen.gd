extends Control

func _ready() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Logo, "scale", Vector2(0.12, 0.12), 2.0)
	tween.connect("finished", self, "change_scene")

func change_scene():
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn", Color(0, 0, 0, 1))
