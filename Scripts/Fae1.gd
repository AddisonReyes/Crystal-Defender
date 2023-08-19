extends CharacterBody2D
class_name Fae1


#Objects
const CrystalPath = preload("res://Scenes/crystalHeart.tscn")
const HeartPath = preload("res://Scenes/heart.tscn")
var rng = RandomNumberGenerator.new()

var healthBar
var crystal
var player

var objetive

#Atributes
var maxHealth = 30
var health = maxHealth
var damage = 10

const SPEED = 260
var state = "Walk"

var heart_drop = 0.15
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
	update_health()
	
	$RayCast2D.look_at(crystal.position)
	$RayCast2D2.look_at(player.position)
	
	if $RayCast2D2.is_colliding() and objetive != crystal:
		if $RayCast2D2.get_collider() is Player:
			objetive = player
			
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider() is Crystal:
			objetive = crystal
	
	if crystal.alive == false:
		objetive = player
	
	if state == "Attack":
		if canAttack and attackCooldown:
			objetive.take_damage(damage)
			attackCooldown = false
			$Timer.start()
	
	if state == "Walk":
		var target_position = (objetive.position - position).normalized()
		
		if position.distance_to(objetive.position) > 3:
			var new_position = Vector2(target_position.x, target_position.y)
			velocity = Vector2(new_position * SPEED)
				
			move_and_slide()


func take_damage(damage):
	if health <= 0:
		death()

	self.modulate = damageColor
	$Recovery.start()
	health -= damage


func death():
	var num = rng.randf_range(0.0, 1.0)
	if num < heart_drop:
		var heartNum = rng.randi_range(0, 1)
		var new_item
		
		if heartNum == 0:
			new_item = HeartPath.instantiate()
		else:
			new_item = CrystalPath.instantiate()
		
		new_item.position = self.position
		get_parent().get_node("Items").add_child(new_item)
	
	queue_free()


func update_health():
	if health >= maxHealth:
		health = maxHealth
		
	healthBar.value = health
	
	if health >= maxHealth:
		healthBar.visible = false
	
	else:
		healthBar.visible = true


func _on_attack_area_2d_body_entered(body):
	if body is Player or body is Crystal:
		state = "Attack"
		canAttack = true


func _on_attack_area_2d_body_exited(body):
	if body is Player or body is Crystal:
		state = "Walk"
		canAttack = false


func _on_timer_timeout():
	attackCooldown = true


func _on_recovery_timeout():
	self.modulate = defaultColor


func _on_attack_area_2d_mouse_entered():
	healthBar.visible = true


func _on_attack_area_2d_mouse_exited():
	healthBar.visible = false
