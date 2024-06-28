extends Node2D

onready var button = $CanvasLayer/Button
onready var explanation = $CanvasLayer/Panel2/Explanation
onready var right = $CanvasLayer/Panel2/Right
onready var left = $CanvasLayer/Panel2/Left
onready var right_detector = $CanvasLayer/Panel2/Right/Right_detection
onready var left_detector = $CanvasLayer/Panel2/Left/Left_detection
onready var button_focus = $CanvasLayer/Button/Button_focus

onready var sides_1__focus = $CanvasLayer/Panel2/sides1_focus
onready var sides_2__focus = $CanvasLayer/Panel2/sides2_focus
onready var tape_focus = $CanvasLayer/Panel2/tape_focus
onready var help_focus = $CanvasLayer/Panel2/help_focus
onready var area_focus = $CanvasLayer/Panel2/area_focus
onready var num_focus = $CanvasLayer/Panel2/num_focus

var current_phrase
var tutorial_message : int = 0

func _ready():
	button.text = LanguageSelector.frases["botao_proximo"]
	button_focus.visible = false
	button.disabled = true
	
func _process(delta):
	match tutorial_message:
		0: #Nesse estágio começamos os calculos!
			explanation.text = LanguageSelector.frases["tutorial_2_0"]
			current_phrase = "tutorial_2_0"
			left_detector.disabled = true
			left.visible = false
			right_detector.disabled = false
			right.visible = true
			tape_focus.visible = false
		1: #Clique e arraste a fita, para saber as medidas
			explanation.text = LanguageSelector.frases["tutorial_2_1"]
			current_phrase = "tutorial_2_1"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			tape_focus.visible = true
			sides_1__focus.visible = false
			sides_2__focus.visible = false
			
		2: #Com os valores, calcule as areas das formas coloridas
			explanation.text = LanguageSelector.frases["tutorial_2_2"]
			current_phrase = "tutorial_2_2"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			tape_focus.visible = false
			sides_1__focus.visible = true
			sides_2__focus.visible = true
			num_focus.visible = false
			
		3: #Use o teclado do jogo para colocar sua resposta
			explanation.text = LanguageSelector.frases["tutorial_2_3"]
			current_phrase = "tutorial_2_3"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			sides_1__focus.visible = false
			sides_2__focus.visible = false
			num_focus.visible = true
			area_focus.visible = false
			
			
		4: #Sua resposta irá aparecer aqui
			explanation.text = LanguageSelector.frases["tutorial_2_4"]
			current_phrase = "tutorial_2_4"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			num_focus.visible = false
			area_focus.visible = true
			help_focus.visible = false
			
		5: #Caso precise, clique nesse botão para ter ajuda!
			explanation.text = LanguageSelector.frases["tutorial_2_5"]
			current_phrase = "tutorial_2_5"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = false
			right.visible = true
			area_focus.visible = false
			help_focus.visible = true
			button_focus.visible = false
			
		6: #Siga para a ultima parte do tutorial
			explanation.text = LanguageSelector.frases["tutorial_2_6"]
			current_phrase = "tutorial_2_6"
			left_detector.disabled = false
			left.visible = true
			right_detector.disabled = true
			right.visible = false
			help_focus.visible = false
			button.disabled = false
			button_focus.visible = true

func _on_Button_pressed():
	get_tree().change_scene_to(preload("res://Scenes/callables/Quick_Tutorial_3.tscn"))

func _on_TTS_pressed():
	LolApi.send_tts_message(current_phrase)

func _on_Right_detection_pressed():
	tutorial_message += 1

func _on_Left_detection_pressed():
	tutorial_message -= 1
