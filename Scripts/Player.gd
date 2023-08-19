extends CharacterBody2D
class_name Player


#Objects
const ArrowPath = preload("res://Scenes/arrow.tscn")

var healthBar

#Atributes
var damage = 10
var fireRate = 0.6
var maxHealth = 60
var health = maxHealth

const PIXELS_TO_MOVE = 1.6
const SPEED = 250.0

var lookingRight = true
var can_shoot = true
var alive = true

#Colors
var damageColor = Color(1, 0, 0, 1)
var healColor = Color(0, 1, 0, 1)
var defaultColor = Color(1, 1, 1, 1)


func _ready():
	$Player.play("Idle")
	
	healthBar = $HealthBar
	healthBar.max_value = maxHealth


func _physics_process(delta):
	update_health()
	
	if health <= 0 and alive:
		death()
	
	if alive:
		movement()
		
		if self.position.x <= get_global_mouse_position().x:
			$Player.flip_h = false
		else:
			$Player.flip_h = true
		
		$Bow.look_at(get_global_mouse_position())
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
			singleShoot()
		
		move_and_slide()


func movement():
	var direction = _player_movement()
		
	if direction[0]:
		velocity.x = direction[0] * SPEED
		
		if direction[0] == PIXELS_TO_MOVE: lookingRight = true
		else: lookingRight = false
		
		$Player.play("Walk")
		if lookingRight:
			$Player.flip_h = false
		
		else:
			$Player.flip_h = true
		
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction[1]:
		velocity.y = direction[1] * SPEED
			
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if direction[0] == 0 and direction[1] == 0:
		$Player.play("Idle")


func singleShoot():
	var arrow = ArrowPath.instantiate()
	get_parent().add_child(arrow)
	
	arrow.position = $Bow/position.global_position
	arrow.direction = $Bow/direction.global_position
	arrow.arrowVelocity = $Bow/direction.global_position - arrow.position
	arrow.damage = damage * 2
	
	can_shoot = false
	$Timers/FireRate.wait_time = fireRate
	$Timers/FireRate.start()


func take_damage(damage):
	if alive:
		self.modulate = damageColor
		$Timers/Recovery.start()
		health -= damage


func death():
	$Bow.hide()
	$Player.play("Death")
	alive = false


func heals(healPoints):
	if health < maxHealth:
		health += healPoints
		
		self.modulate = healColor
		$Timers/HealTimer.start()


func _player_movement():
	var directionx = 0
	var directiony = 0
	
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A): 
		directionx = -PIXELS_TO_MOVE
		if Input.is_key_pressed(KEY_SHIFT):
			directionx = -PIXELS_TO_MOVE/2
			
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D): 
		directionx = PIXELS_TO_MOVE
		if Input.is_key_pressed(KEY_SHIFT):
			directionx = PIXELS_TO_MOVE/2
			
	else: directionx = 0
		
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W): 
		directiony = -PIXELS_TO_MOVE
		if Input.is_key_pressed(KEY_SHIFT):
			directiony = -PIXELS_TO_MOVE/2
			
	elif Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S): 
		directiony = PIXELS_TO_MOVE
		if Input.is_key_pressed(KEY_SHIFT):
			directiony = PIXELS_TO_MOVE/2
			
	else: directiony = 0
	
	var direction = [directionx, directiony]
	return direction


func update_health():
	if health >= maxHealth:
		health = maxHealth
		
	healthBar.value = health
	
	if health >= maxHealth:
		healthBar.visible = false
	
	else:
		healthBar.visible = true


func _on_heal_timer_timeout():
	self.modulate = defaultColor


func _on_fire_rate_timeout():
	can_shoot = true


func _on_recovery_timeout():
	self.modulate = defaultColor
