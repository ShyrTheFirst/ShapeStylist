extends Node2D

onready var button = $CanvasLayer/Button
onready var button_focus = $CanvasLayer/Button/Button_focus
onready var money__line = $CanvasLayer/Panel2/Money_Line
onready var button__line = $CanvasLayer/Panel2/Button_Line
onready var money_explain = $CanvasLayer/Panel2/Money_LIne/Money_explain
onready var button_explain = $CanvasLayer/Panel2/Button_Line/Button_explain
onready var explanation = $CanvasLayer/Panel2/Explanation

var current_phrase : String

var tutorial_message : int = 0

onready var right_detector = $CanvasLayer/Panel2/Right_click_detection/CollisionPolygon2D
onready var left_detector = $CanvasLayer/Panel2/left_click_detection/CollisionPolygon2D
onready var right = $CanvasLayer/Panel2/Right
onready var left = $CanvasLayer/Panel2/Left


func _ready():
	GameManager.game_started = false
	GameManager.game_running = false
	button.text = LanguageSelector.frases["proximo"]
	money_explain.text = LanguageSelector.frases[""] #Frase sobre o money, frase fixa
	button_explain.text = LanguageSelector.frases[""] #Frase sobre os botoes, frase fixa

func _process(delta):
	match tutorial_message:
		0:
			explanation.text = LanguageSelector.frases[""] #primeira parte do tutorial
			current_phrase = "" #string da frase acima
			left_detector.disabled = true
			left.visible = false
			right_detector.disabled = false
			right.visible = true
			money__line.visible = false
			button__line.visible = false
		1:
			pass
			money__line.visible = false#####
			button__line.visible = false####
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
		2:
			pass

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/callables/Quick_Tutorial_2.tscn"))

func _on_TTS_pressed():
	LolApi.send_tts_message(current_phrase)

func _on_Right_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		tutorial_message += 1

func _on_TTS_button_pressed():
	LolApi.send_tts_message("")

func _on_TTS_money_pressed():
	LolApi.send_tts_message("")


func _on_left_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		tutorial_message -= 1
