extends CharacterBody2D


const SPEED = 150.0

@onready var anin = get_node("Container/AnimatedSprite2D") 
@onready var container = get_node("Container")
var player: CharacterBody2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity += (player.position - self.position).normalized() * SPEED * delta
	
	if self.position.x > player.position.x:
		anin.play("run")
		container.scale.x = -1
	else:
		anin.play("run")
		container.scale.x = 1

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().get_current_scene().game_over()
