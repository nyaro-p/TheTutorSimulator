extends KinematicBody2D

export var ACCELERATION := 2000
export var MAX_SPEED := 200
export var FRICTION := 1000

var velocity := Vector2.ZERO
var input_vector := Vector2.ZERO

onready var lifes := $"%Lifes"

var active := true
var life_count := 3

#signal won
signal lost

func _input(_event) -> void:
	#Read input
	input_vector.x = round(Input.get_axis("move_left", "move_right"))
	input_vector.y = round(Input.get_axis("move_up", "move_down"))
	input_vector = input_vector.normalized()
	
	if Input.is_action_just_pressed("pause_screen"):
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func _physics_process(delta) -> void:
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if active:
		velocity = move_and_slide(velocity)

func subtract_life() -> void:
	if life_count > 0:
		GlobalAudio.play_sound("QuestionTimeOut")
		life_count -= 1
		var children = lifes.get_children()
		children[life_count].visible = false
	if life_count <= 0:
		emit_signal("lost")
		active = false

func toggle_active() -> void:
	active = !active


func _on_HurtArea_area_entered(area: Area2D) -> void:
	subtract_life()
