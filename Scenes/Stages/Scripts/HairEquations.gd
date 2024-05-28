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

onready var size_1 = $SizeContainer/Size1
onready var size_2 = $SizeContainer/Size2
onready var size_3 = $SizeContainer/Size3
onready var size_4 = $SizeContainer/Size4
onready var size_5 = $SizeContainer/Size5
onready var size_6 = $SizeContainer/Size6
onready var size_7 = $SizeContainer/Size7
onready var size_8 = $SizeContainer/Size8
onready var size_9 = $SizeContainer/Size9
onready var size_10 = $SizeContainer/Size10

onready var side_1 = $SidesContainer/side1
onready var side_2 = $SidesContainer/side2
onready var side_3 = $SidesContainer/side3
onready var side_4 = $SidesContainer/side4
onready var side_5 = $SidesContainer/side5
onready var side_6 = $SidesContainer/side6
onready var side_7 = $SidesContainer/side7
onready var side_8 = $SidesContainer/side8
onready var side_9 = $SidesContainer/side9
onready var side_10 = $SidesContainer/side10


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
	randomize()
	result.text = LanguageSelector.frases["texto_resultado"]
	side_1.text = LanguageSelector.frases["label_lados"] + "1"
	side_2.text = LanguageSelector.frases["label_lados"] + "2"
	side_3.text = LanguageSelector.frases["label_lados"] + "3"
	side_4.text = LanguageSelector.frases["label_lados"] + "4"
	side_5.text = LanguageSelector.frases["label_lados"] + "5"
	side_6.text = LanguageSelector.frases["label_lados"] + "6"
	side_7.text = LanguageSelector.frases["label_lados"] + "7"
	side_8.text = LanguageSelector.frases["label_lados"] + "8"
	side_9.text = LanguageSelector.frases["label_lados"] + "9"
	side_10.text = LanguageSelector.frases["label_lados"] + "10"
	result_answer.placeholder_text = LanguageSelector.frases["placeholder_resposta"]
	unit_answer.placeholder_text = LanguageSelector.frases["placeholder_unidade"]

	var random_unit = int(rand_range(0,2))
	if random_unit == 0:
		unit_type = "cm"
	else:
		unit_type = "in"

	var pick_random_texture = int(rand_range(0,(texture_list.size()-1)))
	sprite.texture = texture_list[pick_random_texture]

	for n in range(size_quant_list[pick_random_texture]):
		size_container.get_children()[n].visible = true
		var new_value = randi() % 10+1
		ordened_values.append(new_value)
		size_container.get_children()[n].text = str(new_value) + unit_type
		sides_container.get_children()[n].visible = true
	
	match pick_random_texture:
		0:
			GameManager.shape_value = 0
			area_result = ordened_values[0] * ordened_values[1]

		1:
			GameManager.shape_value = 1
			if ordened_values[4] <= ordened_values[2]:
				ordened_values[4] += ordened_values[2]
				size_5.text = str(ordened_values[4]) + unit_type
			area_result = floor(((ordened_values[0] * ordened_values[1])/2) + (ordened_values[2] * ordened_values[3]) + ((ordened_values[4] - ordened_values[2]) * ordened_values[5]))

		2:
			GameManager.shape_value = 2
			if ordened_values[2] <= ordened_values[1]:
				ordened_values[2] += ordened_values[1]
				size_3.text = str(ordened_values[2]) + unit_type
			area_result = floor(ordened_values[0] * ordened_values[1] + (((ordened_values[2]-ordened_values[1]) * ordened_values[0])/2))

		3:
			GameManager.shape_value = 3
			if ordened_values[5] <= (ordened_values[2] + ordened_values[1]):
				ordened_values[5] += ordened_values[2] + ordened_values[1]
				size_6.text = str(ordened_values[5]) + unit_type
			area_result = ordened_values[0] * ordened_values[1] + ordened_values[2] * ordened_values[3] + (ordened_values[5]-ordened_values[1]-ordened_values[2])*ordened_values[3] + ordened_values[4] * (ordened_values[5] - ordened_values[1])

		4:
			GameManager.shape_value = 4
			area_result = ordened_values[0] * ordened_values[1] + ordened_values[2] * ordened_values[3] + ordened_values[4] * ordened_values[5]

		5:
			if ordened_values[5] <=  ordened_values[6]:
				ordened_values[5] += ordened_values[6]
				size_6.text = str(ordened_values[5]) + unit_type
			GameManager.shape_value = 5
			area_result = ordened_values[0] * ordened_values[1] + ordened_values[2]* ordened_values[1] + ordened_values[3] * ordened_values[4] + (ordened_values[0]+ordened_values[2]+ordened_values[3]) * ordened_values[6] + (ordened_values[5] - ordened_values[6]) *ordened_values[3]


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
		$CongratzEffect.emitting = true
		final_timer.start()
	else:
		if GameManager.count_errors(client_day, client_num) >= 4:
			GameManager.give_up_client = true
			queue_free()
		GameManager.add_error(client_day, client_num, 1)
		if GameManager.count_errors(client_day, client_num) > 1:
			helper.visible = true

		if int(result_answer.text) != int(area_result) and unit_answer.text != player_chose_unit:
			wrong_result.visible = true
			wrong_unit.visible = true

		elif int(result_answer.text) != int(area_result) and unit_answer.text == player_chose_unit:
			wrong_result.visible = true

		elif unit_answer.text != player_chose_unit and int(result_answer.text) == int(area_result):
			wrong_unit.visible = true

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
