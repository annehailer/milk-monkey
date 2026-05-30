extends CanvasLayer

func _ready():
	visible = true
	get_tree().paused = true

func _on_start_button_pressed():
	visible = false
	get_tree().paused = false
