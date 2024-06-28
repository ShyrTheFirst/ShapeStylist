extends Node2D

onready var total_geral = $CanvasLayer/Panel2/Total_geral
onready var valor_total = $CanvasLayer/Panel2/Total_geral/valor_total

onready var erros_feitos = $CanvasLayer/Panel2/Erros_feitos
onready var quant_erros = $CanvasLayer/Panel2/Erros_feitos/quant_erros

onready var clientes_satisfeitos = $CanvasLayer/Panel2/Clientes_satisfeitos
onready var num_clientes = $CanvasLayer/Panel2/Clientes_satisfeitos/num_clientes

onready var clientes_insatisfeitos_2 = $CanvasLayer/Panel2/Clientes_insatisfeitos2
onready var num_clientes_2 = $CanvasLayer/Panel2/Clientes_insatisfeitos2/num_clientes2

onready var button = $CanvasLayer/Panel2/Button

onready var flowers = $CanvasLayer/Flowers
var flower1 = preload("res://Assets/deco/flower1.png")
var flower2 = preload("res://Assets/deco/flower2.png")
var flower3 = preload("res://Assets/deco/flower3.png")

func _ready():
	if GameManager.haveDeco1:
		flowers.visible = true
		match GameManager.flor_cor: #define qual sprite usar para essa deco
			1:
				flowers.texture = flower1
			2:
				flowers.texture = flower2
			3:
				flowers.texture = flower3

	button.text = LanguageSelector.frases["menu"]

	total_geral.text = LanguageSelector.frases["dinheiro_total"]
	valor_total.text = str(GameManager.weekly_profit)

	erros_feitos.text = LanguageSelector.frases["erros"]
	quant_erros.text = str(GameManager.total_mistakes)

	clientes_satisfeitos.text = LanguageSelector.frases["satisfeitos"]
	num_clientes.text = str(GameManager.total_clients_in_run)

	clientes_insatisfeitos_2.text = LanguageSelector.frases["insatisfeitos"]
	num_clientes_2.text = str(GameManager.total_clients_losts_in_run)

func _on_Button_pressed():
	get_tree().change_scene_to(load("res://menu.tscn"))

func _on_TTS_pressed():
	LolApi.send_tts_message("dinheiro_total")

func _on_TTS2_pressed():
	LolApi.send_tts_message("erros")

func _on_TTS3_pressed():
	LolApi.send_tts_message("satisfeitos")

func _on_TTS4_pressed():
	LolApi.send_tts_message("insatisfeitos")
