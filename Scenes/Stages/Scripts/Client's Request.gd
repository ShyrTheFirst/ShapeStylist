extends Node2D

onready var coin = $CanvasLayer/Coin

onready var main__camera = $"Main Camera"

var client_scene = preload("res://Scenes/Clients.tscn")
var final_touch_scene = preload("res://Scenes/Stages/Final Touch.tscn")
var end_day_scene = preload("res://Scenes/Stages/End Of The Day.tscn")
var client_final_scene = preload("res://Scenes/Stages/Client_Final.tscn")
var end_of_the_week = preload("res://Scenes/Stages/End_Of_The_Week.tscn")

onready var frames = $Frames
onready var flowers = $Flowers
onready var table_deco = $TableDeco

var flower1 = preload("res://Assets/deco/flower1.png")
var flower2 = preload("res://Assets/deco/flower2.png")
var flower3 = preload("res://Assets/deco/flower3.png")

var frame1 = preload("res://Assets/deco/frame1.png")
var frame2 = preload("res://Assets/deco/frame2.png")
var frame3 = preload("res://Assets/deco/frame3.png")

var table_deco1 = preload("res://Assets/deco/tabledeco1.png")
var table_deco2 = preload("res://Assets/deco/tabledeco2.png")
var table_deco3 = preload("res://Assets/deco/tabledeco3.png")

var sfx = preload("res://Scenes/callables/sfx_spawner.tscn")
var right = preload("res://Assets/Music and SFX/right_sfx.wav")
var wrong = preload("res://Assets/Music and SFX/wrong_sfx.mp3")
var sad_bot = preload("res://Assets/Music and SFX/Sad synth.wav")

func spawn_sfx(audio):
	var create = sfx.instance()
	create.sfx_to_play = audio
	add_child(create)

func _ready():
	GameManager.game_running = true

func _process(delta):

	if GameManager.haveDeco1:
		flowers.visible = true
		match GameManager.flor_cor: #define qual sprite usar para essa deco
			1:
				flowers.texture = flower1
			2:
				flowers.texture = flower2
			3:
				flowers.texture = flower3
	else:
		flowers.visible = false

	if GameManager.haveDeco2:
		frames.visible = true
		match GameManager.quadro_cor: #define qual sprite usar para essa deco
			1:
				frames.texture = frame1
			2:
				frames.texture = frame2
			3:
				frames.texture = frame3
	else:
		frames.visible = false

	if GameManager.haveDeco3:
		table_deco.visible = true
		match GameManager.MD_cor: #define qual sprite usar para essa deco
			1:
				table_deco.texture = table_deco1
			2:
				table_deco.texture = table_deco2
			3:
				table_deco.texture = table_deco3
	else:
		table_deco.visible = false

	coin.text = str(GameManager.weekly_profit)
	if GameManager.actual_day >= GameManager.game_duration:
		LolApi.send_complete_message()
		var finish_game = end_of_the_week.instance()
		add_child(finish_game)

	if GameManager.clients_total >= GameManager.last_day:
		GameManager.end_of_the_day = true
		GameManager.finish_day()
		day_result()
	else:
		if !GameManager.have_client and !GameManager.end_of_the_day:
			spawn_client()
		if GameManager.final_touch:
			spawn_customization()
		if GameManager.goodbye_client:
			client_result()

func spawn_client():
	GameManager.add_client(GameManager.actual_day, GameManager.clients_total)
	var client_instance = client_scene.instance()
	client_instance.position = Vector2(455,255)
	client_instance.data(GameManager.actual_day, GameManager.clients_total)
	add_child(client_instance)
	GameManager.have_client = true

func spawn_customization():
	var instance_final = final_touch_scene.instance()
	instance_final.position = Vector2(483,308)
	add_child(instance_final)
	GameManager.final_touch = false

func client_result():
	var result = GameManager.calculate_results_for_client(GameManager.actual_day, GameManager.clients_total)
	GameManager.daily_profit += result
	GameManager.weekly_profit += result
	var total_errors = GameManager.count_errors(GameManager.actual_day, GameManager.clients_total)
	var client_final_instance = client_final_scene.instance()
	client_final_instance.get_data(total_errors, result) 
	GameManager.clients_done += 1
	LolApi.send_progress_message(GameManager.clients_done, GameManager.game_duration*GameManager.last_day)
	GameManager.save_during_game()
	add_child(client_final_instance)
	GameManager.goodbye_client = false

func day_result():
	var end_of_day = end_day_scene.instance()
	add_child(end_of_day)
