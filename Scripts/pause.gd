extends Control


func _process(delta):
	pass


func _on_play_pressed():
	$AudioStreamPlayer2D.play()
	get_tree().paused = false


func _on_fullscreen_pressed():
	$AudioStreamPlayer2D.play()
	if DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		return


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
