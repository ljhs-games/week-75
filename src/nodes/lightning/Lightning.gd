extends Area2D

const move_time = 1.0

func fire(base_position, target_position):
	global_position = base_position
	rotation = global_position.angle_to_point(target_position)
	$MoveTween.interpolate_property(self, "position", global_position, target_position, move_time, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$MoveTween.start()

func _on_Lightning_area_entered(area):
	if area.is_in_group("puddle"):
		area.shock()
		queue_free()

func _on_MoveTween_tween_completed(object, key):
	queue_free()