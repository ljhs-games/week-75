extends Node2D

export (PackedScene) var spawn_pack
export var respawn_time_range = Vector2(0.2, 1.0)
export var spawn_padding = 50.0 # makes sure enemies spawn outside screen
export (NodePath) var player_path # pass to enemies to follow

var display_size = Vector2()

onready var player_node = get_node(player_path)

func _ready():
	display_size = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	$SpawnTimer.wait_time = respawn_time_range.y
	$SpawnTimer.start()

func spawn_enemy():
	var cur_enemy = spawn_pack.instance()
	add_child(cur_enemy)
	cur_enemy.global_position = Vector2(rand_range(-spawn_padding, display_size.x + spawn_padding), rand_range(-spawn_padding, display_size.y + spawn_padding))
	cur_enemy.player_node = player_node

func reset_timer():
	$SpawnTimer.wait_time = rand_range(respawn_time_range.x, respawn_time_range.y)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawn_enemy()
	reset_timer()