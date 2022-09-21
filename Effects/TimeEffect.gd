extends Node2D

onready var mesh = $MeshInstance2D2
var time = 4.0

func _physics_process(delta):
	mesh.scale.x = lerp(mesh.scale.x, 1, 2 * delta)
	mesh.scale.y = mesh.scale.x
	
	if mesh.scale.y > 0.99:
		get_parent().queue_free()
	
