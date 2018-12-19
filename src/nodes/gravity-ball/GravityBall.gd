extends Area2D

const launch_time = 1.0

func launch(target_position):
	$MoveTween.interpolate_property(self, "position", global_position, target_position, launch_time, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$MoveTween.start()

func _on_MoveTween_tween_completed(object, key):
	$CollisionShape2D.disabled = false
	$SuckParticles.emitting = true
	$EffectTimer.start()

func _on_EffectTimer_timeout():
	queue_free()