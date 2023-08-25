extends Node2D


var collected = false


func _ready():
	$Heart.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player and collected == false:
		if body.health != body.maxHealth:
			body.heals(body.health/3)
			$AudioStreamPlayer2D.play()
			
			collected = true
			self.hide()


func _on_audio_stream_player_2d_finished():
	queue_free()

