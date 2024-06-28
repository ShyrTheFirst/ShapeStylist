extends Node2D


func data(day,num):
	$HairEquations.data(day,num)


func _on_TTS_pressed():
	LolApi.send_tts_message("texto_resultado")
