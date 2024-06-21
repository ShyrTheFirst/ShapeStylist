extends Node2D

onready var background_2 = $CanvasLayer/Background2
onready var robot_2 = $CanvasLayer/Robot2
onready var robot_4 = $CanvasLayer/Robot4
onready var metric_tape_2 = $CanvasLayer/MetricTape2
onready var metric_tape_3 = $CanvasLayer/MetricTape3
onready var shape_2 = $CanvasLayer/Shape2
onready var robot_6 = $CanvasLayer/Robot6

onready var button = $CanvasLayer/Button

func _ready():
	GameManager.game_started = false
	GameManager.game_running = false
	button.text = LanguageSelector.frases["comecar"]
	background_2.text = LanguageSelector.frases["fundo_jogo"]
	robot_2.text = LanguageSelector.frases["apresentacao"]
	robot_4.text = LanguageSelector.frases["instrucao_inicial"]
	metric_tape_2.text = LanguageSelector.frases["explicacao_fita"]
	metric_tape_3.text = LanguageSelector.frases["validando_etapa"]
	shape_2.text = LanguageSelector.frases["calcular_area"]
	robot_6.text = LanguageSelector.frases["estilizar"]
	

func _on_Button_pressed(): #Start
	get_tree().change_scene_to(preload("res://Scenes/Stages/Client\'s Request.tscn"))
