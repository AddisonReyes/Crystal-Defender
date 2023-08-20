extends Node2D


var clockStarted = false
var firstRun = true
var pause

var timePlayed = 0


func _ready():
	$PlayTimer.start()


func _process(delta):
	if $Crystal.alive == false and clockStarted == false:
		clockStarted = true
		firstRun = false
		$Timer.start()
	
	pause = $Interface.pause


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
	if firstRun == false and pause == false:
		get_tree().reload_current_scene()


func _on_play_timer_timeout():
	timePlayed += 1
	
	if timePlayed % 60 == 0:
		$Spawner.add_difficulty()
	
	$PlayTimer.start()
