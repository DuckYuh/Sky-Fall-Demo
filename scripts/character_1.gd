extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var anin = get_node("Container/AnimatedSprite2D") 
@onready var container = get_node("Container")
@onready var attack_area = get_node("AttackArea") 

var is_attacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("Attack") and is_on_floor():
		anin.play("attack")
		is_attacking = true
		velocity.x = 0
		attack_mods_in_area()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and not is_attacking:
		velocity.x = direction * SPEED
		container.scale.x = direction
		attack_area.scale.x = direction
	elif not is_attacking:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_attacking:
		if not is_on_floor():
			anin.play("jump")
		elif direction:
			anin.play("run")
		else:
			anin.play("idle")

	move_and_slide()

func attack_mods_in_area():
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):  # Đảm bảo mob có group này
			body.queue_free()
			get_tree().get_root().get_node("Play").add_score(1)

func _on_animated_sprite_2d_animation_finished():
	if anin.animation == "attack":
		is_attacking = false
