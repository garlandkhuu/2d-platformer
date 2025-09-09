extends Node2D

@export var mute: bool = false

# ready can be used for music
func _ready() -> void: pass
	

# collect sound of usb
func play_usb():
	if !mute:
		$item_usb.play()
