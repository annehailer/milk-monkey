extends Node2D

@onready var game_over_panel: Panel = $CanvasLayer/GameOverPanel

func show_game_over():
	game_over_panel.visible = true


func _on_button_pressed() -> void:
	get_tree().paused = false
	
	#get_tree().change_scene_to_file("res://monster_girl_dialogue")
	print("failed")
