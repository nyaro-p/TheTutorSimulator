extends Node

#Settings
onready var fullscreen = OS.window_fullscreen

onready var FadeOut = preload("res://Effects/FadeOut.tscn") as PackedScene
onready var FadeIn = preload("res://Effects/FadeIn.tscn") as PackedScene

var controller := false
var scene_reached := 0
var show_boss_tutorial := true

var current_scene := 0 #Redundant
var current_class := 0

var scenes:= [
	"res://Scenes/TitleScreen.tscn",
	"res://Scenes/TransitionScene.tscn",
	"res://Prefabs/UI/Tutorial.tscn",
	"res://Scenes/Classroom_1.tscn",
	"res://Scenes/Classroom_2.tscn",
	"res://Scenes/Classroom_3.tscn",
	"res://Scenes/BossFight.tscn"
]

var current_score := 0.0

var scores:= [
	0.0,
	0.0,
	0.0
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

func update_current_scene_id(scene) -> void:
	current_scene = scenes.find(scene.get_tree().current_scene.filename)
# warning-ignore:narrowing_conversion
	scene_reached = max(scene_reached, current_scene)

func update_on_win_screen() -> void:
# warning-ignore:narrowing_conversion
	scene_reached = max(scene_reached, current_scene + 1)

func get_next_scene(id:= -100) -> String:
	if current_scene + 1 < scenes.size():
		if id != -100:
			current_scene = id
		else:
			current_scene += 1
	else:
		current_scene = 0
	
# warning-ignore:narrowing_conversion
	scene_reached = max(scene_reached, current_scene)
	return scenes[current_scene]

func update_current_class_id(scene) -> void:
	current_class = scenes.find(scene.get_tree().current_scene.filename) - 3

func update_score(value: float) -> void:
	current_score = value

func get_current_class_score() -> float:
	return scores[current_class]
	
func save_score() -> void:
	scores[current_class] = max(scores[current_class], current_score)
