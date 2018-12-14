extends ProgressBar

func _ready():
	GameState.score = 0
	GameState.time_left = GameState.max_time
	min_value = 0.0
	max_value = GameState.max_time
	GameState.connect("game_over", self, "_on_GameState_game_over")
	GameState.connect("dead", self, "_on_GameState_dead")
	set_process(true)

func _on_GameState_game_over():
	get_tree().change_scene("res://scenes/Score.tscn")

func _on_GameState_dead():
	get_tree().change_scene("res://scenes/Dead.tscn")

func _process(delta):
	GameState.time_left -= delta
	value = GameState.time_left