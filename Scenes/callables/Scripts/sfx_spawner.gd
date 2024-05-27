extends AudioStreamPlayer2D

var sfx_to_play

func _ready():
	stream = sfx_to_play
	play()

func _on_AudioStreamPlayer2D_finished():
	queue_free()
