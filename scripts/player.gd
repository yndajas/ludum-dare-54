extends CharacterBody2D

@export var jump_sounds: Array[AudioStreamMP3]

@onready var jump_sfx_player: AudioStreamPlayer = $JumpSfxPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -350.0
const SPEED = 200.0

var direction: float = 0.0
var goal_reached: bool = false
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var frames_not_on_floor: int = 0

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	goal_reached = get_parent().goal_reached
	set_animation()
	set_orientation()
	set_movement(delta)
	move_and_slide()
	update_frames_on_floor()

func set_animation() -> void:
	if not is_on_floor():
		if frames_not_on_floor <=10:
			sprite.play("jump_start")
		else:
			sprite.play("jump_middle")
	elif direction && !goal_reached:
		sprite.play("run")
	else:
		sprite.play("idle")

func set_movement(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump") && !goal_reached:
		velocity.y = JUMP_VELOCITY
		play_jump_sfx()

	if direction && !goal_reached:
		var target_velocity_x := direction * SPEED
		velocity.x = move_toward(velocity.x, target_velocity_x, SPEED / 10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)

func set_orientation() -> void:
	if direction && !goal_reached:
		if direction == -1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

func play_jump_sfx() -> void:
	jump_sfx_player.stream = jump_sounds.pick_random()
	jump_sfx_player.play()

func update_frames_on_floor() -> void:
	if is_on_floor():
		frames_not_on_floor = 0
	else:
		frames_not_on_floor += 1
