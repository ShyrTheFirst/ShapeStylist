extends Node2D

onready var canvas_layer = $CanvasLayer

func _process(delta):
	if GameManager.pausing:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	if GameManager.game_started or GameManager.game_running:
		canvas_layer.visible = true
	else:
		canvas_layer.visible = false
