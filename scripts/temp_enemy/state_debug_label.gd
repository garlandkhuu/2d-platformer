extends Label

@export var state_machine: TempEnemyStateMachine
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = state_machine.current_state.name
	pass
