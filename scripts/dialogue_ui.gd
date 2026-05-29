# SpeechBubble.gd
# Simple Visual Novel speech bubble system for Godot 4

extends CanvasLayer

@onready var name_label = $Panel/Name
@onready var dialogue_label = $Panel/Dialogue
@onready var next_indicator = $Panel/NextIndicator

var dialogue_lines = []
var current_line = 0
var typing_speed = 0.03
var is_typing = false

func _ready():
	hide()

# Start dialogue
func start_dialogue(lines):
	dialogue_lines = lines
	current_line = 0
	show()
	display_line()

# Display current line
func display_line():
	if current_line >= dialogue_lines.size():
		end_dialogue()
		return
	
	var line = dialogue_lines[current_line]
	
	name_label.text = line["name"]
	dialogue_label.text = ""
	
	type_text(line["text"])

# Typewriter effect
func type_text(text):
	is_typing = true
	next_indicator.hide()
	
	for letter in text:
		dialogue_label.text += letter
		await get_tree().create_timer(typing_speed).timeout
	
	is_typing = false
	next_indicator.show()

# Click to continue
func _input(event):
	if event.is_action_pressed("ui_accept"):
		
		# Instantly finish typing
		if is_typing:
			return
		
		current_line += 1
		display_line()

# End dialogue
func end_dialogue():
	hide()
