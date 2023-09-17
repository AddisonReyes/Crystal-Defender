extends Node2D


var rng = RandomNumberGenerator.new()

const cubePath = preload("res://Scenes/Cube.tscn")
var cube = cubePath.instantiate()

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
	
	if timePlayed == 160:
		$Spawner.twoSpawners = true
	
	if timePlayed % 66 == 0:
		$Spawner.add_difficulty()
		$Spawner.add_enemy()
	
	if timePlayed % 320 == 0:
		var spawnNum = rng.randi_range(0, 1)
		var item
		
		if spawnNum == 0:
			item = cube.duplicate()
			item.position = $CubePositions/Marker1.global_position
			add_child(item)
		
		if spawnNum == 1:
			item = cube.duplicate()
			item.position = $CubePositions/Marker2.global_position
			add_child(item)
	
	$PlayTimer.start()


func _on_background_2_finished():
	$Background2.play()
