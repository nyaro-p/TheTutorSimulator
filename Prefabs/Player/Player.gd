extends KinematicBody2D

export var ACCELERATION := 2000
export var MAX_SPEED := 200
export var FRICTION := 1000

var velocity := Vector2.ZERO
var input_vector := Vector2.ZERO

#Item collection area
onready var collectArea = $CollectArea as Area2D
#Interraction area
#onready var areaPivot = $"%AreaPivot" as Node2D
#Animations
onready var animationTree = $"%AnimationTree" as AnimationTree
onready var animationState = animationTree.get("parameters/playback")

signal coffee_collected

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animationTree.active = true

func _input(_event) -> void:
	#Read input
	input_vector.x = round(Input.get_axis("move_left", "move_right"))
	input_vector.y = round(Input.get_axis("move_up", "move_down"))
	input_vector = input_vector.normalized()
	
	if Input.is_action_just_pressed("pause_screen"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	
func _physics_process(delta) -> void:
	#Movement
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
		#Set animationTree parameters
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		
		animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		animationState.travel("Idle")
		
	velocity = move_and_slide(velocity)

#Emits a signal to the Game Controller, (deletes coffee)
func _on_CollectArea_area_entered(area) ->void:
	emit_signal("coffee_collected")
	area.get_parent().queue_free()
