extends Control

var pause = false
var player


func _ready():
	player = get_parent().get_node("Player")


func _process(delta):
	if player.alive:
		$NinePatchRect/Label.text = str(player.Coins)

		position = player.InterfacePosition


func _on_pause_pressed():
	get_tree().change_scene_to_file("res://Scenes/pause.tscn")
	pause = true
	
