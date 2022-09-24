extends Node2D

func set_monitorable(value:bool) -> void:
	$Area2D.monitorable = value
	
func spill_animation() -> void:
	$AnimationPlayer.play("spill")
