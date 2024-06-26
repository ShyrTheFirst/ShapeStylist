extends Node2D

onready var button = $CanvasLayer/Button

func _ready():
	GameManager.game_started = false
	GameManager.game_running = false
	button.text = LanguageSelector.frases["proximo"]
	

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/callables/Quick_Tutorial_2.tscn"))
