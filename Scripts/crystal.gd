extends CharacterBody2D
class_name Crystal


#Objects
var healthBar

#Atributes
var maxHealth = 1600
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
	
	if health <= 0 and alive:
		death()


func update_health():
	$HealthBar/Label.text = str(maxHealth) + " / " + str(health)
	healthBar.max_value = maxHealth
	
	if health >= maxHealth:
		health = maxHealth
		
	healthBar.value = health


func death():
	$Death.play()
	$PlayerCristal.play("Death")
	alive = false


func take_damage(damage):
	if alive:
		$Hurt.play()
		self.modulate = damageColor
		$Recovery.start()
		health -= damage


func heals(healPoints):
	if health < maxHealth:
		health += healPoints
		
		self.modulate = healColor
		$HealTimer.start()


func _on_heal_timer_timeout():
	self.modulate = defaultColor


func _on_recovery_timeout():
	self.modulate = defaultColor
