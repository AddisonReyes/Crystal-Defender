extends Control

var barDefaultColor = Color(0.4471, 1, 0.4745, 1)
var healthBar
var player


func _ready():
	player = get_parent().get_node("Player")
	$AnikahFace.play("default")
	
	healthBar = $NinePatchRect2/PlayerBar
	healthBar.max_value = player.maxHealth


func _process(delta):
	update_health()
	
	if player.alive:
		position = player.InterfacePosition
		
		if player.Coins <= 999:
			$NinePatchRect/Label.text = str(player.Coins)
		
		if player.modulate != player.defaultColor:
			$NinePatchRect2/PlayerBar.modulate = player.modulate
		else:
			$NinePatchRect2/PlayerBar.modulate = barDefaultColor
			
		$AnikahFace.modulate = player.modulate
		


func update_health():
	if player.maxHealth <= 99999 and player.health <= 99999:
		$NinePatchRect2/Label.text = str(player.maxHealth) + " / " + str(player.health)
		
	healthBar.max_value = player.maxHealth
	healthBar.value = player.health
	
	#if player.health >= player.maxHealth:
		#healthBar.visible = false
	
	#else:
		#healthBar.visible = true


func _on_pause_pressed():
	$AudioStreamPlayer2D.play()
	if get_tree().paused:
		get_tree().paused = false
	
	else:
		get_tree().paused = true
