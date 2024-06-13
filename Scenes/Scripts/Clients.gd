extends Node2D


var client_num : int
var client_day : int

onready var give_up_countdown = $GiveUpCountdown

onready var haircut_image = $Haircut1/HaircutImage

onready var robot_animation = $Robot_animation

onready var haircut_1 = $Haircut1
onready var label = $Label
onready var hair_equation = preload("res://Scenes/Stages/HairEquations.tscn")

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

	label.text = LanguageSelector.frases["saudacao"]
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
		head_calculate(delta)

	if last_stage:
		haircut_image.visible = false
		calculate_the_area()

	if GameManager.last_phrase:
		label.visible = true
		var ultima_frase_list = [LanguageSelector.frases["ultima_frase"],LanguageSelector.frases["ultima_frase2"],LanguageSelector.frases["ultima_frase3"],LanguageSelector.frases["ultima_frase4"],LanguageSelector.frases["ultima_frase5"],LanguageSelector.frases["ultima_frase6"]]
		label.text = ultima_frase_list[round(randi() % ultima_frase_list.size())]
		GameManager.last_phrase = false

func conversation_time(delta):
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
	pass #criar aqui o chamado pra HeadCalculation
	#ao fim, preciso chamar da seguinte forma:
	#last_stage = true
	#next_stage = false

func calculate_the_area():
	var hair_cut = hair_equation.instance()
	hair_cut.data(client_day, client_num)
	get_parent().add_child(hair_cut)
	last_stage = false

func give_up():
	label.visible = true
	spawn_sfx(sad_synth)
	label.text = LanguageSelector.frases["desistir"]
	give_up_countdown.start()

func _on_GiveUpCountdown_timeout():
	GameManager.have_client = false
	queue_free()
	
