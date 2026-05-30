extends CharacterBody2D

var monkey_minigame: MonkeyMinigame 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 2.8
const ACCELERATION = 3.7
const FRICTION = 60

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
			(ACCELERATION * 100 * delta) / FRICTION * 100
		)
		
		velocity.y = move_toward(
			velocity.y,
			target_velocity.y * 0.8,
			(ACCELERATION * 100 * delta) / FRICTION * 100
		)
		
		anim.play("walk")
		
		if abs(direction.x) > 0.1:
			#anim.flip_h = direction.x < 0
			pass
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * 15 * delta)
		velocity.y = move_toward(velocity.y, 0, FRICTION * 15 * delta)
		
		anim.play("idle")
	
	sprite_flip(direction)
	move_and_slide()


func sprite_flip(direction: Vector2):
	if direction.x > 0:
		anim.flip_h = false
	elif direction.x < 0:
		anim.flip_h = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Banana"):
		get_tree().current_scene.game_over()
