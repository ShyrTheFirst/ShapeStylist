extends Node2D

onready var valor_receber = $CanvasLayer/Panel/valor_a_receber/valor_receber
onready var valor_erros = $CanvasLayer/Panel/erros_cometidos/valor_erros
onready var valor_perdido = $CanvasLayer/Panel/dinheiro_perdido/valor_perdido
onready var valor_dinheiro = $CanvasLayer/Panel/dinheiro_ganho/valor_dinheiro

onready var valor_a_receber = $CanvasLayer/Panel/valor_a_receber
onready var erros_cometidos = $CanvasLayer/Panel/erros_cometidos
onready var dinheiro_perdido = $CanvasLayer/Panel/dinheiro_perdido
onready var dinheiro_ganho = $CanvasLayer/Panel/dinheiro_ganho

var errors_data : int
var profit_data : int

onready var button = $CanvasLayer/Panel/Button
onready var flowers = $CanvasLayer/Flowers
var flower1 = preload("res://Assets/deco/flower1.png")
var flower2 = preload("res://Assets/deco/flower2.png")
var flower3 = preload("res://Assets/deco/flower3.png")

func get_data(errors, profit):
	errors_data = errors
	profit_data = profit

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

	button.text = LanguageSelector.frases["proximo"]
	valor_erros.text = str(errors_data)
	valor_dinheiro.text = str(profit_data)
	valor_perdido.text = "-" + valor_erros.text
	valor_a_receber.text = LanguageSelector.frases["valor_a_receber"]
	erros_cometidos.text = LanguageSelector.frases["erros_cometidos"]
	dinheiro_perdido.text = LanguageSelector.frases["dinheiro_perdido"]
	dinheiro_ganho.text = LanguageSelector.frases["lucro"]

func _on_Button_pressed():
	GameManager.clients_total += 1
	GameManager.have_client = false
	for node in get_tree().get_nodes_in_group("deletable"):
		node.queue_free()
	queue_free()


func _on_TTS_pressed():
	LolApi.send_tts_message("valor_a_receber")

func _on_TTS2_pressed():
	LolApi.send_tts_message("erros_cometidos")

func _on_TTS3_pressed():
	LolApi.send_tts_message("dinheiro_perdido")

func _on_TTS4_pressed():
	LolApi.send_tts_message("lucro")



