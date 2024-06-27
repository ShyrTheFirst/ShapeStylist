extends Control

var client_day : int
var client_num : int 

onready var helper = $Helper

onready var final_timer = $FinalTimer

var final_touch_scene = preload("res://Scenes/Stages/Final Touch.tscn")

onready var size_container = $SizeContainer
onready var sides_container = $SidesContainer
var ordened_values : Array
var area_result : float

onready var wrong_result = $Result/result_answer/WrongResult
onready var wrong_unit = $Result/unit_answer/WrongUnit

var unit_type : String = "cm"
onready var result = $Result

var toggle_helper : bool = true

onready var side_size = $Sprite/Side_size
onready var side_size_2 = $Sprite/Side_size2
onready var side_size_3 = $Sprite/Side_size3
onready var side_size_4 = $Sprite/Side_size4
onready var side_size_5 = $Sprite/Side_size5
onready var side_size_6 = $Sprite/Side_size6
onready var side_size_7 = $Sprite/Side_size7

var texture_0 = preload("res://Assets/shapes/shape_0c.png")
var texture_0_size_quant : int = 2
var texture_1 = preload("res://Assets/shapes/shape_01c.png")
var texture_1_size_quant : int = 6
var texture_2 = preload("res://Assets/shapes/shape_02c.png")
var texture_2_size_quant : int = 3
var texture_3 = preload("res://Assets/shapes/shape_03c.png")
var texture_3_size_quant : int = 6
var texture_4 = preload("res://Assets/shapes/shape_04c.png")
var texture_4_size_quant : int = 6
var texture_5 = preload("res://Assets/shapes/shape_05c.png")
var texture_5_size_quant : int = 7

var texture_list : Array = [texture_0, texture_1, texture_2, texture_3, texture_4, texture_5]

var size_quant_list : Array = [texture_0_size_quant, texture_1_size_quant, texture_2_size_quant, 
texture_3_size_quant, texture_4_size_quant, texture_5_size_quant]

onready var sprite = $Sprite

onready var result_answer = $Result/result_answer
onready var unit_answer = $Result/unit_answer
var player_chose_unit : String = "empty"

func data(day, num):
	client_day = day
	client_num = num

func _ready():
	side_size.visible = false
	side_size_2.visible = false
	side_size_3.visible = false
	side_size_4.visible = false
	side_size_5.visible = false
	side_size_6.visible = false
	side_size_7.visible = false

	randomize()
	
	result.text = LanguageSelector.frases["texto_resultado"]
	result_answer.placeholder_text = LanguageSelector.frases["placeholder_resposta"]
	unit_answer.placeholder_text = LanguageSelector.frases["placeholder_unidade"]

	var random_unit = int(rand_range(0,2))
	if random_unit == 0:
		unit_type = "cm"
	else:
		unit_type = "in"

	var random_value = randi() % 5

	var pick_random_texture = int(rand_range(0,(texture_list.size()-1)))
	if GameManager.first_run:
		pick_random_texture = 0

	sprite.texture = texture_list[pick_random_texture]

	match pick_random_texture:
		0:
			GameManager.shape_value = 0
			side_size.visible = true
			side_size.rect_position = Vector2(-193,-32)
			side_size.text = str(4 * random_value) + unit_type

			side_size_2.visible = true
			side_size_2.rect_position = Vector2(-32, -192)
			side_size_2.text = str(4 * random_value) + unit_type

			area_result = (4* random_value) * (4* random_value)

		1:
			GameManager.shape_value = 1
			side_size.visible = true
			side_size.rect_position = Vector2(-64,-182)
			side_size.text = str(2 * random_value) + unit_type
			
			side_size_2.visible = true
			side_size_2.rect_position = Vector2(21,-107)
			side_size_2.text = str(2 * random_value) + unit_type
			
			side_size_3.visible = true
			side_size_3.rect_position = Vector2(42,-32)
			side_size_3.text = str(2 * random_value) + unit_type
			
			side_size_4.visible = true
			side_size_4.rect_position = Vector2(128,10)
			side_size_4.text = str(1 * random_value) + unit_type
			
			side_size_5.visible = true
			side_size_5.rect_position = Vector2(-21, 75)
			side_size_5.text = str(4 * random_value) + unit_type
			
			side_size_6.visible = true
			side_size_6.rect_position = Vector2(-193,0)
			side_size_6.text = str(2 * random_value) + unit_type
			area_result = (((2 * random_value) * (2 * random_value)) /2 ) + ((2 * random_value) * (1 * random_value)) + (((4 * random_value)-(2 * random_value)) * (2 * random_value))

		2:
			GameManager.shape_value = 2
			side_size.visible = true
			side_size.rect_position = Vector2(-193,0)
			side_size.text = str(4 * random_value) + unit_type
			
			side_size_2.visible = true
			side_size_2.rect_position = Vector2(-32,-192)
			side_size_2.text = str(2 * random_value) + unit_type
			
			side_size_3.visible = true
			side_size_3.rect_position = Vector2(64,-107)
			side_size_3.text = str(2 * random_value) + unit_type
			
			side_size_4.visible = true
			side_size_4.rect_position = Vector2(128,0)
			side_size_4.text = str(1 * random_value) + unit_type
			
			side_size_5.visible = true
			side_size_5.rect_position = Vector2(32,160)
			side_size_5.text = str(2 * random_value) + unit_type
			
			side_size_6.visible = true
			side_size_6.rect_position = Vector2(-107,160)
			side_size_6.text = str(1* random_value) + unit_type
			area_result = (((4 * random_value) - (2 * random_value)) * (1 * random_value)) + (((4* random_value) - (2 * random_value)) * (2 * random_value)) + ((2 * random_value) * (2 * random_value))

		3:
			GameManager.shape_value = 3
			side_size.visible = true
			side_size.rect_position = Vector2(-193,-42)
			side_size.text = str(4 * random_value) + unit_type
			
			side_size_2.visible = true
			side_size_2.rect_position = Vector2(-53,-192)
			side_size_2.text = str(2 * random_value) + unit_type
			
			side_size_3.visible = true
			side_size_3.rect_position = Vector2(64,-107)
			side_size_3.text = str(2 * random_value) + unit_type
			area_result = ((2 * random_value) * (2 * random_value)) + ((((4 * random_value) - (2 * random_value)) *  (2 * random_value))/2)

		4:
			GameManager.shape_value = 4
			side_size.visible = true
			side_size.rect_position = Vector2(-195,-107)
			side_size.text = str(2 * random_value) + unit_type
			
			side_size_2.visible = true
			side_size_2.rect_position = Vector2(-53,-192)
			side_size_2.text = str(3 * random_value) + unit_type
			
			side_size_3.visible = true
			side_size_3.rect_position = Vector2(75,-150)
			side_size_3.text = str(0.5 * random_value) + unit_type
			
			side_size_4.visible = true
			side_size_4.rect_position = Vector2(150,-107)
			side_size_4.text = str(0.5 * random_value) + unit_type
			
			side_size_5.visible = true
			side_size_5.rect_position = Vector2(0,53)
			side_size_5.text = str(1 * random_value) + unit_type
			
			side_size_6.visible = true
			side_size_6.rect_position = Vector2(-97,-10)
			side_size_6.text = str(1* random_value) + unit_type
			area_result = ((2 * random_value) * (3 * random_value)) + ((0.5 * random_value) * (0.5 * random_value)) + ((1 * random_value)*(1 * random_value))

		5:
			GameManager.shape_value = 5
			side_size.visible = true
			side_size.rect_position = Vector2(-195,64)
			side_size.text = str(2 * random_value) + unit_type
			
			side_size_2.visible = true
			side_size_2.rect_position = Vector2(-195,-75)
			side_size_2.text = str(2 * random_value) + unit_type
			
			side_size_3.visible = true
			side_size_3.rect_position = Vector2(-150,-128)
			side_size_3.text = str(1 * random_value) + unit_type
			
			side_size_4.visible = true
			side_size_4.rect_position = Vector2(-75,-128)
			side_size_4.text = str(3 * random_value) + unit_type
			
			side_size_5.visible = true
			side_size_5.rect_position = Vector2(10,-128)
			side_size_5.text = str(2 * random_value) + unit_type
			
			side_size_6.visible = true
			side_size_6.rect_position = Vector2(85,-42)
			side_size_6.text = str(4 * random_value) + unit_type
			
			side_size_7.visible = true
			side_size_7.rect_position = Vector2(85,42)
			side_size_7.text = str(3 * random_value) + unit_type
			area_result = ((1 * random_value) + (3 * random_value) + (2 * random_value)) * ((4 * random_value) + (3 * random_value))

func _process(delta):
	if rect_scale <= Vector2(1,1):
		rect_scale += Vector2(delta,delta)

func _on_Check_Amswer_pressed():
	wrong_result.visible = false
	wrong_unit.visible = false
	if int(result_answer.text) == int(area_result) and player_chose_unit == unit_type:
		$"Result/Check Amswer".disabled = true
		$Popup_message.visible = true
		$Popup_message.play_anim()
		final_timer.start()
	else:
		if GameManager.count_errors(client_day, client_num) >= 4:
			GameManager.give_up_client = true
			queue_free()
		GameManager.add_error(client_day, client_num, 1)
		if GameManager.count_errors(client_day, client_num) > 1:
			helper.visible = true

		if int(result_answer.text) != int(area_result) and unit_answer.text != player_chose_unit:
			helper.visible = true
			wrong_result.visible = true
			wrong_unit.visible = true

		elif int(result_answer.text) != int(area_result) and unit_answer.text == player_chose_unit:
			helper.visible = true
			wrong_result.visible = true
			wrong_unit.visible = false

		elif unit_answer.text != player_chose_unit and int(result_answer.text) == int(area_result):
			helper.visible = true
			wrong_unit.visible = true
			wrong_result.visible = false

func _on_cm_pressed():
	player_chose_unit = "cm"
	unit_answer.text = "cm²"

func _on_inch_pressed():
	player_chose_unit = "in"
	unit_answer.text = "in²"

func _on_1_pressed():
	result_answer.text += "1"

func _on_2_pressed():
	result_answer.text += "2"

func _on_3_pressed():
	result_answer.text += "3"

func _on_4_pressed():
	result_answer.text += "4"

func _on_5_pressed():
	result_answer.text += "5"

func _on_6_pressed():
	result_answer.text += "6"

func _on_7_pressed():
	result_answer.text += "7"

func _on_8_pressed():
	result_answer.text += "8"

func _on_9_pressed():
	result_answer.text += "9"

func _on_0_pressed():
	result_answer.text += "0"

func _on_backspace_pressed():
	if result_answer.text != "":
		var letter_quantity : int = -1
		for letter in result_answer.text:
			letter_quantity += 1
		result_answer.delete_text(letter_quantity, letter_quantity+1)
		result_answer.text = result_answer.text

func _on_FinalTimer_timeout():
	GameManager.final_touch = true
	queue_free()

func _on_Help_pressed():
	if toggle_helper:
		helper.visible = true
		toggle_helper = false
	else:
		helper.visible = false
		toggle_helper = true
