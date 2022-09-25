extends Node2D

onready var audios: Dictionary = {
	"AudioAnswered" : $AudioAnswered,
	"QuestionTimeOut" : $QuestionTimeOut,
	"EjectCoffee" : $EjectCoffee
}

func play(audio: String) -> void:
	audios[audio].play()
#	audios[audio].connect("finished", self, "stop_audio", [audios[audio]])
#
#func stop_audio(audio) -> void:
#	audio.stop()
