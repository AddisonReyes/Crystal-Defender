extends Control


func _ready():
	$AudioStreamPlayer2D.play()
	$Fae2.play("default")
	$Fae3.play("default")


func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_fullscreen_pressed():
	$AudioStreamPlayer2D.play()
	if DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		return


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Scenes/controls.tscn")
