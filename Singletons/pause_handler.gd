extends Node2D

onready var canvas_layer = $CanvasLayer

var slider_open : bool = false
onready var h_slider = $CanvasLayer/HSlider

func _process(delta):
	if GameManager.pausing:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	if GameManager.game_started or GameManager.game_running:
		canvas_layer.visible = true
	else:
		canvas_layer.visible = false

func _on_Button_pressed():
	GameManager.save_during_game()
	GameManager.game_running = false
	GameManager.game_started = true
	get_tree().change_scene_to(load("res://menu.tscn"))

func _on_Volume_pressed():
	if !slider_open:
		h_slider.visible = true
		slider_open = true
	else:
		h_slider.visible = false
		slider_open = false


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
