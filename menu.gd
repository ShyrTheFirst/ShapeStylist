extends Node2D

var tutorial = preload("res://Scenes/callables/Quick_Tutorial.tscn")
var first_level = preload("res://Scenes/Stages/Client\'s Request.tscn")
onready var start__game = $CanvasLayer/Start_Game
onready var load__game = $CanvasLayer/Load_Game
onready var start__shader = $CanvasLayer/Start_Shader
onready var load__shader = $CanvasLayer/Load_Shader

func _ready():
	GameManager.game_running = false
	GameManager.game_started = true
	start__game.text = LanguageSelector.frases["comecar"]
	load__game.text = LanguageSelector.frases["carregar"]
	start__shader.text = LanguageSelector.frases["comecar"]
	load__shader.text = LanguageSelector.frases["carregar"]
	
	load__game.disabled = !GameManager.can_load

func _on_Button_pressed():
	GameManager.start_over()
	get_tree().change_scene_to(tutorial)

func _on_Load_Game_pressed():
	GameManager.load_day()
	get_tree().change_scene_to(first_level)


func _on_TTS_pressed():
	LolApi.send_tts_message("Game_name")
