extends Node2D


const CrystalPath = preload("res://Scenes/crystalHeart.tscn")
const HeartPath = preload("res://Scenes/heart.tscn")
const CoinPath = preload("res://Scenes/coin.tscn")

var crystalH = CrystalPath.instantiate()
var hearth = HeartPath.instantiate()
var coin = CoinPath.instantiate()

var rng = RandomNumberGenerator.new()

var collected = false
var numOfObjects

var markers

func _ready():
	markers = [$Marker1.global_position, $Marker2.global_position, $Marker3.global_position, $Marker4.global_position, $Marker5.global_position, $Marker6.global_position, $Marker7.global_position, $Marker8.global_position]

	numOfObjects = rng.randi_range(2, 5)
	$cube.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player and collected == false:
		$AudioStreamPlayer2D.play()
		collected = true
		dropItems()
		
		$cube.hide()


func distributePositions():
	var spawns = []
	
	for i in range(numOfObjects):
		spawns.append(self.global_position)
	
	for i in range(numOfObjects):
		var idx = rng.randi_range(0, markers.size() - 1)
		spawns[i] = markers[idx]
		markers.remove_at(idx)
		#print(spawns)
	
	#print(spawns)
	return spawns


func dropItems():
	var spawns = distributePositions()
	
	for i in range(numOfObjects):
		var itemNum = rng.randi_range(0, 2)
		var new_item
			
		if itemNum == 0:
			var heartNum = rng.randf_range(0.0, 1.0)
				
			if heartNum <= 0.4:
				new_item = crystalH.duplicate()
				
			else:
				new_item = hearth.duplicate()
				
		else:
			new_item = coin.duplicate()
			
		new_item.position = spawns[i]
		get_parent().get_node("Items").add_child(new_item)


func _on_audio_stream_player_2d_finished():
	queue_free()
