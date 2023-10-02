extends Node2D

@export var goodbye_sounds: Array[AudioStreamWAV]
@export var start_game_sounds: Array[AudioStreamWAV]
@export var toggle_full_screen_sounds: Array[AudioStreamWAV]
@export var quit_sounds: Array[AudioStreamWAV]

@onready var quit_button: Button = $MenuItems/QuitButton
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer
@onready var start_button: Button = $MenuItems/StartButton
@onready var toggle_full_screen_button: Button = $MenuItems/ToggleFullScreenButton

var sounds: Dictionary
var exit_initiated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sounds = {
		"goodbye": goodbye_sounds,
		"start_game": start_game_sounds,
		"toggle_full_screen": toggle_full_screen_sounds,
		"quit": quit_sounds
	}
	start_button.grab_focus()
	
	if !OS.has_feature("pc"):
		toggle_full_screen_button.hide()
		quit_button.hide()

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
	play_random_sound("start_game")

func _on_quit_button_pressed() -> void:
	play_random_sound("goodbye")
	exit_initiated = true
	
func _on_start_button_focus_entered() -> void:
	play_random_sound("start_game")

func _on_toggle_full_screen_button_focus_entered() -> void:
	play_random_sound("toggle_full_screen")

func _on_quit_button_focus_entered() -> void:
	play_random_sound("quit")

func _on_start_button_mouse_entered() -> void:
	start_button.grab_focus()

func _on_toggle_full_screen_button_mouse_entered() -> void:
	toggle_full_screen_button.grab_focus()

func _on_quit_button_mouse_entered() -> void:
	quit_button.grab_focus()

func _on_sfx_player_finished() -> void:
	if exit_initiated:
		get_tree().quit()

func play_random_sound(action: String) -> void:
	var stream = sounds[action].pick_random()
	sfx_player.stream = stream
	sfx_player.play()
