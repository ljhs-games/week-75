extends RigidBody2D

const speed = 60
var motion = Vector2()

func _physics_process(delta):
	var player = get_node("../Player")
	var vector = (player.position - position).normalized()
	motion += vector
	motion = motion * speed * delta
	set_linear_velocity(motion)
	