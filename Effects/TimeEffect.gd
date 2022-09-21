extends Node2D

onready var mesh = $MeshInstance2D2
var time = 2.0

func _ready():
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mesh, "scale", Vector2(1.0, 1.0), time)
	tween.connect("finished", self, "finished")
	
func finished():
	print("fin")

#func _physics_process(delta):
#	mesh.scale.x = lerp(mesh.scale.x, 1, 2 * delta)
#	mesh.scale.y = mesh.scale.x
#
#	if mesh.scale.y > 0.99:
#		get_parent().queue_free()
	
