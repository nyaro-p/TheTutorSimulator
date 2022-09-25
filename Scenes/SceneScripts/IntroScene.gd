extends KinematicBody2D

func play(name) -> void:
	$AnimationPlayer.play(name)

func start_game():
	var fadeOut = GlobalStats.FadeOut.instance()
	get_parent().get_parent().add_child(fadeOut)
	fadeOut.configure("res://Scenes/Classroom.tscn")
