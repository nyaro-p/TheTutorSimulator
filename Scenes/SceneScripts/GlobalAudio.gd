extends Node2D

onready var audios: Dictionary = {
	"AudioAnswered" : $AudioAnswered,
	"QuestionTimeOut" : $QuestionTimeOut,
	"EjectCoffee" : $EjectCoffee
}

func play(audio: String) -> void:
	audios[audio].play()
