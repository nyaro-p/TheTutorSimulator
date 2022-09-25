extends Control

onready var GeneralSlider = $"%GeneralAudioSlider"
onready var MusicSlider = $"%MusicSlider"
onready var SFXSlider = $"%SFXSlider"

signal options_closed

func _ready() -> void:
	GeneralSlider.value = AudioServer.get_bus_index("Master")
	MusicSlider.value = AudioServer.get_bus_index("Music")
	SFXSlider.value = AudioServer.get_bus_index("SFX")
	GeneralSlider.grab_focus()

func _on_Button_pressed() -> void:
	emit_signal("options_closed")
	queue_free()


func _on_GeneralAudioSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_SFXSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
