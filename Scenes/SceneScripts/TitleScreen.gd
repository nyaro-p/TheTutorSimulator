extends Control

onready var Options = preload("res://Prefabs/UI/Options.tscn")
onready var LevelChoice = preload("res://Prefabs/UI/LevelSelection.tscn")

func _ready() -> void:
	GlobalStats.show_boss_tutorial = true
	GlobalStats.update_current_scene_id(self)
	GlobalAudio.play_track("TitleScreenMusic")
	$Buttons/Play.grab_focus()
	$Buttons/SelectLevel.visible = false
	if GlobalStats.scene_reached > 1:
		$Buttons/SelectLevel.visible = true
		$Buttons.rect_position.y -= 20
		

func _on_Play_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	if GlobalStats.scene_reached <= 1:
		fadeOut.configure(GlobalStats.get_next_scene())
	else:
		fadeOut.configure(GlobalStats.get_next_scene(3)) #change to path?


func _on_ChooseLevel_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var levelChoice = LevelChoice.instance()
	add_child(levelChoice)
	levelChoice.connect("selection_closed", self, "selection_closed")

func selection_closed() -> void:
	$Buttons/SelectLevel.grab_focus()

func _on_Options_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var options = Options.instance()
	add_child(options)
	options.connect("options_closed", self, "options_closed")

func options_closed() -> void:
	$Buttons/SelectLevel.visible = GlobalStats.scene_reached > 1 #Unnecessary since scene_reched doesn't change,,
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
