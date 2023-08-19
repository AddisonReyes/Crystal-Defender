extends Node2D


var rng = RandomNumberGenerator.new()

#Preloads
const fae1 = preload("res://Scenes/fae_1.tscn")

#Instances
var normalFae = fae1.instantiate()


func _ready():
	$Timer.start()


func _process(delta):
	pass


func _get_spawn_position():
	var num = rng.randi_range(1, 8)
	
	if num == 1:
		return $"1".global_position
	
	if num == 2:
		return $"2".global_position
	
	if num == 3:
		return $"3".global_position
	
	if num == 4:
		return $"4".global_position
	
	if num == 5:
		return $"5".global_position
	
	if num == 6:
		return $"6".global_position
	
	if num == 7:
		return $"7".global_position
	
	if num == 8:
		return $"8".global_position


func _on_timer_timeout():
	var newEnemy = normalFae.duplicate()
	newEnemy.position = _get_spawn_position()
	
	get_parent().add_child(newEnemy)
	
	$Timer.start()
