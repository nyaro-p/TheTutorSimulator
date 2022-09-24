extends Node2D

func play_audio() -> void:
	$Audio.play()

func set_monitorable(value:bool) -> void:
	$Area2D.monitorable = value
	
func spill_animation() -> void:
	$AnimationPlayer.play("spill")
