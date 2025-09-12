extends State

class_name GuardState

var timer = 0
var cooldown = 0

@export var attack_state : State

func on_enter():
	character.movespeed = 60
	cooldown = 60

func state_process(delta):
	if found():
		next_state = attack_state
	cooldown -= 1
	
func found() -> bool:
		if (character.ray_cast_attack.is_colliding() && (cooldown <= 0) && character.ray_cast_attack.get_collider() == character.player):
			return true
		else:
			return false
	
