extends Control

signal selection_closed

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_screen"):
		emit_signal("selection_closed")
		queue_free()


func _ready() -> void:
	var previous_button
	
	$"%Intro".visible = false
	$"%Level1".visible = false
	$"%Level2".visible = false
	$"%Level3".visible = false
	$"%Boss".visible = false
	
	if GlobalStats.scene_reached < 3:
		$"%BackButton".grab_focus()
	previous_button = $"%BackButton"
	
	if GlobalStats.scene_reached >= 6:
		$"%Boss".visible = true
		$"%Boss".grab_focus()
		
		set_top_and_bottom($"%Boss", previous_button)
		previous_button = $"%Boss"
	
	if GlobalStats.scene_reached >= 5:
		$"%Level3".visible = true
		$"%Level3".grab_focus()
		
		#Score
		var value = GlobalStats.scores[2]
		$"%Score3".text = str(stepify(value * 100, 0.1)) + "%"
		if value >= 0.9:
			$"%Score3".modulate = Color(0.964706, 1, 0.360784)
		else:
			$"%Score3".modulate = Color(0.54902, 0.32549, 0.058824)
		
		#For focus perpouses.
		set_top_and_bottom($"%Level3", previous_button)
		previous_button = $"%Level3"
	
	if GlobalStats.scene_reached >= 4:
		$"%Level2".visible = true
		$"%Level2".grab_focus()
		
		#Score
		var value = GlobalStats.scores[1]
		$"%Score2".text = str(stepify(value * 100, 0.1)) + "%"
		if value >= 0.9:
			$"%Score2".modulate = Color(0.964706, 1, 0.360784)
		else:
			$"%Score2".modulate = Color(0.54902, 0.32549, 0.058824)
		
		set_top_and_bottom($"%Level2", previous_button)
		previous_button = $"%Level2"
	
	if GlobalStats.scene_reached >= 3:
		$"%Level1".visible = true
		$"%Level1".grab_focus()
		
		#Score
		var value = GlobalStats.scores[0]
		$"%Score1".text = str(stepify(value * 100, 0.1)) + "%"
		if value >= 0.9:
			$"%Score1".modulate = Color(0.964706, 1, 0.360784)
		else:
			$"%Score1".modulate = Color(0.54902, 0.32549, 0.058824)
		
		set_top_and_bottom($"%Level1", previous_button)
		previous_button = $"%Level1"
	
	if GlobalStats.scene_reached > 0:
		$"%Intro".visible = true
		$"%Intro".grab_focus()
		
		set_top_and_bottom($"%Intro", previous_button)

func set_top_and_bottom(current_node, bottom_node) -> void:
	current_node.focus_neighbour_bottom = bottom_node.get_path()
	current_node.focus_next = bottom_node.get_path()
	bottom_node.focus_neighbour_top = current_node.get_path()
	bottom_node.focus_previous = current_node.get_path()

########## Button Pressed ##########

func _on_Intro_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene(1))


func _on_Level1_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene(3))


func _on_Level2_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene(4))


func _on_Level3_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene(5))


func _on_Boss_pressed() -> void:
	var fadeOut = GlobalStats.FadeOut.instance()
	add_child(fadeOut)
	fadeOut.configure(GlobalStats.get_next_scene(6))

func _on_BackButton_pressed() -> void:
	GlobalAudio.play_sound("ButtonPressed")
	emit_signal("selection_closed")
	queue_free()

########## Button Selected ##########

func _on_Intro_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Level1_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Level2_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Level3_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")


func _on_Boss_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")

func _on_BackButton_focus_entered() -> void:
	GlobalAudio.play_sound("ButtonSelected")

