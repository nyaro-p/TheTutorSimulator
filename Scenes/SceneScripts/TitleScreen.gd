extends Control

onready var Options = preload("res://Prefabs/UI/Options.tscn")

func _ready() -> void:
	GlobalAudio.play_track("TitleScreenMusic")
	$Buttons/Play.grab_focus()

func _on_Play_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure("res://Scenes/TransitionScene.tscn")

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
