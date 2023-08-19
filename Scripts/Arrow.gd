extends CharacterBody2D


var arrowVelocity = Vector2(0, 0)
var direction = Vector2(0, 0)
var orientation_fixed = true

var damage = 5
var speed = 900
var gravityForce = 0.6


func _ready():
	$Timer.start()


func _physics_process(delta):
	var collision_info = move_and_collide(arrowVelocity.normalized() * delta * speed)
	
	if orientation_fixed:
		look_at(direction)
		orientation_fixed = false


func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body is Fae1:
		print("OK")
		body.take_damage(damage)
		queue_free()


func _on__gravity__timeout():
	arrowVelocity = Vector2(arrowVelocity.x, arrowVelocity.y + gravityForce)
	speed -= gravityForce
