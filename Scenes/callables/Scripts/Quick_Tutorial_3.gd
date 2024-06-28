 extends Node2D

onready var button = $CanvasLayer/Button
onready var right = $CanvasLayer/Panel2/Right
onready var left = $CanvasLayer/Panel2/Left
onready var right_detector = $CanvasLayer/Panel2/Right/Right_detection
onready var left_detector = $CanvasLayer/Panel2/Left/Left_detection
onready var button_focus = $CanvasLayer/Button/Button_focus
onready var explanation = $CanvasLayer/Panel2/Explanation
onready var sides_1__focus = $CanvasLayer/Panel2/sides1_focus
onready var sides_2__focus = $CanvasLayer/Panel2/sides2_focus
onready var help_focus = $CanvasLayer/Panel2/help_focus
onready var area_focus = $CanvasLayer/Panel2/area_focus

var current_phrase
var tutorial_message : int = 0

func _ready():
	button.text = LanguageSelector.frases["comecar"]
	button.disabled = true
	
func _process(delta):
	match tutorial_message:
		0: #Mais um pouco de calculos nesse estágio
			explanation.text = LanguageSelector.frases["tutorial_3_0"]
			current_phrase = "tutorial_3_0"
			left_detector.disabled = true
			left.visible = false
			right_detector.disabled = false
			right.visible = true
			sides_1__focus.visible = false
			sides_2__focus.visible = false
			
		1: #As medidas já estão aqui, só precisa calcular!
			explanation.text = LanguageSelector.frases["tutorial_3_1"]
			current_phrase = "tutorial_3_1"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			sides_1__focus.visible = true
			sides_2__focus.visible = true
			area_focus.visible = false
			
		2: #Aqui funciona igual o estagio anterior, coloque sua resposta com o teclado
			explanation.text = LanguageSelector.frases["tutorial_3_2"]
			current_phrase = "tutorial_3_2"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			sides_1__focus.visible = false
			sides_2__focus.visible = false
			area_focus.visible = true
			help_focus.visible = false
			
		3: #E se precisar de ajuda, o botão fica aqui
			explanation.text = LanguageSelector.frases["tutorial_2_3"]
			current_phrase = "tutorial_2_3"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			area_focus.visible = false
			help_focus.visible = true
			
		4: #O proximo estágio você só precisa ser criativo, e ai você terá finalizado o cliente!
			explanation.text = LanguageSelector.frases["tutorial_3_4"]
			current_phrase = "tutorial_3_4"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			help_focus.visible = false
			button_focus.visible = false
			
		5: #Agora vá e descubra o restante do jogo. Boa sorte e boa diversão!
			explanation.text = LanguageSelector.frases["tutorial_3_5"]
			current_phrase = "tutorial_3_5"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = true
			right.visible = false
			button.disabled = false
			button_focus.visible = true

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/Stages/Client\'s Request.tscn"))

func _on_TTS_pressed():
	LolApi.send_tts_message(current_phrase)

func _on_Right_detection_pressed():
	tutorial_message += 1

func _on_Left_detection_pressed():
	tutorial_message -= 1
