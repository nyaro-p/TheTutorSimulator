extends Control

onready var GeneralSlider = $"%GeneralAudioSlider" as HSlider
onready var MusicSlider = $"%MusicSlider" as HSlider
onready var SFXSlider = $"%SFXSlider" as HSlider
onready var Fullscreen = $"%FullscreenCheckBox" as CheckBox

onready var game_data = SaveFile.game_data

signal options_closed

func _ready() -> void:
	GeneralSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	MusicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	SFXSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	Fullscreen.pressed = OS.window_fullscreen
	GeneralSlider.grab_focus()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_screen"):
		close_and_save()
		

func close_and_save() -> void:
	game_data.fullscreen = OS.window_fullscreen
	SaveFile.save_data()
	emit_signal("options_closed")
	queue_free()
	
########## Button Pressed / Value Changed ##########

func _on_GeneralAudioSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, value)
	game_data.volumes[0] = value
	GlobalAudio.play_sound("ButtonSelected")


func _on_MusicSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("Music")
	game_data.volumes[1] = value
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_SFXSlider_value_changed(value: float) -> void:
	if value <= -40:
		value = -80
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, value)
	game_data.volumes[2] = value
	GlobalAudio.play_sound("ButtonSelected")


func _on_FullscreenCheckBox_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	GlobalStats.toggle_fullscreen()


func _on_ResetCheckBox_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	
	GlobalStats.game_data = {
			"fullscreen" : OS.window_fullscreen,
			"volumes" : [AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
						AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")),
						AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))],
			"scores" : [0.0, 0.0, 0.0],
			"scene_reached" : GlobalStats.scene_reached
		}
	SaveFile.save_data()
	GlobalStats.update_data()


func _on_Button_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	close_and_save()

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


func _on_ResetCheckBox_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")

