extends CharacterBody2D
class_name Crystal


#Objects
var healthBar

#Atributes
var maxHealth = 100
var health = maxHealth

var alive = true

#Colors
var damageColor = Color(1, 0, 0, 1)
var healColor = Color(0, 1, 0, 1)
var defaultColor = Color(1, 1, 1, 1)


func _ready():
	$PlayerCristal.play("Idle")
	
	healthBar = $HealthBar
	healthBar.max_value = maxHealth


func _process(delta):
	update_health()


func update_health():
	if health >= maxHealth:
		health = maxHealth
		
	healthBar.value = health
	
	if health >= maxHealth:
		healthBar.visible = false
	
	else:
		healthBar.visible = true


func take_damage(damage):
	if alive:
		self.modulate = damageColor
		health -= damage
		
		if health <= 0:
			return true
		
		else:
			return false


func heals(healPoints):
	if health < maxHealth:
		health += healPoints
		
		self.modulate = healColor
		$HealTimer.start()


func _on_heal_timer_timeout():
	self.modulate = defaultColor
