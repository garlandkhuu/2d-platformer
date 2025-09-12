extends Node

class_name TempEnemyStateMachine

@export var animation_tree : AnimationTree
@export var current_state : State
@export var previous_state = null
@export var character : Node2D
var states: Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			child.character = character
			#child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning(child.name + " is not a state!")

func _physics_process(delta: float):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	
	current_state.state_process(delta)

func switch_state(new_state: State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()
