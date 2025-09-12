extends Node

class_name State

@export var can_move: bool = true
var next_state : State
var character: Node2D

func state_process(delta):
	pass

func on_enter():
	pass

func on_exit():
	pass
