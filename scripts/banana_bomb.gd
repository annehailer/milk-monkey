extends Node2D

@export var explosion: PackedScene 
@export var shake_force: float

@onready var banana_shadow: Node2D = %BananaShadow
@onready var bananas: CharacterBody2D = %Bananas

var initial_distance: float
var initial_shadow_scale: Vector2

func _ready() -> void:
	initial_distance = abs(
		bananas.global_position.y - banana_shadow.global_position.y
	)
	initial_shadow_scale = banana_shadow.scale

func _process(delta: float) -> void:
	if bananas.global_position.y > banana_shadow.global_position.y - 12: 
		banana_shadow.scale = Vector2.ONE
		spawn_explosion()
	
	bananas.velocity += bananas.get_gravity()/6 * delta
	bananas.move_and_slide()
	
	update_shadow()

func update_shadow() -> void:
	var current_distance = abs(
		bananas.global_position.y - banana_shadow.global_position.y
	)
	
	# 0 = distância inicial, 1 = chegou na sombra
	var progress = 1.0 - (current_distance / initial_distance)
	progress = clamp(progress, 0.0, 1.0)
	
	banana_shadow.scale = initial_shadow_scale.lerp(Vector2.ONE, progress)

func spawn_explosion():
	var explosion_instance = explosion.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	ScreenShake.do_screen_shake(shake_force, 0.2)
	queue_free()
