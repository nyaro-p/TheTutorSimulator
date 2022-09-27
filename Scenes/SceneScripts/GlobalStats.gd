extends Node

#Settings
onready var fullscreen = OS.window_fullscreen

onready var FadeOut = preload("res://Effects/FadeOut.tscn") as PackedScene
onready var FadeIn = preload("res://Effects/FadeIn.tscn") as PackedScene

var controller := false
var happiness := 0.5

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
