extends CharacterBody2D
class_name Player


#Objects
const ArrowPath = preload("res://Scenes/arrow.tscn")
const FrozenArrowPath = preload("res://Scenes/frozenArrow.tscn")
const CoinPath = preload("res://Scenes/coin_flipping.tscn")
var Coin = CoinPath.instantiate()
var crystal

var healthBar

#Atributes
var damage = 18
var fireRate = 0.66
var maxHealth = 100
var health = maxHealth

const PIXELS_TO_MOVE = 1.6
var START_POSITION
const SPEED = 250.0

var yFixed
var InterfacePosition
var canFlipCoins = true
var lookingRight = true
var multiShoot = false
var frozenBow = false
var can_shoot = true
var reviveTime = 3
var alive = true

#Stats
var FaeKilled = 0
var CoinsCollected = 0

var Coins = 0

#Colors
var damageColor = Color(1, 0, 0, 1)
var healColor = Color(0, 1, 0, 1)
var defaultColor = Color(1, 1, 1, 1)


func _ready():
	crystal = get_parent().get_node("Crystal") 
	
	$Label.visible = false
	$Player.play("Idle")
	
	healthBar = $HealthBar
	healthBar.max_value = maxHealth
	
	START_POSITION = self.global_position
	
	yFixed = $Camera2D/InterfacePosition.global_position.y
	InterfacePosition = Vector2($Camera2D/InterfacePosition.global_position.x, yFixed)


func _physics_process(delta):
	InterfacePosition = Vector2($Camera2D/InterfacePosition.global_position.x, yFixed)
	if InterfacePosition <= Vector2(-2394.998, -8):
		InterfacePosition = Vector2(-2394.998, -8)
	elif InterfacePosition >= Vector2(805.8309, -8):
		InterfacePosition = Vector2(805.8309, -8)
	
	update_health()
	
	if frozenBow:
		$Bow.modulate = Color(0, 1, 1, 1)
	
	if health <= 0 and alive:
		death()
	
	if crystal.alive == false:
		$Label.visible = false
	
	if alive:
		if Input.is_key_pressed(KEY_T):
			$Player.play("Dance")
			return
			
		movement()
		
		if self.position.x <= get_global_mouse_position().x:
			$Player.flip_h = false
		else:
			$Player.flip_h = true
		
		$Bow.look_at(get_global_mouse_position())
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
			shoot()
		
		if Input.is_key_pressed(KEY_SPACE) and canFlipCoins and Coins >= 1:
			flipACoin()
		
		move_and_slide()
		
	else:
		$Label.text = str(int(round($Timers/ReviveTimer.get_time_left())))


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


func flipACoin():
	$CoinFlip.play()
	
	Coins -= 1
	canFlipCoins = false
	var item = Coin.duplicate()
	$Timers/CoinCooldown.start()
	
	item.position = self.global_position
	get_parent().add_child(item)


func shoot():
	$bow.play()
	if multiShoot:
		var positions = [$Bow/position1.global_position, $Bow/position2.global_position, $Bow/position3.global_position]
		var directions = [$Bow/direction1.global_position, $Bow/direction2.global_position, $Bow/direction3.global_position]
		
		var frozenArrowInst = FrozenArrowPath.instantiate()
		var arrowInst = ArrowPath.instantiate()
		
		for i in range(3):
			var arrow
			
			if frozenBow:
				arrow = frozenArrowInst.duplicate()
				
			else:
				arrow = arrowInst.duplicate()
				
			get_parent().add_child(arrow)
			
			arrow.position = positions[i]
			arrow.direction = directions[i]
			arrow.arrowVelocity = directions[i] - arrow.position
			arrow.damage = damage / 2
		
	else:
		var arrow
			
		if frozenBow:
			arrow = FrozenArrowPath.instantiate()
			
		else:
			arrow = ArrowPath.instantiate()
				
		get_parent().add_child(arrow)
		
		arrow.position = $Bow/position2.global_position
		arrow.direction = $Bow/direction2.global_position
		arrow.arrowVelocity = $Bow/direction2.global_position - arrow.position
		arrow.damage = damage
		
	can_shoot = false
	$Timers/FireRate.wait_time = fireRate
	$Timers/FireRate.start()


func take_damage(damage):
	if alive:
		$Hurt.play()
		self.modulate = damageColor
		$Timers/Recovery.start()
		health -= damage


func death():
	$Death.play()
	
	$Bow.hide()
	$Player.play("Death")
	alive = false
	
	if crystal.alive:
		$Label.visible = true
		$Timers/ReviveTimer.wait_time = reviveTime
		$Timers/ReviveTimer.start()
		
		if reviveTime <= 9:
			reviveTime += 1


func heals(healPoints):
	if health < maxHealth:
		$Heal.play()
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
	#healthBar.max_value = maxHealth
	if health >= maxHealth:
		health = maxHealth
		
	#healthBar.value = health
	
	#if health >= maxHealth:
		#healthBar.visible = false
	
	#else:
		#healthBar.visible = true


func _on_heal_timer_timeout():
	self.modulate = defaultColor


func _on_fire_rate_timeout():
	can_shoot = true


func _on_recovery_timeout():
	self.modulate = defaultColor


func _on_revive_timer_timeout():
	if alive == false and crystal.alive:
		$Label.visible = false
		$Player.play("Idle")
		$Bow.show()
		
		self.position = START_POSITION
		
		health = maxHealth
		alive = true


func _on_coin_cooldown_timeout():
	canFlipCoins = true
