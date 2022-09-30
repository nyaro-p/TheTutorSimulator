extends Control

func set_level(value) -> void:
	$Label.text = "Level " + str(value)

func finished() -> void:
	queue_free()
