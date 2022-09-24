extends Node2D

func _ready() -> void:
	$Area2D.monitorable = true
	
func spill_animation() -> void:
	$AnimationPlayer.play("spill")
