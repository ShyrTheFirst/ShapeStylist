extends Node2D

onready var canvas_layer = $CanvasLayer
onready var warning = $CanvasLayer/Button/Warning

onready var warning_label = $CanvasLayer/Button/Warning/WarningLabel #Ajustar os textos
onready var message_label = $CanvasLayer/Button/Warning/MessageLabel
onready var continue_label = $CanvasLayer/Button/Warning/ContinueLabel
onready var audio_stream = $AudioStreamPlayer2D
var Music_playing : bool = false


var slider_open : bool = false
onready var h_slider = $CanvasLayer/HSlider

func _ready():
	pass
	warning_label.text = LanguageSelector.frases["aviso"]
	message_label.text = LanguageSelector.frases["aviso_mensagem"]
	continue_label.text = LanguageSelector.frases["continuar"]

func _process(delta):
	if GameManager.game_started:
		if Music_playing == false:
			audio_stream.play()
			Music_playing = true
		
	if GameManager.pausing:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	if GameManager.game_running:
		canvas_layer.visible = true
	else:
		canvas_layer.visible = false

func _on_Button_pressed():
	get_tree().paused = true
	warning.visible = true

func _on_Volume_pressed():
	if !slider_open:
		h_slider.visible = true
		slider_open = true
	else:
		h_slider.visible = false
		slider_open = false


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_Y_pressed():
	GameManager.game_running = false
	GameManager.game_started = true
	warning.visible = false
	get_tree().change_scene_to(load("res://menu.tscn"))

func _on_N_pressed():
	get_tree().paused = false
	warning.visible = false
