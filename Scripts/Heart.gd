extends Node2D


var collected = false
var healthPoints
var player


func _ready():
	player = get_parent().get_parent().get_node("Player")
	$Heart.play("default")


func _process(delta):
	healthPoints = player.maxHealth/2


func _on_area_2d_body_entered(body):
	if body is Player and collected == false:
		if body.health != body.maxHealth:
			body.heals(healthPoints)
			$AudioStreamPlayer2D.play()
			
			collected = true
			self.hide()


func _on_audio_stream_player_2d_finished():
	queue_free()

