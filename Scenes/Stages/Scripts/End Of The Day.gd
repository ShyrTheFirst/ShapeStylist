extends Node2D

onready var dinheiro_ganho = $CanvasLayer/Panel/dinheiro_ganho
onready var valor_gasto = $CanvasLayer/Panel/valor_gasto
onready var lucro = $CanvasLayer/Panel/lucro

onready var valor_ganho = $CanvasLayer/Panel/dinheiro_ganho/valor_ganho
onready var quant_valor_gasto = $CanvasLayer/Panel/valor_gasto/quant_valor_gasto
onready var valor_lucro = $CanvasLayer/Panel/lucro/valor_lucro

onready var button = $CanvasLayer/Panel/Button

onready var actual_money = $CanvasLayer/Panel/Actual_Money

onready var buy_deco = $CanvasLayer/Panel/BuyDeco
onready var buy_deco_2 = $CanvasLayer/Panel/BuyDeco2
onready var buy_deco_3 = $CanvasLayer/Panel/BuyDeco3

onready var flor_cor_1 = $CanvasLayer/Panel/GridContainer/DecoFlores/FlorCor1
onready var flor_cor_2 = $CanvasLayer/Panel/GridContainer/DecoFlores2/FlorCor2
onready var flor_cor_3 = $CanvasLayer/Panel/GridContainer/DecoFlores3/FlorCor3

onready var quadro_cor_1 = $CanvasLayer/Panel/GridContainer/DecoQuadros/QuadroCor1
onready var quadro_cor_2 = $CanvasLayer/Panel/GridContainer/DecoQuadros2/QuadroCor2
onready var quadro_cor_3 = $CanvasLayer/Panel/GridContainer/DecoQuadros3/QuadroCor3

onready var md_cor_1 = $CanvasLayer/Panel/GridContainer/MesaDeco/MDCor1
onready var md_cor_2 = $CanvasLayer/Panel/GridContainer/MesaDeco2/MDCor2
onready var md_cor_3 = $CanvasLayer/Panel/GridContainer/MesaDeco3/MDCor3

onready var selected_flor = $CanvasLayer/Panel/SelectedFlor
onready var selected_quadro = $CanvasLayer/Panel/SelectedQuadro
onready var selected_md = $CanvasLayer/Panel/SelectedMD



func _ready():
	button.text = LanguageSelector.frases["proximo_dia"]
	dinheiro_ganho.text = LanguageSelector.frases["dinheiro_fim_do_dia"]
	valor_gasto.text = LanguageSelector.frases["despesas"]
	lucro.text = LanguageSelector.frases["lucro"]
	valor_ganho.text = str(GameManager.daily_profit)
	valor_lucro.text = str(GameManager.daily_profit - 20)
	GameManager.weekly_profit -= 20
	
func _process(delta):
	actual_money.text = str(GameManager.weekly_profit)
	if GameManager.haveDeco1:
		selected_flor.visible = true
		flor_cor_1.disabled = false
		flor_cor_2.disabled = false
		flor_cor_3.disabled = false
	else:
		selected_flor.visible = false
		flor_cor_1.disabled = true
		flor_cor_2.disabled = true
		flor_cor_3.disabled = true
	
	if GameManager.haveDeco2:
		selected_quadro.visible = true
		quadro_cor_1.disabled = false
		quadro_cor_2.disabled = false
		quadro_cor_3.disabled = false
	else:
		selected_quadro.visible = false
		quadro_cor_1.disabled = true
		quadro_cor_2.disabled = true
		quadro_cor_3.disabled = true
	
	if GameManager.haveDeco3:
		selected_md.visible = true
		md_cor_1.disabled = false
		md_cor_2.disabled = false
		md_cor_3.disabled = false
	else:
		selected_md.visible = false
		md_cor_1.disabled = true
		md_cor_2.disabled = true
		md_cor_3.disabled = true

	if !GameManager.haveDeco1 and GameManager.weekly_profit > 2: #deco1 = flores
		buy_deco.disabled = false
	else:
		buy_deco.disabled = true

	if !GameManager.haveDeco2 and GameManager.weekly_profit > 3: #deco2 = quadros
		buy_deco_2.disabled = false
	else:
		buy_deco_2.disabled = true

	if !GameManager.haveDeco3 and GameManager.weekly_profit > 10: #deco3 = Mesa
		buy_deco_3.disabled = false
	else:
		buy_deco_3.disabled = true

	match GameManager.flor_cor:
		1:
			selected_flor.rect_position = Vector2(596,116)
		2:
			selected_flor.rect_position = Vector2(746,116)
		3:
			selected_flor.rect_position = Vector2(896,116)
	
	match GameManager.quadro_cor:
		1:
			selected_quadro.rect_position = Vector2(596,267)
		2:
			selected_quadro.rect_position = Vector2(746,267)
		3:
			selected_quadro.rect_position = Vector2(896,267)
	
	match GameManager.MD_cor:
		1:
			selected_md.rect_position = Vector2(596,416)
		2:
			selected_md.rect_position = Vector2(746,416)
		3:
			selected_md.rect_position = Vector2(896,416)

func _on_Button_pressed():
	GameManager.daily_profit = 0
	GameManager.end_of_the_day = false
	queue_free()

func _on_BuyDeco_pressed():
	GameManager.haveDeco1 = true
	GameManager.weekly_profit -= 2

func _on_BuyDeco2_pressed():
	GameManager.haveDeco2 = true
	GameManager.weekly_profit -= 3

func _on_BuyDeco3_pressed():
	GameManager.haveDeco3 = true
	GameManager.weekly_profit -= 10

func _on_FlorCor1_pressed():
	flor_cor_2.pressed = false
	flor_cor_3.pressed = false
	GameManager.flor_cor = 1

func _on_FlorCor2_pressed():
	flor_cor_1.pressed = false
	flor_cor_3.pressed = false
	GameManager.flor_cor = 2

func _on_FlorCor3_pressed():
	flor_cor_1.pressed = false
	flor_cor_2.pressed = false
	GameManager.flor_cor = 3

func _on_QuadroCor1_pressed():
	quadro_cor_2.pressed = false
	quadro_cor_3.pressed = false
	GameManager.quadro_cor = 1

func _on_QuadroCor2_pressed():
	quadro_cor_1.pressed = false
	quadro_cor_3.pressed = false
	GameManager.quadro_cor = 2

func _on_QuadroCor3_pressed():
	quadro_cor_2.pressed = false
	quadro_cor_1.pressed = false
	GameManager.quadro_cor = 3

func _on_MDCor1_pressed():
	md_cor_2.pressed = false
	md_cor_3.pressed = false
	GameManager.MD_cor = 1

func _on_MDCor2_pressed():
	md_cor_1.pressed = false
	md_cor_3.pressed = false
	GameManager.MD_cor = 2

func _on_MDCor3_pressed():
	md_cor_2.pressed = false
	md_cor_1.pressed = false
	GameManager.MD_cor = 3
