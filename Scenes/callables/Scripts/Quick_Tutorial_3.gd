 extends Node2D

onready var button = $CanvasLayer/Button

func _ready():
	button.text = LanguageSelector.frases["comecar"]
	

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/Stages/Client\'s Request.tscn"))
