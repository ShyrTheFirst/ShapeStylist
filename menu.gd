extends Node2D

var tutorial = preload("res://Scenes/callables/Quick_Tutorial.tscn")
var first_level = preload("res://Scenes/Stages/Client\'s Request.tscn")
onready var start__game = $CanvasLayer/Start_Game
onready var load__game = $CanvasLayer/Load_Game

func _ready():
	GameManager.game_running = false
	GameManager.game_started = true
	start__game.text = LanguageSelector.frases["comecar"]
	load__game.text = LanguageSelector.frases["carregar"]
	
	#Se não tiver save
	#load__game.disabled = true

func _on_Button_pressed():
	get_tree().change_scene_to(tutorial)

func _on_Load_Game_pressed():
	GameManager.load_day()
	get_tree().change_scene_to(first_level)
