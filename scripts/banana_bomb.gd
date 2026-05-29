extends Node2D

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
		return
		
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
