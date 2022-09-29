extends Node2D

onready var player := $CoffePlayer


func _ready() -> void:
	var fadeIn = GlobalStats.FadeIn.instance()
	$UI.add_child(fadeIn)
	player.connect("lost", self, "lost_animation")
	#player.conntect("won", self, "win_animation")
	$UI/Lost.modulate = Color(1, 1, 1, 0)
	$UI/Won.modulate = Color(1, 1, 1, 0)
	$UI/Lost.visible = false
	$UI/Won.visible = false

	
func start_fight() -> void:
	$AnimationPlayer.play("Fight")

#### Lost ###

func lost_animation() -> void:
	$UI/Lost.visible = true
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UI/Lost, "modulate", Color(1, 1, 1, 1), 1.0)
	#tween.parallel().tween_property($UI/Lost/Lost, "rect_scale", Vector2(1.5, 1.5), 1.0)
	tween.connect("finished", self, "restart")


func restart() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	$UI.add_child(fadeOut)
	fadeOut.configure("res://Scenes/BossFight.tscn", Color(0, 0, 0, 1))

#### Won ###

func win_animation() -> void:
	$UI/Won.visible = true
	player.toggle_active()
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UI/Won, "modulate", Color(1, 1, 1, 1), 1.0)
	#tween.parallel().tween_property($UI/Lost/Lost, "rect_scale", Vector2(1.5, 1.5), 1.0)
	tween.connect("finished", self, "leave")


func leave() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	$UI.add_child(fadeOut)
	fadeOut.configure("res://Scenes/TitleScreen.tscn")
