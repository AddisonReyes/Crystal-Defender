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
	get_tree().paused = true
