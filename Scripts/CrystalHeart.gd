extends Node2D

var crystal
var HealthPoints = 50


func _ready():
	crystal = get_parent().get_parent().get_node("Crystal")
	$CrystalHeart.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		if crystal.health != crystal.maxHealth:
			crystal.heals(HealthPoints)
			queue_free()
