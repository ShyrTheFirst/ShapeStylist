extends Node

var actual_day : int = 0
var last_day : int = 3 #how many clients the day will last
var game_duration : int = 3
var clients_and_days : Dictionary = {}
var clients_total : int = 0
var clients_done : int = 0
var have_client : bool = false

var final_touch : bool = false
var shape_value : int = 0

var last_phrase : bool = false

var goodbye_client : bool = false

var give_up_client : bool = false
var client_losts : int = 0
var total_clients_losts_in_run : int = 0

var daily_profit : int = 0
var weekly_profit : int = 0

var total_clients_in_run : int = 0
var total_mistakes : int = 0

var haveDeco1 : bool = false
var haveDeco2 : bool = false
var haveDeco3 : bool = false

var flor_cor : int = 0 #1,2 ou 3 para cada cor - 0 significa que não existe e está invisivel
var quadro_cor : int = 0
var MD_cor : int = 0

var latest_save : Dictionary
var can_load : bool = false

var pausing : bool = false

var can_change_robot : bool = false

var game_started : bool = false
var game_running : bool = false
var end_of_the_day : bool = false

func _ready():
	_setup_LoL_load_state_message_received()
	LolApi.send_saves_request_message()

func add_client(day, client_num):
	clients_and_days[day] = {client_num : 0}

func add_error(day, client_num, errors_quant):
	total_mistakes += errors_quant
	clients_and_days[day][client_num] += errors_quant

func calculate_results_for_client(day, client_num):
	var result = 10 - clients_and_days[day][client_num]
	return result

func count_errors(day, num):
	return clients_and_days[day][num]

func finish_day():
	actual_day += 1
	total_clients_in_run += clients_total + 1
	clients_total = 0
	shape_value = 0
	total_clients_losts_in_run += client_losts
	client_losts = 0

	var save_data = {
	"actual_day":actual_day,
	"clients_total":clients_total,
	"have_client":have_client,
	"final_touch":final_touch,
	"shape_value":shape_value,
	"last_phrase":last_phrase,
	"goodbye_client":goodbye_client,
	"give_up_client":give_up_client,
	"client_losts":client_losts,
	"total_clients_losts_in_run":total_clients_losts_in_run,
	"daily_profit":daily_profit,
	"weekly_profit":weekly_profit,
	"total_clients_in_run":total_clients_in_run,
	"total_mistakes":total_mistakes,
	"haveDeco1":haveDeco1,
	"haveDeco2":haveDeco2,
	"haveDeco3":haveDeco3,
	"flor_cor":flor_cor,
	"quadro_cor":quadro_cor,
	"MD_cor":MD_cor
	}
	LolApi.send_save_state_message(save_data)

func save_during_game():
	var save_data = {
	"actual_day":actual_day,
	"clients_total":clients_total,
	"have_client":have_client,
	"final_touch":final_touch,
	"shape_value":shape_value,
	"last_phrase":last_phrase,
	"goodbye_client":goodbye_client,
	"give_up_client":give_up_client,
	"client_losts":client_losts,
	"total_clients_losts_in_run":total_clients_losts_in_run,
	"daily_profit":daily_profit,
	"weekly_profit":weekly_profit,
	"total_clients_in_run":total_clients_in_run,
	"total_mistakes":total_mistakes,
	"haveDeco1":haveDeco1,
	"haveDeco2":haveDeco2,
	"haveDeco3":haveDeco3,
	"flor_cor":flor_cor,
	"quadro_cor":quadro_cor,
	"MD_cor":MD_cor
	}
	LolApi.send_save_state_message(save_data)

func load_day():
	if latest_save == {}:
		return
	actual_day = latest_save["actual_day"]
	clients_total = latest_save["clients_total"]
	have_client = latest_save["have_client"]
	final_touch = latest_save["final_touch"]
	shape_value = latest_save["shape_value"]
	last_phrase = latest_save["last_phrase"]
	goodbye_client = latest_save["goodbye_client"]
	give_up_client = latest_save["give_up_client"]
	client_losts = latest_save["client_losts"]
	total_clients_losts_in_run = latest_save["total_clients_losts_in_run"]
	daily_profit = latest_save["daily_profit"]
	weekly_profit = latest_save["weekly_profit"]
	total_clients_in_run = latest_save["total_clients_in_run"]
	total_mistakes = latest_save["total_mistakes"]
	haveDeco1 = latest_save["haveDeco1"]
	haveDeco2 = latest_save["haveDeco2"]
	haveDeco3 = latest_save["haveDeco3"]
	flor_cor = latest_save["flor_cor"]
	quadro_cor = latest_save["quadro_cor"]
	MD_cor = latest_save["MD_cor"]
	
	if actual_day >= game_duration:
		actual_day = 0

func _setup_LoL_load_state_message_received():
	LolApi.connect("load_state_message_received", self, "_process_save_state_Lol_Api")
	LolApi.connect("pause_message_received", self, "_pause_game", [true])
	LolApi.connect("unpause_message_received", self, "_unpause_game", [false])

# Update pause state of the game
func _pause_game(_payload, new_state: bool):
	pausing = new_state
func _unpause_game(_payload, new_state: bool):
	pausing = new_state

func _process_save_state_Lol_Api(payload: Dictionary):
	latest_save = payload.data
	can_load = true
