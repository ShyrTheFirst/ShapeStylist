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

func _ready():
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
