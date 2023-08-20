extends Node2D


var rng = RandomNumberGenerator.new()

var crystal
var spawner
var player

var fortune


func _ready():
	$Coin.play("default")
	$Timer.start()
	
	crystal = get_parent().get_node("Crystal") 
	player = get_parent().get_node("Player")
	spawner = get_parent().get_node("Spawner")
	
	fortune = rng.randi_range(1, 15)
	
	if fortune == 1:
		$Label.text = "The Goddess of Fortune has blessed you with more life."
		player.maxHealth += 15
		player.health = player.maxHealth
	
	elif fortune == 2:
		$Label.text = "The Goddess of Fortune has given you more damage."
		player.damage += 5
	
	if fortune == 3:
		var numCoins = rng.randi_range(1, 6)
		$Label.text = "The Goddess of Fortune has given you " + str(numCoins) + " coins."
		player.Coins += numCoins
	
	if fortune == 4:
		$Label.text = "The Goddess of Fortune has blessed you with more attack speed."
		player.fireRate -= 0.06
	
	if fortune == 5:
		$Label.text = "The Goddess of Fortune has given more life to your crystal."
		crystal.maxHealth += 50
		crystal.health += 50
	
	if fortune == 6:
		$Label.text = "The Goddess of Fortune has increased the enemy spawn rate."
		spawner.spawnRate -= 0.06
		spawner.update_spawn_rate()
	
	if fortune == 7:
		$Label.text = "The Goddess of Fortune has decreased the enemy spawn rate."
		spawner.spawnRate += 0.05
		spawner.update_spawn_rate()
	
	if fortune == 8:
		$Label.text = "The Goddess of Fortune buffed your enemies."
		spawner.dificultyAdded += 1
	
	if fortune == 9:
		$Label.text = "The Goddess of Fortune nerfed your enemies."
		if spawner.dificultyAdded > 0:
			spawner.dificultyAdded -= 2
	
	if fortune == 10:
		$Label.text = "The Goddess of Fortune heals you."
		player.health = player.maxHealth
	
	if fortune == 11:
		$Label.text = "The Goddess of Fortune has reset your respawn time."
		player.reviveTime = 3
	
	if fortune == 12:
		$Label.text = "The Goddess of Fortune has decreased your attack speed."
		player.fireRate += 0.03
	
	if fortune == 13:
		$Label.text = "The Goddess of Fortune hurts you."
		player.health -= 5
	
	if fortune == 14:
		$Label.text = "The Goddess of Fortune has decreased your damage."
		player.damage -= 2
	
	if fortune == 15:
		$Label.text = "..."
		
		var num = rng.randf_range(0, 1)
		if num <= 0.2 and player.multiShoot == false:
			$Label.text = "The Goddess of Fortune has blessed you with more arrows."
			player.multiShoot = true
			
		elif player.multiShoot:
			$Label.text = "The Goddess of Fortune has given you more damage+."
			player.damage += 10


func _physics_process(delta):
	position.y -= 3.6


func _on_timer_timeout():
	queue_free()
