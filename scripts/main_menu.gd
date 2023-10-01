extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuItems/StartButton.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_toggle_full_screen_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_start_button_mouse_entered() -> void:
	$MenuItems/StartButton.grab_focus()

func _on_toggle_full_screen_button_mouse_entered() -> void:
	$MenuItems/ToggleFullScreenButton.grab_focus()
