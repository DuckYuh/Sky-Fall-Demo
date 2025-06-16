extends Node

var current_score = 0
var high_score = 0

const SAVE_FILE_PATH := "user://highscore.save"

func _ready():
	load_high_score()
	
func add_score(points):
	current_score += points
	if current_score > high_score:
		high_score = current_score
		save_high_score()

func save_high_score():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(high_score)
	file.close()

func load_high_score():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		high_score = file.get_var()
		file.close()
	else:
		high_score = 0
