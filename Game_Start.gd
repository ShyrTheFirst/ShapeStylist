extends Node2D

onready var start = $Start
onready var game_name = $CanvasLayer/Panel/GameName

func _ready():
	start.start()

func _process(delta):
	game_name.material["shader_param/percentage"] -= delta/20

func _on_Start_timeout():
	get_tree().change_scene_to(preload("res://menu.tscn")) 
