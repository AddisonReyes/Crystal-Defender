extends Control


var rng = RandomNumberGenerator.new()


func _ready():
	var state = rng.randi_range(0, 1)
	
	if state == 0:
		$Player.play("Dance")
	else:
		$Player.play("Idle")
	
	state = rng.randi_range(0, 1)
	
	if state == 0:
		$Player2.play("Dance")
	else:
		$Player2.play("Idle")


func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_fullscreen_pressed():
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
