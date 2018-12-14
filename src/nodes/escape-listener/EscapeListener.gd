extends Label

var exit_time = 3.0
var leave_counter = 0.0
export (String, FILE, "*.tscn") var main_scene

func _ready():
	set_process(false)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("leave"):
		set_process(true)
	elif event.is_action_released("leave"):
		set_process(false)
		leave_counter = 0.0
		modulate.a = 0.0

func _process(delta):
	leave_counter += delta
	modulate.a = (leave_counter/exit_time)*1.0
	if leave_counter >= exit_time:
		get_tree().change_scene(main_scene)