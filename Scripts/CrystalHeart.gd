extends Node2D

var crystal
var HealthPoints = 200
var collected = false


func _ready():
	crystal = get_parent().get_parent().get_node("Crystal")
	$CrystalHeart.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player and collected == false:
		if crystal.health != crystal.maxHealth:
			crystal.heals(HealthPoints)
			$AudioStreamPlayer2D.play()
			
			collected = true
			self.hide()


func _on_audio_stream_player_2d_finished():
	queue_free()
