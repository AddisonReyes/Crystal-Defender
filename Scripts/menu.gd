extends Control

var fullscreen = false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_controls_pressed():
	pass # Replace with function body.


func _on_fullscreen_pressed():
	if fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
		return
	
	if fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false
		return


func _on_exit_pressed():
	get_tree().quit()
