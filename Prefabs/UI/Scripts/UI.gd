extends CanvasLayer

onready var clock := $"%Clock" as Control
onready var manometer := $"%Manometer" as Control
onready var happyOMeter := $"%HappyOMeter" as Control

signal animation_finished

#Listened by GameController
func animation_finished() -> void:
	emit_signal("animation_finished")
