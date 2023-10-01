extends Node2D

@export var music_tracks: Array[AudioStreamWAV]
var stream: AudioStreamWAV
var time_elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = music_tracks[0]
	loop_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	var time_elapsed_rounded_string: String = "%.2f" % time_elapsed
	$CanvasLayer/Time.text = "[center]" + time_elapsed_rounded_string

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

	if event.is_action_pressed("reset_level"):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")

	if event.is_action_pressed("toggle_music"):
		$MusicPlayer.stream_paused = !$MusicPlayer.stream_paused

func _on_door_1_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player.position = Vector2(-472, -664)
		queue_track_change(music_tracks[1])
	
func _on_door_2_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player.position = Vector2(464, -448)
		queue_track_change(music_tracks[2])

func _on_music_finished() -> void:
	loop_music()

func loop_music() -> void:
	$MusicPlayer.stream = stream
	$MusicPlayer.stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	$MusicPlayer.play()

func queue_track_change(new_track: AudioStreamWAV) -> void:
	stream = new_track
	$MusicPlayer.stream.loop_mode = AudioStreamWAV.LOOP_DISABLED
