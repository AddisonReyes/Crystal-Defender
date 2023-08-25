extends CharacterBody2D
class_name FrozenArrow


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
	pass#print(self.modulate)


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body is Limits:
		queue_free()
		
	if body is Fae1 or body is Fae2 or body is Fae3 or body is Fae4 or body is Fae5:
		body.take_damage(damage)
		body.frozed()
		queue_free()


func _on__gravity__timeout():
	arrowVelocity = Vector2(arrowVelocity.x, arrowVelocity.y + gravityForce)
	speed -= gravityForce
