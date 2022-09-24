extends Node2D

onready var button := $"Happy-o-meterButton"

var happiness = 0.5

func _ready() -> void:
	button.position.y = 61

func increase() -> void:
	button.position.y -= 6
	button.position.y = clamp(button.position.y, 35, 83)
	happiness = 1.0 -((button.position.y - 35) / (83- 35))
	print(happiness)

func decrease() -> void:
	button.position.y += 6
	button.position.y = clamp(button.position.y, 35, 83)
	happiness = 1.0 -((button.position.y - 35) / (83- 35))
	print(happiness)
