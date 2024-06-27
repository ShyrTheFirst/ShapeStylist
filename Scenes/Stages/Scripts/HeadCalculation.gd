extends Node2D

onready var robot_with_head = $RobotWithHead
onready var sprite_2 = $mouse_detection/Sprite2
onready var sprite_3 = $Helper/Sprite3
onready var tip = $Helper/Tip
onready var end_stage = $EndStage
onready var popup_message = $Popup_message
onready var animation_player = $Popup_message/AnimationPlayer

onready var collision_polygon_2d = $RobotWithHead/CollisionPolygon2D
var vectors1 : PoolVector2Array
var vectors2 : PoolVector2Array
var vectors3 : PoolVector2Array
var vectors4 : PoolVector2Array
var vectors5 : PoolVector2Array

var canClick : bool = false
var clicked : bool = false

var random_size : float = 0.0

var moving_right : bool = false
var moving_left : bool = false
onready var right = $mouse_detection/Right
onready var left = $mouse_detection/Left
onready var left__line = $mouse_detection/Left_Line
onready var right__line = $mouse_detection/Right_Line
var left_value : float = 0.0
onready var left_value_text = $mouse_detection/Left_Line/left_value
var right_value : float = 0.0
onready var right_value_text = $mouse_detection/Right_Line/right_value

onready var answer_text = $Answer_text
onready var result_answer = $Answer_text/result_answer
onready var unit_answer = $Answer_text/unit_answer

var unit_type : String = "cm"

var numbers_result : Array = []
var result : float = 0.0
var result_array : Array = []

onready var wrong_unit = $Answer_text/unit_answer/WrongUnit
onready var wrong_result = $Answer_text/result_answer/WrongResult

var client_day

var client_num

func data(day, num):
	client_day = day
	client_num = num

func _ready():
	robot_with_head.modulate.r = GameManager.color_robot_r
	robot_with_head.modulate.g = GameManager.color_robot_g
	robot_with_head.modulate.b = GameManager.color_robot_b

	randomize()
	if !GameManager.first_run:
		random_size = randi() % 2+1 + randf()
		random_size = stepify(random_size, 0.5)
	else:
		random_size = 1.0

	vectors1 = [Vector2(150,245), Vector2(847,390), Vector2(847,245)]
	vectors2 = [Vector2(150,245), Vector2(847,390), Vector2(150,390)]
	vectors3 = [Vector2(847,245), Vector2(596,146), Vector2(596,245)]
	vectors4 = [Vector2(150,145), Vector2(596,245), Vector2(596,146)]
	vectors5 = [Vector2(150,145), Vector2(596,245), Vector2(150,245)]
	
	#calcular result aqui!
	#(2*medida do quadrado) * (5*medida do quadrado)/2 = Area triangulo amarelo (1)
	#(3 * medida do quadrado) * (14 * medida do quadrado) = Area do quadrado azul (2)
	#(2* medida do quadrado) * (9* medida do quadrado) = Area do quadrado vermelho (3)
	var area1 = ((2 * random_size) * (5 * random_size)) / 2
	var area2 = (3 * random_size) * (14 * random_size)
	var area3 = (2 * random_size) * (9 * random_size)
	result = area1 + area2 + area3
	print(result)
	for i in str(result):
		if i != ".":
			result_array.append(int(i))
		else:
			result_array.append(i)

	answer_text.text = LanguageSelector.frases["texto_resultado"]
	result_answer.placeholder_text = LanguageSelector.frases["placeholder_resposta"]
	unit_answer.placeholder_text = LanguageSelector.frases["placeholder_unidade"]

	var random_unit = int(rand_range(0,2))
	if random_unit == 0:
		unit_type = "cm"
	else:
		unit_type = "in"

func _draw():
	var color1 = Color(0.2,0.6,0.6,0.5)
	var color2 = Color(0.6,0.6,0.2,0.5)
	var color3 = Color(0.9,0.2,0.2,0.5)
	draw_colored_polygon(vectors1, color1)
	draw_colored_polygon(vectors2, color1)
	draw_colored_polygon(vectors3, color2)
	draw_colored_polygon(vectors4, color3)
	draw_colored_polygon(vectors5, color3)

func _process(delta):
	if clicked:
		if moving_left:
			if get_global_mouse_position().y <= 388 and get_global_mouse_position().y > 348:
				left__line.points[1].y = -12
				left_value = 0 *random_size
			if get_global_mouse_position().y <= 348 and get_global_mouse_position().y > 298:
				left__line.points[1].y = -25
				left_value = 1 *random_size
			if get_global_mouse_position().y <= 298 and get_global_mouse_position().y > 248:
				left__line.points[1].y = -37
				left_value = 2 * random_size
			if get_global_mouse_position().y <= 248 and get_global_mouse_position().y > 198:
				left__line.points[1].y = -49
				left_value = 3 *random_size
			if get_global_mouse_position().y <= 198 and get_global_mouse_position().y > 148:
				left__line.points[1].y = -61
				left_value = 4 *random_size
			if get_global_mouse_position().y <= 148:
				left__line.points[1].y = -73
				left_value = 5 *random_size

		if moving_right:
			if get_global_mouse_position().x >= 168 and get_global_mouse_position().x < 200:
				right__line.points[1].x = 11
				right_value = 0 *random_size
			if get_global_mouse_position().x >= 200 and get_global_mouse_position().x < 250:
				right__line.points[1].x = 19
				right_value = 1 *random_size
			if get_global_mouse_position().x >= 250 and get_global_mouse_position().x < 300:
				right__line.points[1].x = 31
				right_value = 2 *random_size
			if get_global_mouse_position().x >= 300 and get_global_mouse_position().x < 350:
				right__line.points[1].x = 44
				right_value = 3 *random_size
			if get_global_mouse_position().x >= 350 and get_global_mouse_position().x < 400:
				right__line.points[1].x = 56
				right_value = 4 *random_size
			if get_global_mouse_position().x >= 400 and get_global_mouse_position().x < 450:
				right__line.points[1].x = 69
				right_value = 5 *random_size
			if get_global_mouse_position().x >= 450 and get_global_mouse_position().x < 500:
				right__line.points[1].x = 81
				right_value = 6 *random_size
			if get_global_mouse_position().x >= 500 and get_global_mouse_position().x < 550:
				right__line.points[1].x = 94
				right_value = 7 *random_size
			if get_global_mouse_position().x >= 550 and get_global_mouse_position().x < 600:
				right__line.points[1].x = 106
				right_value = 8 *random_size
			if get_global_mouse_position().x >= 600 and get_global_mouse_position().x < 650:
				right__line.points[1].x = 119
				right_value = 9 *random_size
			if get_global_mouse_position().x >= 650 and get_global_mouse_position().x < 700:
				right__line.points[1].x = 131
				right_value = 10 *random_size
			if get_global_mouse_position().x >= 700 and get_global_mouse_position().x < 750:
				right__line.points[1].x = 143
				right_value = 11 *random_size
			if get_global_mouse_position().x >= 750 and get_global_mouse_position().x < 800:
				right__line.points[1].x = 156
				right_value = 12 *random_size
			if get_global_mouse_position().x >= 800 and get_global_mouse_position().x < 850:
				right__line.points[1].x = 169
				right_value = 13 *random_size
			if get_global_mouse_position().x >= 850:
				right__line.points[1].x = 181
				right_value = 14 *random_size
	
	left_value_text.text = str(left_value) + unit_type
	right_value_text.text = str(right_value) + unit_type
	
	if Input.is_action_just_pressed("MouseClick"):
		if canClick:
			clicked = true
			sprite_2.visible = false

	if Input.is_action_just_released("MouseClick"):
		clicked = false

func _on_mouse_detection_mouse_entered():
	canClick = true

func _on_mouse_detection_mouse_exited():
	canClick = false
	if !clicked:
		moving_right = false
		moving_left = false

func _on_Right_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		moving_right = true
		moving_left = false

func _on_Left_click_detection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		moving_right = false
		moving_left = true

func _on_comma_pressed():
	result_answer.text += ","
	numbers_result.append(".")

func _on_backspace_pressed():
	if result_answer.text != "":
		var letter_quantity : int = -1
		for letter in result_answer.text:
			letter_quantity += 1
		result_answer.delete_text(letter_quantity, letter_quantity+1)
		result_answer.text = result_answer.text
		numbers_result.pop_back()

func _on_inch_pressed():
	unit_answer.text = "in²"

func _on_cm_pressed():
	unit_answer.text = "cm²"

func _on_0_pressed():
	result_answer.text += "0"
	numbers_result.append(0)

func _on_9_pressed():
	result_answer.text += "9"
	numbers_result.append(9)

func _on_8_pressed():
	result_answer.text += "8"
	numbers_result.append(8)

func _on_7_pressed():
	result_answer.text += "7"
	numbers_result.append(7)

func _on_6_pressed():
	result_answer.text += "6"
	numbers_result.append(6)

func _on_5_pressed():
	result_answer.text += "5"
	numbers_result.append(5)

func _on_4_pressed():
	result_answer.text += "4"
	numbers_result.append(4)

func _on_3_pressed():
	result_answer.text += "3"
	numbers_result.append(3)

func _on_2_pressed():
	result_answer.text += "2"
	numbers_result.append(2)

func _on_1_pressed():
	result_answer.text += "1"
	numbers_result.append(1)

func _on_Button_pressed():
	sprite_3.visible = false
	wrong_unit.visible = false
	wrong_result.visible = false

	if numbers_result == result_array and (unit_type + "²") == unit_answer.text :
		popup_message.visible = true
		animation_player.play("popup")
		end_stage.start()
	else:
		if GameManager.count_errors(client_day, client_num) >= 4:
			GameManager.give_up_client = true
			queue_free()
		GameManager.add_error(client_day, client_num, 1)

	if numbers_result == result_array and (unit_type + "²") != unit_answer.text:
		sprite_3.visible = true
		wrong_unit.visible = true

	elif numbers_result != result_array and (unit_type + "²") == unit_answer.text:
		sprite_3.visible = true
		wrong_result.visible = true

	elif numbers_result != result_array and (unit_type + "²") != unit_answer.text:
		sprite_3.visible = true
		wrong_result.visible = true
		wrong_unit.visible = true

func _on_Helper_pressed():
	if tip.visible:
		tip.visible = false
	else:
		tip.visible = true

func _on_EndStage_timeout():
	GameManager.head_calculation_handler = false
	queue_free()


func _on_TTS_pressed():
	LolApi.send_tts_message("texto_resultado")
