extends Node2D

var movespeed = 60
var direction = -1
var timer_start = 0
var rng = RandomNumberGenerator.new()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_attack: RayCast2D = $RayCastAttack
@onready var player: CharacterBody2D = $"../Player"
@onready var attack_timer: Timer = $AttackTimer
@onready var ray_cast_col: RayCast2D = $RayCastCol
@onready var enemy_bound_left: StaticBody2D = $"../EnemyBoundLeft"
@onready var enemy_bound_right: StaticBody2D = $"../EnemyBoundRight"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: TempEnemyStateMachine = $TempEnemyStateMachine

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	position.x += movespeed * delta * direction
	
	if (ray_cast_col.is_colliding() && (ray_cast_col.get_collider() == enemy_bound_left) || ray_cast_col.get_collider() == enemy_bound_right):
		change_movement()
	update_animation()

func change_movement():
	sprite_2d.flip_h = !sprite_2d.flip_h
	ray_cast_attack.target_position *= -1
	ray_cast_col.target_position *= -1
	direction *= -1

func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction)

func _on_attack_timer_timeout():
	#animated_sprite_2d.play("default")
	movespeed = 60.0
