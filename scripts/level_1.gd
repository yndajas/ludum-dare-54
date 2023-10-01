extends Node2D

@export var music_tracks: Array[AudioStreamWAV]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.stream = music_tracks[0]
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if OS.is_debug_build() && event.is_action_pressed("reset_level"):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_door_1_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player.position = Vector2(-472, -664)

func _on_door_2_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player.position = Vector2(464, -448)
