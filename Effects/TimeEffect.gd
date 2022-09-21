extends Node2D

onready var bounds_mesh = $BoundsMesh
onready var growing_mesh = $GrowingMesh

signal timer_finished

func animate_timer(time):
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(bounds_mesh, "scale", Vector2(0.2, 0.2), 1.0)
	tween.parallel().tween_property(growing_mesh, "scale", Vector2(1.0, 1.0), time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(growing_mesh, "modulate", Color(1, 0, 0, 0.470588), time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(bounds_mesh, "modulate", Color(1, 0, 0, 0.470588), time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", self, "finished")
	
func finished():
	emit_signal("timer_finished")
	queue_free()

#func _physics_process(delta):
#	mesh.scale.x = lerp(mesh.scale.x, 1, 2 * delta)
#	mesh.scale.y = mesh.scale.x
#
#	if mesh.scale.y > 0.99:
#		get_parent().queue_free()
	
