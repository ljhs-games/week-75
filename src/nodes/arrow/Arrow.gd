extends Area2D

const fade_time = 1.0
const move_velocity = 400.0
const damage = 20.0
const knockback = 600.0

func _ready():
	set_process(true)

func _process(delta):
	global_position += Vector2(move_velocity*delta, 0).rotated(rotation)

func _on_VisibilityNotifier2D_screen_exited():
	if is_processing(): # make sure doesn't free while reparenting to player
		queue_free()

func _on_Arrow_body_entered(body):
	if body.is_in_group("player"):
		body.hit(damage, Vector2(1, 0).rotated(rotation), knockback)
		call_deferred("reparent", body) # can't reparent while in this signal

func reparent(player_node):
	# Stop colliding with player
	$CollisionShape2D.disabled = true
	# preserve visible location
	var cur_global_pos = global_position
	var cur_rotation = global_rotation
	# stop moving and follow player
	set_process(false)
	get_parent().remove_child(self)
	player_node.add_child(self)
	# preserve visible location
	global_position = cur_global_pos
	global_rotation = cur_rotation
	$FadeTween.interpolate_property(self, "modulate:a", 1.0, 0.0, fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$FadeTween.start()

func _on_FadeTween_tween_completed(object, key):
	queue_free()