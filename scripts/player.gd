extends CharacterBody2D


const SPEED = 300.0
@export var JUMP_VELOCITY : float = -300.0

@onready var interactable = $interactable
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2 = Vector2.ZERO
var animation_locked : bool = false
var was_in_air : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		if was_in_air == true:
			land()
			
		was_in_air = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#checks the collectable area and pressing interact key to collect it
	#collectable area is slightly larger than hurtbox because it feels better to play
	for area in interactable.get_overlapping_areas():
		if (area.has_method("collect") && Input.is_action_just_pressed("interact")):
			area.collect()
	
	
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Flip the Sprite
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
	
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	update_animation()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	if not animation_locked:
		if not is_on_floor():
			pass
		else:
			if direction.x != 0:
				pass
			else:
				pass

func jump():
	velocity.y = JUMP_VELOCITY
	animation_player.play("jump")
	
func land():
	animation_player.play("idle")
