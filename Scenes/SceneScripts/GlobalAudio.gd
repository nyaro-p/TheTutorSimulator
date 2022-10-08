extends Node

export var debug_music := true
export var debug_sound := true

var current_song := "default"

onready var audios: Dictionary = {
	"AudioAnswered" : $Sounds/AudioAnswered,
	"QuestionTimeOut" : $Sounds/QuestionTimeOut,
	"EjectCoffee" : $Sounds/EjectCoffee,
	
}

onready var music: Dictionary = {
	"TitleScreenMusic" : $Music/TitleScreenMusic,
	"ClassroomMusic" : $Music/ClassroomMusic
}

func play_sound(audio_name: String) -> void:
	if debug_sound:
		var sound = $Sounds.get_node(audio_name) as AudioStreamPlayer
		sound.play()
#	audios[audio].connect("finished", self, "stop_audio", [audios[audio]])
#
#func stop_audio(audio) -> void:
#	audio.stop()

func play_track(track_name: String) -> void:
	if debug_music:
		if track_name != current_song and current_song != "default":
			var old_track = $Music.get_node(current_song) as AudioStreamPlayer
			old_track.stop()
			old_track.disconnect("finished", self, "play_track")
			set_MusicControl_volume_db(0.0)
		
		
		var track = $Music.get_node(track_name) as AudioStreamPlayer
		if !track.playing:
			if controlTween != null:
				controlTween.pause()
			track.play()
		if !track.is_connected("finished", self, "play_track"):
			track.connect("finished", self, "play_track", [track_name])
		
		current_song = track_name

onready var controlTween
#Fades out music using MusicController
func fade_out_music(time: float):
	controlTween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	controlTween.tween_method(self, "set_MusicControl_volume_db", 0.0, -80.0, time)
	controlTween.play()

#Sets the volume of the dditional bus controlling music volume.
func set_MusicControl_volume_db(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("MusicController")
	AudioServer.set_bus_volume_db(bus_index, value)
