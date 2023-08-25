extends Control


var player


func _ready():
	player = get_parent().get_node("Player")


func _process(delta):
	if player.alive:
		$NinePatchRect/Label.text = str(player.Coins)

		position = player.InterfacePosition


func _on_pause_pressed():
	$AudioStreamPlayer2D.play()
	if get_tree().paused:
		get_tree().paused = false
	
	else:
		get_tree().paused = true
