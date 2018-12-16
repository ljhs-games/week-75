extends ProgressBar

export (NodePath) var player_path

onready var player_node = get_node(player_path)

func _ready():
	player_node.connect("health_changed", self, "_on_Player_health_changed")

func _on_Player_health_changed(new_health):
	value = new_health