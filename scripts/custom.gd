extends Node2D

@onready var char1 = $Char1
@onready var char2 = $Char2
@onready var char3 = $Char3

func highlight_selected_button(selected_button: Button) -> void:
	var buttons = [char1, char2, char3]
	for button in buttons:
		if button == selected_button:
			button.modulate = Color(1, 1, 0.5) # Vàng nhạt
		else:
			button.modulate = Color(1, 1, 1)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/play.tscn")

func _on_char_1_pressed() -> void:
	CharacterManager.selected_character = preload("res://characters/character1.tscn")
	highlight_selected_button(char1)

func _on_char_2_pressed() -> void:
	CharacterManager.selected_character = preload("res://characters/character2.tscn")
	highlight_selected_button(char2)

func _on_char_3_pressed() -> void:
	CharacterManager.selected_character = preload("res://characters/character3.tscn")
	highlight_selected_button(char3)
