extends Control

onready var Options = preload("res://Prefabs/UI/Options.tscn")
onready var LevelChoice = preload("res://Prefabs/UI/LevelChoice.tscn")

func _ready() -> void:
	GlobalStats.set_current_scene_id(0)
	GlobalAudio.play_track("TitleScreenMusic")
	$Buttons/Play.grab_focus()
	$Buttons/ChooseLevel.visible = false
	if GlobalStats.tutorial_shown:
		$Buttons/ChooseLevel.visible = true
		$Buttons.rect_position.y -= 20
		

func _on_Play_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	if !GlobalStats.tutorial_shown:
		fadeOut.configure(GlobalStats.get_next_scene())
		GlobalStats.tutorial_shown = true
	else:
		fadeOut.configure(GlobalStats.get_next_scene(3))


func _on_ChooseLevel_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var levelChoice = LevelChoice.instance()
	add_child(levelChoice)
	levelChoice.connect("choice_closed", self, "choice_closed")

func choice_closed() -> void:
	$Buttons/ChooseLevel.grab_focus()

func _on_Options_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var options = Options.instance()
	add_child(options)
	options.connect("options_closed", self, "options_closed")

func options_closed() -> void:
	$Buttons/Options.grab_focus()


func _on_Quit_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	get_tree().quit()


func _on_Play_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Options_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Quit_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_ChooseLevel_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")
