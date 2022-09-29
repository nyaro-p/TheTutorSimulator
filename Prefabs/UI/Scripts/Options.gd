extends Control

onready var GeneralSlider = $"%GeneralAudioSlider" as HSlider
onready var MusicSlider = $"%MusicSlider" as HSlider
onready var SFXSlider = $"%SFXSlider" as HSlider
onready var Fullscreen = $"%FullscreenCheckBox" as CheckBox

signal options_closed

func _ready() -> void:
	GeneralSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	MusicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	SFXSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	Fullscreen.pressed = GlobalStats.fullscreen
	GeneralSlider.grab_focus()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_screen"):
		GlobalAudio.play_sound("ButtonPressed")
		emit_signal("options_closed")
		queue_free()

########## Button Pressed / Value Changed ##########

func _on_GeneralAudioSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, value)
	GlobalAudio.play_sound("ButtonSelected")


func _on_MusicSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_SFXSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, value)
	GlobalAudio.play_sound("ButtonSelected")


func _on_FullscreenCheckBox_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	GlobalStats.toggle_fullscreen()


func _on_Button_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	emit_signal("options_closed")
	queue_free()

########## Button Selected ##########

func _on_GeneralAudioSlider_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_MusicSlider_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_SFXSlider_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_FullscreenCheckBox_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Button_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")
