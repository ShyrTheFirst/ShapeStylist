extends Node


var game_language : String = "en"

var frases : Dictionary = {"Game_name":"ShapeStylist",
		"saudacao":"Hello friend!",
		"frase_1":"My name is ",
		"possibilidade_nomes":"John",
		"possibilidade_nomes2":"Jose",
		"possibilidade_nomes3":"Jack",
		"possibilidade_nomes4":"Josefino",
		"possibilidade_nomes5":"Alberto",
		"possibilidade_nomes6":"Ronaldo",
		"possibilidade_nomes7":"Richard",
		"possibilidade_nomes8":"Kleyson",
		"possibilidade_nomes9":"Bot1231",
		"possibilidade_nomes10":"#312112",
		"possibilidade_nomes11":"Teofilo",
		"possibilidade_nomes12":"Blake",
		"frase_2":"I like ",
		"possibilidade_gostos":"Sports",
		"possibilidade_gostos2":"Art",
		"possibilidade_gostos3":"Rock",
		"possibilidade_gostos4":"Painting",
		"possibilidade_gostos5":"Sleeping",
		"frase_3":"This is the haircut I want",
		"largura":"width",
		"altura":"height",
		"area":"area",
		"placeholder_resposta":"answer here",
		"placeholder_unidade":"unit here",
		"texto_resultado":"The area is",
		"label_lados":"side",
		"desistir" : "Let's try again!",
		"ultima_frase":"I loved it!",
		"ultima_frase2":"It's awesome!",
		"ultima_frase3":"Really nice!",
		"ultima_frase4":"It's perfect!",
		"ultima_frase5":"I'm really happy",
		"ultima_frase6":"You made my day!",
		"acerto":"Excellent!",
		"valor_a_receber":"Haircut price",
		"erros_cometidos":"Mistakes made",
		"dinheiro_perdido":"Money lost",
		"lucro":"Profit",
		"dinheiro_fim_do_dia":"Earned money",
		"despesas":"Expenses",
		"comecar":"Start Game",
		"proximo":"Next client",
		"proximo_dia":"Next day",
		"satisfeitos":"Satisfied clients",
		"insatisfeitos":"New attempts",
		"erros":"Mistakes",
		"dinheiro_total":"Money earned",
		"menu":"Menu",
		"carregar":"Load Game",
		"sair":"Quit Game",
		"aviso":"!!!WARNING!!!",
		"aviso_mensagem":"Finish the client to save the game or you \n will lose unsaved progress.",
		"continuar":"Continue",
		"botao_proximo":"Next",
		"tutorial_1_0":"Welcome to the tutorial!",
		"tutorial_1_1":"This is the game's scenario. You can decorate it!",
		"tutorial_1_2":"This is your money, you can buy decorations with it.",
		"tutorial_1_3":"Here we have the menu and sound buttons. \n If you want to go back to menu or adjust the sound,\n use those buttons.",
		"tutorial_1_4":"Click next to continue or use the arrows to see any \n information again.",
		"tutorial_2_0":"a",
		"tutorial_2_1":"b",
		"tutorial_2_2":"c",
		"tutorial_2_3":"d",
		"tutorial_2_4":"e",
		"tutorial_2_5":"f",
		"tutorial_2_6":"g",
		"tutorial_3_0":"a",
		"tutorial_3_1":"b",
		"tutorial_3_2":"c",
		"tutorial_3_3":"d",
		"tutorial_3_4":"e",
		"tutorial_3_5":"f"}

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
