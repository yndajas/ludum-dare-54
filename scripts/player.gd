extends CharacterBody2D

@export var jump_sounds: Array[AudioStreamMP3]

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var direction: float = 0.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var goal_reached: bool = false

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	goal_reached = get_parent().goal_reached
	set_animation()
	set_orientation()
	set_movement(delta)
	move_and_slide()

func set_animation() -> void:
	if not is_on_floor():
		$AnimatedSprite2D.play("jump_middle")
	elif direction && !goal_reached:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

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
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

func play_jump_sfx() -> void:
	$JumpSfxPlayer.stream = jump_sounds.pick_random()
	$JumpSfxPlayer.play()
