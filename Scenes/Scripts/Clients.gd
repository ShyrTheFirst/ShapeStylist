extends Node2D


var client_num : int
var client_day : int

onready var give_up_countdown = $GiveUpCountdown

onready var haircut_image = $Haircut1/HaircutImage

onready var congratz_effect = $Head_items/CongratzEffect
onready var finished_anim = $Head_items/Finished_anim
onready var helper = $Head_items/Helper

onready var robot_animation = $Robot_animation

onready var haircut_1 = $Haircut1
onready var label = $Label
onready var head__camera = $"Head Camera"
onready var hair_equation = preload("res://Scenes/Stages/HairEquations.tscn")
onready var shape_mouse_detection = $Head_items/mouse_detection/shape_mouse_detection

onready var head_items = $Head_items
onready var width = $Head_items/width
onready var height = $Head_items/height
onready var width_label = $"Head_items/width/width label"
onready var height_label = $"Head_items/height/height label"
onready var area_label = $"Head_items/area label"

var choosen_label = width_label

var visibility_check : bool = true
var start_conversation : bool = false

var text_screen_time : float = 0.0
var text_time_limit : float= 3.0
var next_message : bool = false

var last_text : float = 0.0
var next_stage : bool = false
var last_stage : bool = false
 
var count : int = 0
onready var nome : String
onready var gosto : String
onready var dialogue_list

var random_choosing : int
var mouse_inside : bool = false
var head_height : int = 0
var head_width : int = 0 
var head_area : int = 0

var sfx = preload("res://Scenes/callables/sfx_spawner.tscn")
var right = preload("res://Assets/Music and SFX/right_sfx.wav")
var wrong = preload("res://Assets/Music and SFX/wrong_sfx.mp3")
var sad_bot = preload("res://Assets/Music and SFX/Sad bot.wav")
var sad_synth = preload("res://Assets/Music and SFX/Sad synth.wav")

var head_robot = preload("res://Assets/robot_with_head.png")
var headless_robot = preload("res://Assets/robot_without_head.png")

func spawn_sfx(audio):
	var create = sfx.instance()
	create.sfx_to_play = audio
	add_child(create)

func data(num,day):
	client_num = num
	client_day = day

func _ready():
	randomize()
	var nome_list = [LanguageSelector.frases["possibilidade_nomes"], LanguageSelector.frases["possibilidade_nomes2"],LanguageSelector.frases["possibilidade_nomes3"],LanguageSelector.frases["possibilidade_nomes4"],LanguageSelector.frases["possibilidade_nomes5"],LanguageSelector.frases["possibilidade_nomes6"],LanguageSelector.frases["possibilidade_nomes7"],LanguageSelector.frases["possibilidade_nomes8"],LanguageSelector.frases["possibilidade_nomes9"],LanguageSelector.frases["possibilidade_nomes10"],LanguageSelector.frases["possibilidade_nomes11"],LanguageSelector.frases["possibilidade_nomes12"]]
	var gostos_list = [LanguageSelector.frases["possibilidade_gostos"],LanguageSelector.frases["possibilidade_gostos2"],LanguageSelector.frases["possibilidade_gostos3"],LanguageSelector.frases["possibilidade_gostos4"],LanguageSelector.frases["possibilidade_gostos5"]]
	nome = LanguageSelector.frases["frase_1"] + nome_list[round(randi() % nome_list.size())]
	gosto = LanguageSelector.frases["frase_2"] + gostos_list[round(randi() % gostos_list.size())]
	dialogue_list = [nome, gosto, LanguageSelector.frases["frase_3"]] 

	random_choosing = round(randi() % 2)
	head_height = round(randi() % 10 + 1)
	head_width = round(randi() % 10 + 1)
	head_area = head_height * head_width

	label.text = LanguageSelector.frases["saudacao"]
	width.add_point(Vector2(-100,-130))
	height.add_point(Vector2(-100,-130))
	haircut_1.modulate.r = randf()
	haircut_1.modulate.g = randf()
	haircut_1.modulate.b = randf()

func _process(delta):
	if GameManager.can_change_robot:
		haircut_1.texture = headless_robot
	else:
		haircut_1.texture = head_robot

	if GameManager.give_up_client:
		give_up()
		GameManager.give_up_client = false

	if GameManager.goodbye_client:
		queue_free()

	if visibility_check:
		if haircut_1.modulate.a < 1:
			haircut_1.modulate.a += delta
			label.modulate.a = haircut_1.modulate.a
		else:
			robot_animation.play("Greetings")
			start_conversation = true
			visibility_check = false

	if start_conversation:
			conversation_time(delta)

	if next_stage :
		shape_mouse_detection.disabled = false
		head_calculate(delta)

	if last_stage:
		haircut_image.visible = false
		shape_mouse_detection.disabled = true
		calculate_the_area()

	if GameManager.last_phrase:
		label.visible = true
		var ultima_frase_list = [LanguageSelector.frases["ultima_frase"],LanguageSelector.frases["ultima_frase2"],LanguageSelector.frases["ultima_frase3"],LanguageSelector.frases["ultima_frase4"],LanguageSelector.frases["ultima_frase5"],LanguageSelector.frases["ultima_frase6"]]
		label.text = ultima_frase_list[round(randi() % ultima_frase_list.size())]
		GameManager.last_phrase = false

func conversation_time(delta):
	#play robot sound every time a new message appear ####################################################
	if text_screen_time <= text_time_limit:
		text_screen_time += delta
	elif text_screen_time > text_time_limit:
		spawn_sfx(sad_synth)
		next_message = true
		text_screen_time = 0.0
		
	if next_message == true:
		robot_animation.play("Talking")
		if count < dialogue_list.size():
			spawn_sfx(sad_synth)
			label.text = dialogue_list[count]
			count += 1
			next_message = false
		if count >= dialogue_list.size():
			haircut_image.visible = true
			if !haircut_image.rect_position >= Vector2 (-138,80):
				haircut_image.rect_position += Vector2 (0,10)
			if last_text <= text_time_limit:
				last_text += delta
			else:
				start_conversation = false
				next_stage = true

func head_calculate(delta):
	head_items.visible = true
	head__camera.current = true
	haircut_1.modulate.a = 0.9
	label.visible = false
	
	if random_choosing == 0:
		height_label.text = str(head_height)
		area_label.text = str(head_area)
		width_transform()
		height_selected(head_height)
	else:
		width_label.text = str(head_width)
		area_label.text = str(head_area)
		height_transform()
		width_selected(head_width)

func calculate_the_area():
	head__camera.current = false
	get_parent().main__camera.current = true
	var hair_cut = hair_equation.instance()
	hair_cut.data(client_day, client_num)
	get_parent().add_child(hair_cut)
	last_stage = false

func height_transform():
	var choosen_side = height
	choosen_label = height_label
	var choosen_position = get_local_mouse_position().y
	if Input.is_action_pressed("MouseClick") and mouse_inside:
		if choosen_position < -130:
			if choosen_position >= -135 and choosen_position < -130:
				choosen_label.text = "1"
				choosen_side.set_point_position(1, Vector2(-100, -135))

			elif choosen_position >= -140 and choosen_position < -135:
				choosen_label.text = "2"
				choosen_side.set_point_position(1, Vector2(-100, -140))

			elif choosen_position >= -145 and choosen_position < -140:
				choosen_label.text = "3"
				choosen_side.set_point_position(1, Vector2(-100, -145))

			elif choosen_position >= -150 and choosen_position < -145:
				choosen_label.text = "4"
				choosen_side.set_point_position(1, Vector2(-100, -150))

			elif choosen_position >= -155 and choosen_position < -150:
				choosen_label.text = "5"
				choosen_side.set_point_position(1, Vector2(-100, -155))

			elif choosen_position >= -160 and choosen_position < -155:
				choosen_label.text = "6"
				choosen_side.set_point_position(1, Vector2(-100, -160))

			elif choosen_position >= -165 and choosen_position < -160:
				choosen_label.text = "7"
				choosen_side.set_point_position(1, Vector2(-100, -165))

			elif choosen_position >= -170 and choosen_position < -165:
				choosen_label.text = "8"
				choosen_side.set_point_position(1, Vector2(-100, -170))

			elif choosen_position >=-175 and choosen_position < -170:
				choosen_label.text = "9"
				choosen_side.set_point_position(1, Vector2(-100, -175))

			elif choosen_position >= -180 and choosen_position < -175:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(-100, -180))

			else:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(-100, -180))

	if Input.is_action_just_released("MouseClick") and mouse_inside:
		mouse_inside = false
		if choosen_position < -130:
			if choosen_position >= -135 and choosen_position < -130:
				choosen_label.text = "1"
				choosen_side.set_point_position(1, Vector2(-100, -135))

			elif choosen_position >= -140 and choosen_position < -135:
				choosen_label.text = "2"
				choosen_side.set_point_position(1, Vector2(-100, -140))

			elif choosen_position >= -145 and choosen_position < -140:
				choosen_label.text = "3"
				choosen_side.set_point_position(1, Vector2(-100, -145))

			elif choosen_position >= -150 and choosen_position < -145:
				choosen_label.text = "4"
				choosen_side.set_point_position(1, Vector2(-100, -150))

			elif choosen_position >= -155 and choosen_position < -150:
				choosen_label.text = "5"
				choosen_side.set_point_position(1, Vector2(-100, -155))

			elif choosen_position >= -160 and choosen_position < -155:
				choosen_label.text = "6"
				choosen_side.set_point_position(1, Vector2(-100, -160))

			elif choosen_position >= -165 and choosen_position < -160:
				choosen_label.text = "7"
				choosen_side.set_point_position(1, Vector2(-100, -165))

			elif choosen_position >= -170 and choosen_position < -165:
				choosen_label.text = "8"
				choosen_side.set_point_position(1, Vector2(-100, -170))

			elif choosen_position >=-175 and choosen_position < -170:
				choosen_label.text = "9"
				choosen_side.set_point_position(1, Vector2(-100, -175))

			elif choosen_position >= -180 and choosen_position < -175:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(-100, -180))

			else:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(-100, -180))
		else:
			choosen_label.text = "0"
			choosen_side.set_point_position(1, Vector2(-100,-130))

func width_transform():
	var choosen_side = width
	choosen_label = width_label
	var choosen_position = get_local_mouse_position().x

	if Input.is_action_pressed("MouseClick") and mouse_inside:
		if not choosen_position < -100:
			if choosen_position >= -100 and choosen_position < -80:
				choosen_label.text = "1"
				choosen_side.set_point_position(1, Vector2(-80, -130))

			elif choosen_position >= -80 and choosen_position < -60:
				choosen_label.text = "2"
				choosen_side.set_point_position(1, Vector2(-60, -130))

			elif choosen_position >= -60 and choosen_position < -40:
				choosen_label.text = "3"
				choosen_side.set_point_position(1, Vector2(-40, -130))

			elif choosen_position >= -40 and choosen_position < -20:
				choosen_label.text = "4"
				choosen_side.set_point_position(1, Vector2(-20, -130))

			elif choosen_position >= -20 and choosen_position < 0:
				choosen_label.text = "5"
				choosen_side.set_point_position(1, Vector2(0, -130))

			elif choosen_position >= 0 and choosen_position < 20:
				choosen_label.text = "6"
				choosen_side.set_point_position(1, Vector2(20, -130))

			elif choosen_position >= 20 and choosen_position < 40:
				choosen_label.text = "7"
				choosen_side.set_point_position(1, Vector2(40, -130))

			elif choosen_position >= 40 and choosen_position < 60:
				choosen_label.text = "8"
				choosen_side.set_point_position(1, Vector2(60, -130))

			elif choosen_position >= 60 and choosen_position < 80:
				choosen_label.text = "9"
				choosen_side.set_point_position(1, Vector2(80, -130))

			elif choosen_position >= 80 and choosen_position < 100:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(100, -130))

			else:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(100, -130))

	if Input.is_action_just_released("MouseClick") and mouse_inside:
		mouse_inside = false
		if not choosen_position < -100:
			if choosen_position >= -100 and choosen_position < -80:
				choosen_label.text = "1"
				choosen_side.set_point_position(1, Vector2(-80, -130))

			elif choosen_position >= -80 and choosen_position < -60:
				choosen_label.text = "2"
				choosen_side.set_point_position(1, Vector2(-60, -130))

			elif choosen_position >= -60 and choosen_position < -40:
				choosen_label.text = "3"
				choosen_side.set_point_position(1, Vector2(-40, -130))

			elif choosen_position >= -40 and choosen_position < -20:
				choosen_label.text = "4"
				choosen_side.set_point_position(1, Vector2(-20, -130))

			elif choosen_position >= -20 and choosen_position < 0:
				choosen_label.text = "5"
				choosen_side.set_point_position(1, Vector2(0, -130))

			elif choosen_position >= 0 and choosen_position < 20:
				choosen_label.text = "6"
				choosen_side.set_point_position(1, Vector2(20, -130))

			elif choosen_position >= 20 and choosen_position < 40:
				choosen_label.text = "7"
				choosen_side.set_point_position(1, Vector2(40, -130))

			elif choosen_position >= 40 and choosen_position < 60:
				choosen_label.text = "8"
				choosen_side.set_point_position(1, Vector2(60, -130))

			elif choosen_position >= 60 and choosen_position < 80:
				choosen_label.text = "9"
				choosen_side.set_point_position(1, Vector2(80, -130))

			elif choosen_position >= 80 and choosen_position < 100:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(100, -130))

			else:
				choosen_label.text = "10"
				choosen_side.set_point_position(1, Vector2(100, -130))
		else:
			choosen_label.text = "0"
			choosen_side.set_point_position(1, Vector2(-100,-130))

func height_selected(value : int):
	var choosen_side = height
	match value:
		1:
			choosen_side.set_point_position(1, Vector2(-100, -135))
		2:
			choosen_side.set_point_position(1, Vector2(-100, -140))
		3:
			choosen_side.set_point_position(1, Vector2(-100, -145))
		4:
			choosen_side.set_point_position(1, Vector2(-100, -150))
		5:
			choosen_side.set_point_position(1, Vector2(-100, -155))
		6:
			choosen_side.set_point_position(1, Vector2(-100, -160))
		7:
			choosen_side.set_point_position(1, Vector2(-100, -165))
		8:
			choosen_side.set_point_position(1, Vector2(-100, -170))
		9:
			choosen_side.set_point_position(1, Vector2(-100, -175))
		10:
			choosen_side.set_point_position(1, Vector2(-100, -180))

func width_selected(value : int):
	var choosen_side = width
	match value:
		1:
			choosen_side.set_point_position(1, Vector2(-80, -130))
		2:
			choosen_side.set_point_position(1, Vector2(-60, -130))
		3:
			choosen_side.set_point_position(1, Vector2(-40, -130))
		4:
			choosen_side.set_point_position(1, Vector2(-20, -130))
		5:
			choosen_side.set_point_position(1, Vector2(0, -130))
		6:
			choosen_side.set_point_position(1, Vector2(20, -130))
		7:
			choosen_side.set_point_position(1, Vector2(40, -130))
		8:
			choosen_side.set_point_position(1, Vector2(60, -130))
		9:
			choosen_side.set_point_position(1, Vector2(80, -130))
		10:
			choosen_side.set_point_position(1, Vector2(100, -130))

func _on_ConfirmAnswer_pressed():
	match choosen_label:
		height_label:
			if int(height_label.text) == head_height:
				$Head_items/ConfirmAnswer.disabled = true
				$Head_items/Popup_message.visible = true
				$Head_items/Popup_message.play_anim()
				spawn_sfx(right)
				congratz_effect.emitting = true
				finished_anim.start()
			else:
				if GameManager.count_errors(client_day, client_num) >= 4:
					spawn_sfx(wrong)
					next_stage = false
					give_up()
				else:
					spawn_sfx(wrong)
					GameManager.add_error(client_day, client_num, 1)
					helper.visible = true

		width_label:
			if int(width_label.text) == head_width:
				$Head_items/ConfirmAnswer.disabled = true
				$Head_items/Popup_message.visible = true
				$Head_items/Popup_message.play_anim()
				spawn_sfx(right)
				congratz_effect.emitting = true
				finished_anim.start()
			else:
				spawn_sfx(wrong)
				if GameManager.count_errors(client_day, client_num) >= 4:
					next_stage = false
					give_up()
				else:
					GameManager.add_error(client_day, client_num, 1)
					helper.visible = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	mouse_inside = true

func _on_Finished_anim_timeout():
	last_stage = true
	next_stage = false
	head_items.visible = false
	haircut_1.modulate.a = 1.0

func give_up():
	head__camera.current = false
	get_parent().main__camera.current = true
	label.visible = true
	head_items.visible = false
	spawn_sfx(sad_synth)
	label.text = LanguageSelector.frases["desistir"]
	give_up_countdown.start()

func _on_GiveUpCountdown_timeout():
	GameManager.have_client = false
	queue_free()
	
