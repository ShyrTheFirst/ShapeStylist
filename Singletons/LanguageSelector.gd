extends Node


var game_language : String = "en"

var frases : Dictionary = {"acerto":"Excelent!","altura":"height","apresentacao":"This is \n your client","area":"area","calcular_area":"Then, calculate the haircut area","carregar":"Load Game","comecar":"Start Game","desistir":"I think you can't help me","despesas":"Expenses","dinheiro_fim_do_dia":"Earned money","dinheiro_perdido":"Money lost","dinheiro_total":"All time earned","erros":"Mistakes","erros_cometidos":"Mistakes made","estilizar":"Lastly, give the robot some style!","explicacao_fita":"Drag the metric tape \n to calculate","frase_1":"My name is ","frase_2":"I like ","frase_3":"This is the haircut I want","fundo_jogo":"This is the scenario, you can decorate it!","insatisfeitos":"Dissatisfied clients","instrucao_inicial":"First calculate the \n head's area","label_lados":"side","largura":"width","lucro":"Profit","menu":"Menu","placeholder_resposta":"answer here","placeholder_unidade":"unit here","possibilidade_gostos":["Sports","Art","Rock","Painting","Sleeping"],"possibilidade_nomes":["John","Jack","Jose","Josefino","Alberto","Ronaldo","Richard","Kleyson","Bot1231","#312112","Teofilo","Blake"],"proximo":"Next client","proximo_dia":"Next day","sair":"Quit Game","satisfeitos":"Satisfied clients","saudacao":"Hello friend!","texto_resultado":"The area is","ultima_frase":["I loved it!","It's awesome!","Really nice!","It's perfect!","I'm really happy","You made my day!"],"validando_etapa":"A good hairstylist needs to \n know his client","valor_a_receber":"Haircut price"}

func _ready():
	_setup_LoL_start_message_received()
	_setup_LoL_translation_message_received()
	LolApi.send_ready_message()
	
	

func _setup_LoL_start_message_received():
	LolApi.connect("start_message_received", self, "_save_language_LoL_Api")

# Save language setting received from the LoL API
func _save_language_LoL_Api(payload: Dictionary):
	game_language = payload.languageCode

func _setup_LoL_translation_message_received():
	LolApi.connect("translation_message_received", self, "_process_translations_Lol_Api")

# Process translation data from the Lol API
func _process_translations_Lol_Api(payload: Dictionary):
	frases = payload
