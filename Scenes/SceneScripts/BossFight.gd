extends Node2D

onready var player := $CoffePlayer
onready var attack := $"%Attack"

func _ready() -> void:
	if GlobalStats.show_boss_tutorial:
		$AnimationPlayer.play("PreFight")
		GlobalAudio.play_track("TitleScreenMusic")
		GlobalAudio.fade_out_music(8.0)
	else:
		$AnimationPlayer.play("RestartedPreFight")
	
	$"%BossTutorial".visible = GlobalStats.show_boss_tutorial
	GlobalStats.update_current_scene_id(self)
	var fadeIn = GlobalStats.FadeIn.instance()
	$UI.add_child(fadeIn)
	player.connect("lost", self, "restart")#"lost_animation")
	$UI/Lost.modulate = Color(1, 1, 1, 0)
	$UI/Won.modulate = Color(1, 1, 1, 0)
	$UI/Lost.visible = false
	$UI/Won.visible = false


func start_fight() -> void:
	GlobalAudio.play_track("BossFight")
	$AnimationPlayer.play("Fight")

func disable_tutorial() -> void:
	GlobalStats.show_boss_tutorial = false

func end_fight() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(player, "position", Vector2(255, 178), 1.0)
	$AnimationPlayer.play("AfterFight")

#### Attacks ####

func upper_attack():
	attack.play("upper_attack")

func bottom_attack() -> void:
	attack.play("bottom_attack")

func rotating_attack() -> void:
	attack.play("rotating_attack")

func four_questions() -> void:
	attack.play("four_questions")

func scisors() -> void:
	attack.play("scisors")

func cascade() -> void:
	attack.play("cascade")

#### Student ####

func raise_hand() -> void:
	$"%Person".visible = false
	$"%RaisingHand".visible = true

func lower_hand() -> void:
	$"%Person".visible = true
	$"%RaisingHand".visible = false
	
func blink() -> void:
	$"%Person".visible = !$"%Person".visible
	$"%PersonBlinking".visible = !$"%PersonBlinking".visible

#### Lost ###

func lost_animation() -> void:
	pass
	#$UI/Lost.visible = true
	#var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property($UI/Lost, "modulate", Color(1, 1, 1, 1), 1.0)
	#tween.parallel().tween_property($UI/Lost/Lost, "rect_scale", Vector2(1.5, 1.5), 1.0)
	#tween.connect("finished", self, "restart")


func restart() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	$UI.add_child(fadeOut)
	fadeOut.configure(get_tree().current_scene.filename, Color(0, 0, 0, 1))

#### Won ###

func win_animation() -> void:
	GlobalAudio.fade_out_music(3.0)
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
