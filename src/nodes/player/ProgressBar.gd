extends ProgressBar

export (NodePath) var timer_path

onready var timer_node = get_node(timer_path)

func _ready():
	max_value = timer_node.wait_time
	set_process(true)

func _process(delta):
	value = timer_node.wait_time - timer_node.time_left