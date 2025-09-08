extends Node2D

var movespeed = 60.0
var direction = -1
var timer_start = 0
var rng = RandomNumberGenerator.new()
var attack_state = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_attack: RayCast2D = $RayCastAttack
@onready var player: CharacterBody2D = $"../Player"
@onready var attack_timer: Timer = $AttackTimer
@onready var ray_cast_col: RayCast2D = $RayCastCol
@onready var enemy_bound_left: StaticBody2D = $"../EnemyBoundLeft"
@onready var enemy_bound_right: StaticBody2D = $"../EnemyBoundRight"

func _physics_process(delta):
	position.x += movespeed * delta * direction
	
	if (ray_cast_col.is_colliding() && (ray_cast_col.get_collider() == enemy_bound_left) || ray_cast_col.get_collider() == enemy_bound_right):
		change_movement()
	check_attack()

func change_movement():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	ray_cast_attack.target_position *= -1
	ray_cast_col.target_position *= -1
	direction *= -1

func check_attack():
	if (ray_cast_attack.is_colliding() && attack_state && ray_cast_attack.get_collider() == player): 
		attack_state = !attack_state
		attack_timer.start()
		animated_sprite_2d.play("attack")
		movespeed = 150.0

func _on_attack_timer_timeout():
	attack_state = !attack_state
	animated_sprite_2d.play("default")
	movespeed = 60.0
