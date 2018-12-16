extends RigidBody2D

signal done_turning
signal health_changed(new_health)

const accel = 1400
const turn_speed = 90
const health_per_sec = 20
const negatives = ["g_left", "g_up"]

var cur_directions = { "g_right": 0, "g_left": 0, "g_up": 0, "g_down": 0 }
var directional = Vector2()
var target_angle = 0.0 # in radians
var turning = false
var health = 40.0 setget _set_health

func _set_health(new_health):
	health = new_health
	emit_signal("health_changed", new_health)

func _ready():
	set_process(true)
	set_process_input(true)
	set_physics_process(true)

func _process(delta):
	if health < 100.0:
		self.health += health_per_sec*delta
	
	else:
		self.health = 100.0

func _input(event):
	for cur_action_str in cur_directions.keys():
		if event.is_action_pressed(cur_action_str):
			# make it negative if in negatives to reverse direction
			cur_directions[cur_action_str] = int(negatives.has(cur_action_str))*-2 + 1
		elif event.is_action_released(cur_action_str):
			cur_directions[cur_action_str] = 0
		directional = Vector2(cur_directions["g_right"] + cur_directions["g_left"], cur_directions["g_down"] + cur_directions["g_up"])
	if event.is_action_pressed("g_lightning") and $LightningTimer.is_stopped():
		target_angle = global_position.angle_to_point(event.global_position) + PI
		shoot_lightning(event.global_position)
		turning = true
		$LightningTimer.start()
	elif event.is_action_pressed("g_gravity") and $GravityTimer.is_stopped():
		target_angle = global_position.angle_to_point(event.global_position) + PI
		shoot_gravity(event.global_position)
		turning = true
		$GravityTimer.start()

func shoot_lightning(target_point):
	yield(self, "done_turning")
	print("shooting lightning")

func shoot_gravity(target_point):
	yield(self, "done_turning")
	print("shooting gravity")

func hit(damage, knockback_direction, knockback_magnitude):
	self.health -= damage
	if health <= 0:
		GameState.dead = true
		return
	apply_impulse(Vector2(), knockback_direction*knockback_magnitude)

func _physics_process(delta):
	applied_force = directional*accel
	if turning:
		angular_damp = -1
		var angle_err = angle_difference(rotation, target_angle)
		applied_torque = rad2deg(angle_err)*turn_speed
		if abs(angle_err) < deg2rad(10.0):
			turning = false
			emit_signal("done_turning")
	else:
		angular_damp = 20.0
		applied_torque = 0.0

func angle_difference(a1, a2):
	var to_return = a2 - a1
	to_return = fmod((to_return + PI), 2*PI) - PI
	return to_return