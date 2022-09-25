extends KinematicBody2D

func play(name) -> void:
	$AnimationPlayer.play(name)

func start_game():
	var fade = GlobalStats.FadeOut.instance()
	get_parent().get_parent().add_child(fade)
	fade.set_next_scene("res://Scenes/Classroom.tscn")
