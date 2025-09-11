extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var interactable = $interactable

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#checks the collectable area and pressing interact key to collect it
	#collectable area is slightly larger than hurtbox because it feels better to play
	for area in interactable.get_overlapping_areas():
		if (area.has_method("collect") && Input.is_action_just_pressed("interact")):
			area.collect()
	
	var playerSprite = $PlayerSprite
	
	# Flip the Sprite
	if direction > 0:
		playerSprite.flip_h = true
	elif direction < 0:
		playerSprite.flip_h = false
	# Play animationsa
	if direction == 0:
		playerSprite.play("idle")
	else:
		playerSprite.play("run")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
