extends Particles2D

signal finished

func _ready() -> void:
	$Timer.start(1.5)
	$Audio.play()

func _on_Timer_timeout() -> void:
	emit_signal("finished")
	$Audio.stop()
	queue_free()
