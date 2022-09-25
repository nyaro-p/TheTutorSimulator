extends Node2D

onready var bounds_mesh := $BoundsMesh as Sprite
onready var growing_mesh := $GrowingMesh as MeshInstance2D
onready var timer := $Timer as Timer

var my_delta := 1.0
var emit = false

signal timer_finished
signal question_answered

func _ready() -> void:
	animate_timer()


func _physics_process(delta: float) -> void:
	my_delta = delta
	increase()


func increase() -> void:
	if emit == false:
		growing_mesh.scale += Vector2(0.3, 0.3) * my_delta
	if growing_mesh.scale >= Vector2(1.0, 1.0) and emit == false:
		finished()

func decrease() -> void:
	if emit == false:
		growing_mesh.scale -= Vector2(1.0, 1.0) * my_delta
	if growing_mesh.scale <= Vector2(0.0, 0.0) and emit == false:
		answered()
	
##Animate Question Effect circles, scale and color, first the outline elasticly,
##then inner circle linearly, both get more red with time.
func animate_timer() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(bounds_mesh, "scale", Vector2(0.2, 0.2), 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
#	tween.parallel().tween_property(growing_mesh, "scale", Vector2(1.0, 1.0), time)
#	tween.parallel().tween_property(growing_mesh, "modulate", Color(1, 0, 0, 0.470588), time)
#	tween.parallel().tween_property(bounds_mesh, "modulate", Color(1, 0, 0, 0.470588), time)
#	tween.connect("finished", self, "finished")

#Emits signal to the Student node
func finished() -> void:
	emit = true
	$Animation.play("fail")
	emit_signal("timer_finished")
	GlobalAudio.play_sound("QuestionTimeOut")

func answered() -> void:
	emit = true
	emit_signal("question_answered")
	GlobalAudio.play_sound("AudioAnswered")
	queue_free()
