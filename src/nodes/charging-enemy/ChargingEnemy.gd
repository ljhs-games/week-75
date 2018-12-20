extends RigidBody2D

const impulse_magnitude = 600.0
const hurt_distance = 100.0
const damage = 5.0
const knockback = 200.0

var player_node

func _ready():
	pass

func _integrate_forces(state):
	# turn towards player
	var cur_transform = state.transform
	cur_transform.origin = Vector2()
	cur_transform = cur_transform.rotated( global_position.angle_to_point(player_node.global_position) - rotation + PI)
	cur_transform.origin = state.transform.origin
	state.transform = cur_transform

func _on_ChargeTimer_timeout():
	apply_impulse(Vector2(), Vector2(impulse_magnitude, 0).rotated(rotation))
	if global_position.distance_to(player_node.global_position) < hurt_distance:
		player_node.hit(damage, Vector2(1, 0).rotated(rotation), knockback)

func shock():
	$AnimationPlayer.play("die")
	GameState.score += 1