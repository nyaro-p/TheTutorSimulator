extends Node

export var debug_music := true
export var debug_sound := true

var current_song := "default"

onready var audios: Dictionary = {
	"AudioAnswered" : $Sounds/AudioAnswered,
	"QuestionTimeOut" : $Sounds/QuestionTimeOut,
	"EjectCoffee" : $Sounds/EjectCoffee
}

onready var music: Dictionary = {
	"TitleScreenMusic" : $Music/TitleScreenMusic,
	"ClassroomMusic" : $Music/ClassroomMusic
}

func play_sound(audio: String) -> void:
	if debug_sound:
		audios[audio].play()
#	audios[audio].connect("finished", self, "stop_audio", [audios[audio]])
#
#func stop_audio(audio) -> void:
#	audio.stop()

func play_track(song: String) -> void:
	if debug_music:
		if song != current_song and current_song != "default":
			music[current_song].stop()
			music[current_song].disconnect("finished", self, "play_track")
		current_song = song
		music[song].play()
		if !music[song].is_connected("finished", self, "play_track"):
			music[song].connect("finished", self, "play_track", [song])
	
