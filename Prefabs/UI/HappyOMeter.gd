extends Node2D

onready var button := $"Happy-o-meterButton"

#Overall student happiness.
var happiness = 0.5

func _ready() -> void:
	button.position.y = 61

func increase() -> void:
	animate(-1.0)

func decrease() -> void:
	animate(1.0)

func animate(value : float) -> void:
	var new_position = button.position + (Vector2(0.0, 5.0) * value)
	if new_position.y < 35:
		new_position.y = 35
	
	if new_position.y > 87:
		new_position.y = 87
	
	happiness = 1.0 -((new_position.y - 35) / (87- 35))
	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(button, "position", new_position, 0.6)
