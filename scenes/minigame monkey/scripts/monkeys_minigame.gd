extends Node2D
class_name MonkeyMinigame

@onready var player: CharacterBody2D = %Player
@onready var monkey_spawner: Monkey_Spawner = %MonkeySpawner
var milk: int = 0


func _ready() -> void:
	#game_over_panel.visible = false
	player.monkey_minigame = self
	monkey_spawner.monkey_minigame = self


func get_milk():
	milk += 1

func victory():
	get_tree().change_scene_to_file(
		"res://scenes/minigame crafting/crafting_minigame.tscn"
	)

@onready var game_over_panel = $UI/GameOverPanel

func game_over():
	game_over_panel.visible = true
	get_tree().paused = true
