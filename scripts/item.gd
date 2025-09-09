extends Area2D

#frees the item from scene
func collect():
	queue_free()
	AudioController.play_usb() #play audio from global audio controller
	
