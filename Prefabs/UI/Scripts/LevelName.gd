extends Control

func set_level(value) -> void:
	$Label.text = "Class " + str(value)

func finished() -> void:
	queue_free()
