extends Node2D

@export var mob_scene: PackedScene
@export var spawn_y: float = 200.0  # vị trí spawn

var current_idx := 0
var flag := 1
var timer := 0.0
var SPAWN_INTERVAL := 5.0  # 5 giây
const ntime = 0.2

var score := 0
@onready var score_label = get_node("CanvasLayer/ScoreLabel") 
@onready var game_over_ui = $CanvasLayer/GameOverScreen

func add_score(value: int):
	ScoreManager.add_score(value)
	score_label.text = "Score: %d" % [ScoreManager.current_score]

var character: Node2D

func _ready():
	score_label.text = "Score: 0"
	randomize()

	var character_scene = CharacterManager.selected_character
	character = character_scene.instantiate()
	add_child(character)
	character.position = Vector2(100, 1000)
	
func _process(delta: float) -> void:
	timer += delta
	if timer >= SPAWN_INTERVAL:
		timer = 0
		spawn_mob()
		current_idx += 1
		if current_idx == flag:
			current_idx = 0
			flag += 1
			SPAWN_INTERVAL = SPAWN_INTERVAL - SPAWN_INTERVAL*ntime

func spawn_mob():
	var mob = mob_scene.instantiate()
	mob.player = character
	add_child(mob)
	
	var random_x = randi_range(-400, 1000)
	var spawn_position = Vector2(random_x, spawn_y)
	mob.position = spawn_position

func game_over():
	get_tree().paused = true
	if ScoreManager.current_score > ScoreManager.high_score:
		ScoreManager.high_score = ScoreManager.current_score
		ScoreManager.save_high_score()

	game_over_ui.show_scores(ScoreManager.current_score, ScoreManager.high_score)
	game_over_ui.visible = true
