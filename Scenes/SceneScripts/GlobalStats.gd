extends Node

#Settings
onready var fullscreen = OS.window_fullscreen

onready var FadeOut = preload("res://Effects/FadeOut.tscn") as PackedScene
onready var FadeIn = preload("res://Effects/FadeIn.tscn") as PackedScene

var controller := false
var happiness := 0.5
var tutorial_shown := true
var level_reached := 6

var current_scene := 0

var scenes:= [
	"res://Scenes/TitleScreen.tscn",
	"res://Scenes/TransitionScene.tscn",
	"res://Prefabs/UI/Tutorial.tscn",
	"res://Scenes/Classroom_1.tscn",
	"res://Scenes/Classroom_2.tscn",
	"res://Scenes/Classroom_3.tscn",
	"res://Scenes/BossFight.tscn"
]

enum {
	GAME_ON,
	GAME_STOPPED,
	DEFAULT
}

#Stops clock after GameLost
var level_status = GAME_ON

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#Checks for controller.
func _input(event: InputEvent) -> void:
	controller = (event is InputEventJoypadButton) or (event is InputEventJoypadMotion)

#Getter
func get_level_status()-> int:
	return level_status

#Setter
func set_level_status(value: int):
	level_status = value

func toggle_fullscreen() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
	fullscreen = OS.window_fullscreen

func set_current_scene_id(id) -> void:
	current_scene = id
	level_reached = max(level_reached, current_scene)

func get_next_scene(id:= -100) -> String:
	if current_scene + 1 < scenes.size():
		if id != -100:
			current_scene = id
		else:
			current_scene += 1
	else:
		current_scene = 0
	
# warning-ignore:narrowing_conversion
	level_reached = max(level_reached, current_scene)
	return scenes[current_scene]
