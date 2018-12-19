extends RigidBody2D

const arrow_pack = preload("res://nodes/arrow/Arrow.tscn")
const target_force = 300.0
const min_distance = 200.0
const rotate_force = 100.0
const nudge_velocity = 50.0 # to move inside shooting circle

var player_node setget _start_moving
var is_shooting = true
var health = 2

func _ready():
	mode = RigidBody2D.MODE_STATIC
	$CollisionShape2D.disabled = true
	set_process(false)

func _start_moving(in_player_node):
	player_node = in_player_node
	mode = RigidBody2D.MODE_RIGID
	$CollisionShape2D.disabled = false

func _integrate_forces(state):
	var cur_transform = state.transform
	cur_transform.origin = Vector2()
	cur_transform = cur_transform.rotated( global_position.angle_to_point(player_node.global_position) - rotation + PI)
	cur_transform.origin = state.transform.origin
	state.transform = cur_transform
	#state.transform = state.transform.rotated( global_position.angle_to_point(player_node.global_position) - rotation )
	if global_position.distance_to(player_node.global_position) < min_distance:
		if is_shooting == true:
			$ShootTimer.start()
			state.linear_velocity = Vector2(nudge_velocity, 0).rotated(rotation)
			is_shooting = false
		applied_force = Vector2(rotate_force, 0).rotated(rotation - PI/2)
	else:
		$ShootTimer.stop()
		is_shooting = true
		applied_force = Vector2(target_force, 0).rotated(rotation)

func shock():
	$ShockPlayer.play("shock")
	health -= 1
	if health <= 0:
		$ShockPlayer.play("die")
		GameState.score += 1

func _on_ShootTimer_timeout():
	var cur_arrow = arrow_pack.instance()
	get_parent().add_child(cur_arrow)
	cur_arrow.global_position = global_position
	cur_arrow.rotation = rotation
	cur_arrow.set_process(true)