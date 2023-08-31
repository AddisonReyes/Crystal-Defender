extends Node2D


var rng = RandomNumberGenerator.new()

var crystal
var spawner
var player

var fortune

var transparency = 1

var multiShotProbability = 0.01
var coldBowProbability = 0.02


func _ready():
	$Coin.play("default")
	$Timer.start()
	
	crystal = get_parent().get_node("Crystal") 
	player = get_parent().get_node("Player")
	spawner = get_parent().get_node("Spawner")
	
	fortune = rng.randi_range(1, 15)
	
	if fortune == 1:
		$Label.text = "The Goddess of Fortune has blessed you with more life."
		player.maxHealth += 50
		player.health = player.maxHealth
	
	if fortune == 2:
		$Label.text = "The Goddess of Fortune has given you more damage."
		player.damage += 10
	
	if fortune == 3:
		var numCoins = rng.randi_range(1, 6)
		$Label.text = "The Goddess of Fortune has given you " + str(numCoins) + " coins."
		player.Coins += numCoins
	
	if fortune == 4:
		$Label.text = "The Goddess of Fortune has blessed you with more attack speed."
		player.fireRate -= 0.01
	
	if fortune == 5:
		$Label.text = "The Goddess of Fortune has given more life to your crystal."
		crystal.maxHealth += 260
		crystal.health += 260
	
	if fortune == 6:
		$Label.text = "The Goddess of Fortune has decreased the enemy spawn rate."
		spawner.spawnRate += 0.01
		spawner.update_spawn_rate()
	
	if fortune == 7:
		$Label.text = "The Goddess of Fortune buffed your enemies."
		spawner.dificultyAdded += 10
	
	if fortune == 8:
		$Label.text = "The Goddess of Fortune nerfed your enemies."
		if spawner.dificultyAdded > 0:
			spawner.dificultyAdded -= 5
	
	if fortune == 9:
		$Label.text = "The Goddess of Fortune heals you."
		player.health = player.maxHealth
	
	if fortune == 10:
		$Label.text = "The Goddess of Fortune has reset your respawn time."
		player.reviveTime = 3
	
	if fortune == 11:
		$Label.text = "Flip another coin..."
		
		var num = rng.randf_range(0, 1)
		if num <= multiShotProbability and player.multiShoot == false:
			$Label.text = "The Goddess of Fortune has blessed you with more arrows."
			player.multiShoot = true
			
		elif player.multiShoot:
			$Label.text = "The goddess of fortune has increased your spawn time"
			player.reviveTime += 1
	
	if fortune == 12:
		$Label.text = "The Goddess of Fortune has healed the crystal."
		crystal.health += 500
	
	if fortune == 13:
		$Label.text = "The goddess of fortune has healed the crystal a little bit."
		crystal.health += 250
	
	if fortune == 14:
		$Label.text = "This coin feels cold..."
		
		var num = rng.randf_range(0, 1)
		if num <= coldBowProbability and player.frozenBow == false:
			$Label.text = "The Goddess of Fortune has blessed you with more arrows."
			player.frozenBow = true
			
		elif player.frozenBow:
			$Label.text = "The Goddess of Fortune has increased the enemy spawn rate."
			spawner.spawnRate -= 0.01
			spawner.update_spawn_rate()
	
	if fortune == 15:
		$Label.text = "Your luck has increased!"
		multiShotProbability += 0.0006
		coldBowProbability += 0.0006


func _physics_process(delta):
	$Label.modulate = Color(1, 0.6549, 0.9922, transparency)
	transparency -= 0.0056
	position.y -= 3.6


func _on_timer_timeout():
	queue_free()
