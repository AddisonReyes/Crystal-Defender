extends Node2D


var clockStarted = false
var firstRun = true

var timePlayed = 0


func _ready():
	$AudioStreamPlayer2D.play()
	get_tree().paused = false
	$PlayTimer.start()


func _process(delta):
	if $Crystal.alive == false and clockStarted == false:
		clockStarted = true
		firstRun = false
		$Timer.start()
	
	if get_tree().paused:
		$Interface/Pause.show()
	else:
		$Interface/Pause.hide()


func save_data():
	var data = {
		"FairiesKilles": $Player.FaeKilled,
		"CoinsCollected": $Player.CoinsCollected,
		"TimePlayed": timePlayed
	}

	var file = FileAccess.open("res://data.dat", FileAccess.WRITE)
	file.store_var(data)


func _on_timer_timeout():
	save_data()
	
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	clockStarted = false


func _on_tree_entered():
	if firstRun == false:
		get_tree().reload_current_scene()


func _on_play_timer_timeout():
	timePlayed += 1
	
	if timePlayed % 60 == 0:
		$Spawner.add_difficulty()
		$Spawner.add_enemy()
	
	$PlayTimer.start()


func _on_background_2_finished():
	$Background2.play()
