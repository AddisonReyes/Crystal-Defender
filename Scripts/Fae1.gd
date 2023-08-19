extends CharacterBody2D
class_name Fae1


#Objects
var healthBar
var crystal
var player

var objetive

#Atributes
var maxHealth = 30
var health = maxHealth
var damage = 10

const SPEED = 190
var state = "walk"

var heart_drop = 0.2
var canAttack = false
var attackCooldown = true

#Colors
var damageColor = Color(1, 0, 0, 1)
var defaultColor = Color(1, 1, 1, 1)


func _ready():
	crystal = get_parent().get_node("Crystal") 
	player = get_parent().get_node("Player")
	objetive = player
	
	healthBar = $HealthBar
	healthBar.max_value = maxHealth
	
	$Fae1.play("default")


func _physics_process(delta):
	var target_position = (objetive.position - position).normalized()
	update_health()
		
	if position.distance_to(objetive.position) > 10:
		var new_position = Vector2(target_position.x, target_position.y)
		velocity = Vector2(new_position * SPEED)
			
		move_and_slide()


func take_damage(damage):
	if health <= 0:
		death()

	self.modulate = damageColor
	health -= damage


func death():
	#var num = rng.randf_range(0.0, 1.0)
	#if num < heart_drop:
	#	var new_item = HeartPath.instantiate()
	#	new_item.position = self.position
	#	get_parent().add_child(new_item)
	queue_free()


func update_health():
	if health >= maxHealth:
		health = maxHealth
		
	healthBar.value = health
	
	if health >= maxHealth:
		healthBar.visible = false
	
	else:
		healthBar.visible = true


func _on_area_2d_body_entered(body):
	if body is Player:
		objetive = player
	
	if body is Crystal:
		objetive = crystal


func _on_attack_area_2d_body_entered(body):
	if body is Player or body is Crystal:
		if attackCooldown:
			body.take_damage(damage)
			attackCooldown = false
			$Timer.start()


func _on_timer_timeout():
	attackCooldown = true


func _on_recovery_timeout():
	self.modulate = defaultColor
