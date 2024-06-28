extends Node2D

onready var button = $CanvasLayer/Button
onready var button_focus = $CanvasLayer/Button/Button_focus
onready var money__line = $CanvasLayer/Panel2/Money_Line
onready var button__line = $CanvasLayer/Panel2/Button_Line
onready var explanation = $CanvasLayer/Panel2/Explanation

var current_phrase : String

var tutorial_message : int = 0

onready var right_detector = $CanvasLayer/Panel2/Right/Right_detection
onready var left_detector = $CanvasLayer/Panel2/Left/Left_detection
onready var right = $CanvasLayer/Panel2/Right
onready var left = $CanvasLayer/Panel2/Left


func _ready():
	button_focus.visible = false
	GameManager.game_started = false
	GameManager.game_running = false
	button.text = LanguageSelector.frases["botao_proximo"]
	button.disabled = true

func _process(delta):
	match tutorial_message:
		0:
			explanation.text = LanguageSelector.frases["tutorial_1_0"] #primeira parte do tutorial
			current_phrase = "tutorial_1_0" #string da frase acima
			left.visible = false
			right_detector.disabled = false
			right.visible = true
			money__line.visible = false
			button__line.visible = false
		1: #Essa é a tela principal /n Aqui que você receberá seus clientes
			explanation.text = LanguageSelector.frases["tutorial_1_1"]
			current_phrase = "tutorial_1_1"
			money__line.visible = false
			button__line.visible = false
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
		2: #Esse icone acima é o seu dinheiro /n Você poderá gasta-lo ao final do dia
			explanation.text = LanguageSelector.frases["tutorial_1_2"]
			current_phrase = "tutorial_1_2"
			money__line.visible = true
			button__line.visible = false
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
		3: #Caso queira voltar ao menu, use o botão abaixo /n esse outro é para ajustar o volume
			explanation.text = LanguageSelector.frases["tutorial_1_3"]
			current_phrase = "tutorial_1_3"
			money__line.visible = false
			button__line.visible = true
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			button_focus.visible = false
		4: #Clique em próximo para continuar o tutorial /n Ou volte para revisar
			explanation.text = LanguageSelector.frases["tutorial_1_4"]
			current_phrase = "tutorial_1_4"
			money__line.visible = false
			button__line.visible = false
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = true
			right.visible = false
			button.disabled = false
			button_focus.visible = true

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/callables/Quick_Tutorial_2.tscn"))

func _on_TTS_pressed():
	LolApi.send_tts_message(current_phrase)

func _on_Right_detection_pressed():
	tutorial_message += 1

func _on_Left_detection_pressed():
	tutorial_message -= 1
