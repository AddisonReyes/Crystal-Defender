extends Node2D


#Objects
var rng = RandomNumberGenerator.new()
var player

#Preloads
const fae0 = preload("res://Scenes/fae_0.tscn")
const fae1 = preload("res://Scenes/fae_1.tscn")
const fae2 = preload("res://Scenes/fae_2.tscn")
const fae3 = preload("res://Scenes/fae_3.tscn")
const fae4 = preload("res://Scenes/fae_4.tscn")
const fae5 = preload("res://Scenes/fae_5.tscn")
const fortuneFae = preload("res://Scenes/fortuneFae.tscn")

#Instances
var fae0_instance = fae0.instantiate()
var fae1_instance = fae1.instantiate()
var fae2_instance = fae2.instantiate()
var fae3_instance = fae3.instantiate()
var fae4_instance = fae4.instantiate()
var fae5_instance = fae5.instantiate()
var fortuneFae_inst = fortuneFae.instantiate()

var dificultyAdded = -5
var enemiesSpawn = 0
var spawnRate = 5.6

var twoSpawners = false


func _ready():
	player = get_parent().get_node("Player")
	$Timer.wait_time = spawnRate
	$Timer.start()


func update_spawn_rate():
	$Timer.wait_time = spawnRate


func add_difficulty():
	dificultyAdded += rng.randi_range(5, 10)
	spawnRate -= 0.016


func add_enemy():
	if enemiesSpawn <= 7:
		enemiesSpawn += 1


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
	var Num = rng.randi_range(0, enemiesSpawn)
	var newEnemy
			
	if Num == 0:
		newEnemy = fae0_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		
	elif Num == 1:
		newEnemy = fortuneFae_inst.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		newEnemy.item_drop = 0.4
	
	elif Num == 2:
		newEnemy = fae1_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		
	elif Num == 3:
		newEnemy = fae2_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	elif Num == 4:
		newEnemy = fae3_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	elif Num == 5:
		newEnemy = fae4_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	else:
		newEnemy = fae5_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded

	newEnemy.position = _get_lspawn_position()
	get_parent().add_child(newEnemy)


func spawn_right_enemy():
	var Num = rng.randi_range(0, enemiesSpawn)
	var newEnemy
			
	if Num == 0:
		newEnemy = fae0_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		
	elif Num == 1:
		newEnemy = fortuneFae_inst.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		newEnemy.item_drop = 0.4
	
	elif Num == 2:
		newEnemy = fae1_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
		
	elif Num == 3:
		newEnemy = fae2_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	elif Num == 4:
		newEnemy = fae3_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	elif Num == 5:
		newEnemy = fae4_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded
	
	else:
		newEnemy = fae5_instance.duplicate()
		newEnemy.maxHealth += dificultyAdded
		newEnemy.damage += dificultyAdded

	newEnemy.position = _get_rspawn_position()
	get_parent().add_child(newEnemy)


func _on_timer_timeout():
	if twoSpawners:
		spawn_left_enemy()
		spawn_right_enemy()
	
	else:
		var spawnNum = rng.randi_range(0, 1)
		
		if spawnNum == 0:
			spawn_left_enemy()
		
		else:
			spawn_right_enemy()
		
	$Timer.start()
