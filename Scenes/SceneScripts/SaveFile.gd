extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _ready() -> void:
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data() -> void:
	var file = File.new()
	if !file.file_exists(SAVE_FILE) or OS.is_debug_build():
		game_data = {
			"fullscreen" : OS.window_fullscreen,
			"volumes" : [AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
						AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")),
						AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))],
			"scores" : [0.0, 0.0, 0.0],
			"scene_reached" : (GlobalStats.scene_reached if !OS.is_debug_build() else 0)
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
