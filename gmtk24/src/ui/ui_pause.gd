extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		if visible == false:
			get_tree().paused = true
			visible = true
		else:
			get_tree().paused = false
			visible = false

func _on_cont_button_pressed() -> void:
	Click.play()
	get_tree().paused = false
	visible = false

func _on_restart_button_pressed() -> void:
	Click.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/title_screen.tscn")

func _on_sound_toggle_pressed() -> void:
	Click.play()
	if GV.sound:
		GV.sound = false
		Tetanus.volume_db = -100
		Click.volume_db = -100
	else:
		GV.sound = true
		Tetanus.volume_db = 0
		Click.volume_db = 0
