extends Node2D


#Objects
var rng = RandomNumberGenerator.new()
var player

#Preloads
const fae0 = preload("res://Scenes/fae_0.tscn")
const fae1 = preload("res://Scenes/fae_1.tscn")
const fae2 = preload("res://Scenes/fae_2.tscn")
const fae3 = preload("res://Scenes/fae_3.tscn")
const fortuneFae = preload("res://Scenes/fortuneFae.tscn")

#Instances
var fae0_instance = fae0.instantiate()
var fae1_instance = fae1.instantiate()
var fae2_instance = fae2.instantiate()
var fae3_instance = fae3.instantiate()
var fortuneFae_inst = fortuneFae.instantiate()

var dificultyAdded = 1
var spawnRate = 4

func _ready():
	player = get_parent().get_node("Player")
	$Timer.wait_time = spawnRate
	$Timer.start()


func update_spawn_rate():
	$Timer.wait_time = spawnRate


func add_difficulty():
	dificultyAdded += 5
	spawnRate -= 0.023


func _get_rspawn_position():
	var num = rng.randi_range(1, 4)
	
	if num == 1:
		return $"1".global_position
	
	if num == 2:
		return $"2".global_position
	
	if num == 3:
		return $"3".global_position
	
	if num == 4:
		return $"4".global_position


func _get_lspawn_position():
	var num = rng.randi_range(1, 4)
	
	if num == 1:
		return $"5".global_position
	
	if num == 2:
		return $"6".global_position
	
	if num == 3:
		return $"7".global_position
	
	if num == 4:
		return $"8".global_position


func spawn_left_enemy():
	var Num = rng.randi_range(0, 4)
	var newEnemy
			
	if Num == 0:
		newEnemy = fae1_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 1:
		newEnemy = fae2_instance.duplicate()
		newEnemy.maxHealth = dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 2:
		newEnemy = fae3_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 3:
		newEnemy = fae0_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	else:
		newEnemy = fortuneFae_inst.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		newEnemy.item_drop = 0.5

	newEnemy.position = _get_lspawn_position()
	get_parent().add_child(newEnemy)


func spawn_right_enemy():
	var Num = rng.randi_range(0, 4)
	var newEnemy
			
	if Num == 0:
		newEnemy = fae1_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 1:
		newEnemy = fae2_instance.duplicate()
		newEnemy.maxHealth = dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 2:
		newEnemy = fae3_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	elif Num == 3:
		newEnemy = fae0_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	else:
		newEnemy = fortuneFae_inst.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		newEnemy.item_drop = 0.5

	newEnemy.position = _get_rspawn_position()
	get_parent().add_child(newEnemy)


func _on_timer_timeout():
	spawn_left_enemy()
	spawn_right_enemy()
		
	$Timer.start()
