extends Control

var step := 0

func _ready() -> void:
	$First.modulate = Color(1, 1, 1, 0)
	$Second.modulate = Color(1, 1, 1, 0)

	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($First, "modulate", Color(1, 1, 1, 1), 1.0)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact"):
		match step:
			0:
				var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property($Second, "modulate", Color(1, 1, 1, 1), 1.0)
				step += 1
			1:
				var fadeOut = GlobalStats.FadeOut.instance()
				add_child(fadeOut)
				fadeOut.configure("res://Scenes/Classroom.tscn")
