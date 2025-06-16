extends Node2D

@onready var score_label = get_node("Panel/Score")
@onready var high_score_label = get_node("Panel/HighScore")

func show_scores(score: int, high_score: int):
	score_label.text = "Score: %d" % score
	high_score_label.text = "High Score: %d" % high_score
	visible = true

func _on_home_pressed() -> void:
	get_tree().paused = false
	ScoreManager.current_score = 0
	get_tree().change_scene_to_file("res://main.tscn")

func _on_replay_pressed() -> void:
	get_tree().paused = false
	ScoreManager.current_score = 0
	get_tree().reload_current_scene()
