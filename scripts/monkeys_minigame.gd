extends Node2D
class_name MonkeyMinigame

@onready var player: CharacterBody2D = %Player
@onready var monkey_spawner: Monkey_Spawner = %MonkeySpawner
var milk: int = 0


func _ready() -> void:
	player.monkey_minigame = self
	monkey_spawner.monkey_minigame = self


func get_milk():
	milk += 1
