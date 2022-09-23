extends Control

onready var Coffee := preload("res://Prefabs/Menu/TitleScreenCoffee.tscn")

func _ready() -> void:
	for x in range(4):
		for y in range(4):
			var coffee = Coffee.instance()
			add_child(coffee)
			coffee.global_position = Vector2(x * 203, -115 + y * 115)
			move(coffee)

func move(obj: Sprite) -> void:
	var old_position := obj.global_position
	var new_position := Vector2(old_position.x - 203.0, old_position.y + 115.0)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(obj, "global_position", new_position, 20.0)
	tween.connect("finished", self, "restart_animation", [obj, old_position])

func restart_animation(obj: Sprite, position : Vector2) -> void:
	obj.global_position = position
	move(obj)
