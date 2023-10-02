extends Node2D

@export var congratulations_tracks: Array[AudioStreamWAV]
@export var music_tracks: Array[AudioStreamWAV]

@onready var congratulations_player: AudioStreamPlayer = $CongratulationsPlayer
@onready var congratulations_text: RichTextLabel = $EndTextTimer/Congratulations
@onready var easter_egg_player: AudioStreamPlayer = $EasterEggTimer/Player
@onready var easter_egg_timer: Timer = $EasterEggTimer
@onready var end_text_timer: Timer = $EndTextTimer
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var player: CharacterBody2D = $Player
@onready var result_text: RichTextLabel = $EndTextTimer/Result
@onready var time_indicator: RichTextLabel = $CanvasLayer/Time

var goal_reached: bool = false
var music_stream: AudioStreamWAV
var time_elapsed: float = 0.0
var time_elapsed_rounded_string: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_stream = music_tracks[0]
	loop_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !goal_reached:
		time_elapsed += delta
		time_elapsed_rounded_string = "%.2f" % time_elapsed
		time_indicator.text = "[center]" + time_elapsed_rounded_string

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

	if event.is_action_pressed("reset_level"):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")

	if event.is_action_pressed("toggle_music"):
		music_player.stream_paused = !music_player.stream_paused

func _on_door_1_body_entered(body: Node2D) -> void:
	if body == player:
		player.position = Vector2(-472, -664)
		queue_track_change(music_tracks[1])
	
func _on_door_2_body_entered(body: Node2D) -> void:
	if body == player:
		player.position = Vector2(464, -448)
		queue_track_change(music_tracks[2])

func _on_goal_body_entered(body: Node2D) -> void:
	if !goal_reached && body == player:
		goal_reached = true
		wrap_up()

func _on_music_finished() -> void:
	if !goal_reached:
		loop_music()

func _on_end_text_timer_timeout() -> void:
	var set_visible = !congratulations_text.visible
	if set_visible:
		end_text_timer.start(1.5)
	else:
		end_text_timer.start(0.75)

	congratulations_text.visible = set_visible
	result_text.visible = set_visible

func _on_easter_egg_timer_timeout() -> void:
	easter_egg_player.play()

func loop_music() -> void:
	music_player.stream = music_stream
	music_player.stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	music_player.play()

func queue_track_change(new_track: AudioStreamWAV) -> void:
	music_stream = new_track
	music_player.stream.loop_mode = AudioStreamWAV.LOOP_DISABLED

func wrap_up() -> void:
	queue_track_change(music_tracks[3])
	loop_music()

	if time_elapsed <= 30:
		congratulations_player.stream = congratulations_tracks[0]
	elif time_elapsed <= 40:
		congratulations_player.stream = congratulations_tracks[1]
	else:
		congratulations_player.stream = congratulations_tracks[2]

	congratulations_player.play()
	easter_egg_timer.start()
	trigger_end_text()

func trigger_end_text() -> void:
	time_indicator.hide()
	congratulations_text.show()
	result_text.text = "[right]" + time_elapsed_rounded_string + " seconds"
	result_text.show()
	end_text_timer.start()
