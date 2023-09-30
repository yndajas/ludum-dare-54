extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	set_animation()
	set_orientation()
	set_movement(delta)
	move_and_slide()

func get_direction() -> int:
	return Input.get_axis("move_left", "move_right")

func set_animation() -> void:
	if not is_on_floor():
		$AnimatedSprite2D.play("jump_middle")
	elif get_direction():
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func set_movement(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	var direction := get_direction()
	if direction:
		var target_velocity_x := direction * SPEED
		velocity.x = move_toward(velocity.x, target_velocity_x, SPEED / 10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)

func set_orientation() -> void:
	var direction := get_direction()
	if direction:
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
