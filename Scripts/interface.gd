extends Control

var barDefaultColor = Color(0.4471, 1, 0.4745, 1)
var crystalBar
var healthBar

var crystal
var player


func _ready():
	player = get_parent().get_node("Player")
	$AnikahFace.play("default")
	
	healthBar = $NinePatchRect2/PlayerBar
	healthBar.max_value = player.maxHealth
	
	
	crystal = get_parent().get_node("Crystal")
	$PlayerCristal.play("default")
	
	crystalBar = $NinePatchRect3/PlayerBar
	crystalBar.max_value = crystal.maxHealth


func _process(delta):
	update_crystal()
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
		
		
		if crystal.modulate != crystal.defaultColor:
			$NinePatchRect3/PlayerBar.modulate = crystal.modulate
		else:
			$NinePatchRect3/PlayerBar.modulate = barDefaultColor
			
		$PlayerCristal.modulate = crystal.modulate


func update_crystal():
	if crystal.maxHealth <= 99999 and crystal.health <= 99999:
		$NinePatchRect3/Label.text = str(crystal.health) + " / " + str(crystal.maxHealth)
		
	crystalBar.max_value = crystal.maxHealth
	crystalBar.value = crystal.health


func update_health():
	if player.maxHealth <= 99999 and player.health <= 99999:
		$NinePatchRect2/Label.text = str(player.health) + " / " + str(player.maxHealth)
		
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
