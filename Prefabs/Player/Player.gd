extends KinematicBody2D

export var ACCELERATION := 2000
export var MAX_SPEED := 200
export var FRICTION := 1000

var velocity := Vector2.ZERO
var input_vector := Vector2.ZERO

#Item collection area
onready var collectArea := $CollectArea as Area2D
#Interraction area
onready var interactArea := $"%InteractArea" as Area2D
#Animations
onready var animationTree := $"%AnimationTree" as AnimationTree
onready var animationState = animationTree.get("parameters/playback")

signal coffee_collected

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#get_tree().paused = false

func _input(_event) -> void:
	#Read input
	input_vector.x = round(Input.get_axis("move_left", "move_right"))
	input_vector.y = round(Input.get_axis("move_up", "move_down"))
	input_vector = input_vector.normalized()
	
	#Pause game
	if Input.is_action_just_pressed("pause_screen"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	
func _physics_process(delta) -> void:
	#Helping students.
	if Input.is_action_pressed("interact"):
		var areas = interactArea.get_overlapping_areas()
		if areas != null:
			for area in areas:
				#TimeEffect
				(area.get_parent() as Node2D).decrease()
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

#Emits a signal to the Game Controller, animates coffee towards player
func _on_CollectArea_area_entered(area) ->void:
	emit_signal("coffee_collected")
	var tween := create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(area.get_parent(), "position", position + Vector2(0, -25), 0.1)
	tween.parallel().tween_property(area.get_parent(), "modulate", Color(1, 1, 1, 0), 0.1)
	tween.connect("finished", self, "delete_coffee", [area.get_parent()])

#When coffee meets player -> delete.
func delete_coffee(coffee: Node2D) -> void:
	if coffee != null: #need it for some reason
		coffee.queue_free()
