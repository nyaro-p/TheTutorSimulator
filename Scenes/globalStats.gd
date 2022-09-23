extends Node

var controller := false
	
func _input(event: InputEvent) -> void:
	controller = (event is InputEventJoypadButton) or (event is InputEventJoypadMotion)
