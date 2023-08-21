extends Node2D


var rng = RandomNumberGenerator.new()
var collected = false
var coins = 1


func _ready():
	coins = rng.randi_range(1, 6)
	$Coin.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player and collected == false:
		$AudioStreamPlayer2D.play()
		body.CoinsCollected += coins
		body.Coins += coins
		collected = true
		
		self.hide()
		


func _on_audio_stream_player_2d_finished():
	queue_free()
