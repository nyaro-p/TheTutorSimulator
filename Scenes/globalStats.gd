extends Node

var controller := false

enum {
	GAME_ON,
	GAME_STOPPED,
	DEFAULT
}

#Stops clock after GameLost
var level_status = GAME_ON

#Checks for controller.
func _input(event: InputEvent) -> void:
	controller = (event is InputEventJoypadButton) or (event is InputEventJoypadMotion)

#Getter
func get_level_status()-> int:
	return level_status

#Setter
func set_level_status(value: int):
	level_status = value
