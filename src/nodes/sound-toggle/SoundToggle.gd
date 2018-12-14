extends Button

func _on_SoundToggle_pressed():
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))