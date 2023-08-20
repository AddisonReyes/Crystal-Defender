extends Node2D


var rng = RandomNumberGenerator.new()
var coins = 1


func _ready():
	coins = rng.randi_range(1, 6)
	$Coin.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		body.CoinsCollected += coins
		body.Coins += coins
		queue_free()
