extends Node2D

const puddle_pack = preload("res://nodes/puddle/Puddle.tscn")
const puddle_padding = 100
const puddles = 5

var display_size

func _ready():
	display_size = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	assert display_size != null
	for i in range(0, puddles):
		spawn_puddle()

func spawn_puddle():
	var cur_puddle = puddle_pack.instance()
	add_child(cur_puddle)
	cur_puddle.global_position = Vector2(
	rand_range(puddle_padding, display_size.x - puddle_padding), 
	rand_range(puddle_padding, display_size.y - puddle_padding))