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
			music[current_song].stop()
			music[current_song].disconnect("finished", self, "play_track")
		current_song = track_name
		
		var track = $Music.get_node(track_name) as AudioStreamPlayer
		
		track.play()
		if !track.is_connected("finished", self, "play_track"):
			track.connect("finished", self, "play_track", [track_name])
	
