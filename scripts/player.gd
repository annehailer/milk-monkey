extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 2.8
const ACCELERATION = 20
const FRICTION = 25

func _physics_process(delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	if direction.length() > 0.1:
		var target_velocity = direction.normalized() * SPEED * 100
		
		velocity.x = move_toward(
			velocity.x,
			target_velocity.x,
			ACCELERATION * 100 * delta
		)

		velocity.y = move_toward(
			velocity.y,
			target_velocity.y * 0.8,
			ACCELERATION * 100 * delta
		)

		anim.play("walk")

		if abs(direction.x) > 0.1:
			anim.flip_h = direction.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * 100 * delta)
		velocity.y = move_toward(velocity.y, 0, FRICTION * 100 * delta)

		anim.play("idle")

	move_and_slide()


#func _on_hitbox_body_entered(area: Node2D) -> void:
	#if area.is_in_group("Bananas"):
		#get_tree().paused = true
		#get_parent().show_game_over()
