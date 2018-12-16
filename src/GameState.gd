extends Node

signal dead
signal game_over
signal scored(new_score)

const max_time = 75.0

var score = 0 setget _set_score
var dead = false setget _set_dead
var time_left = max_time setget _set_time_left

func _set_time_left(new_time_left):
	time_left = new_time_left
	if new_time_left <= 0.0:
		emit_signal("game_over")

func _set_score(new_score):
	score = new_score
	emit_signal("scored", new_score)

func _set_dead(new_dead):
	dead = new_dead
	if new_dead == true:
		emit_signal("dead")