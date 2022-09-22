extends KinematicBody2D

export var ACCELERATION = 2000
export var MAX_SPEED = 200
export var FRICTION = 1000

var velocity := Vector2.ZERO
var input_vector := Vector2.ZERO

onready var collectArea = $CollectArea
onready var areaPivot = $"%AreaPivot"
onready var animationTree = $"%AnimationTree"
onready var animationState = animationTree.get("parameters/playback")

signal coffee_collected

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animationTree.active = true

func _input(event):
	input_vector.x = round(Input.get_axis("move_left", "move_right"))
	input_vector.y = round(Input.get_axis("move_up", "move_down"))
	input_vector = input_vector.normalized()
	
func _physics_process(delta):
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		
		animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		animationState.travel("Idle")
		
	velocity = move_and_slide(velocity)


func _on_CollectArea_area_entered(area):
	emit_signal("coffee_collected")
	area.get_parent().queue_free()
