extends State

class_name AttackState

var movespeed = 150.0
var timer = 0

@export var attackLen = 100
@export var guard_state : State

func state_process(delta):
	if (timer > attackLen):
		timer = 0
		next_state = guard_state
		pass
	timer += 1
	
func on_enter():
	character.movespeed = 150
	
