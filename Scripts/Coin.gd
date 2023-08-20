extends Node2D


var coins = 5


func _ready():
	$Coin.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		body.Coins += coins
		queue_free()
