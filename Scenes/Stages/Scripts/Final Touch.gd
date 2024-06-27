extends Node2D

onready var color_selector = $ColorSelector
onready var haircut_1 = $Haircut1
onready var finish_client = $Finish_client

var shape_0 = preload("res://Assets/shapes/Shapes_finalized/shape_0.png")
var shape_01 = preload("res://Assets/shapes/Shapes_finalized/shape_01.png")
var shape_02 = preload("res://Assets/shapes/Shapes_finalized/shape_02.png")
var shape_03 = preload("res://Assets/shapes/Shapes_finalized/shape_03.png")
var shape_04 = preload("res://Assets/shapes/Shapes_finalized/shape_04.png")
var shape_05 = preload("res://Assets/shapes/Shapes_finalized/shape_05.png")

onready var color_rect_6 = $ColorRect6
onready var color_rect = $ColorRect
onready var color_rect_2 = $ColorRect2
onready var color_rect_3 = $ColorRect3
onready var color_rect_4 = $ColorRect4
onready var color_rect_5 = $ColorRect5
onready var direita = $Direita
onready var esquerda = $Esquerda
onready var confirm = $Confirm


func _ready():
	GameManager.can_change_robot = true
	match GameManager.shape_value:
		0:
			haircut_1.texture = shape_0
		1:
			haircut_1.texture = shape_01
		2:
			haircut_1.texture = shape_02
		3:
			haircut_1.texture = shape_03
		4:
			haircut_1.texture = shape_04
		5:
			haircut_1.texture = shape_05

func _process(delta):
	if GameManager.shape_value == 0:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-75,-211)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-75,-200)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-75,-211)

	if GameManager.shape_value == 1:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-75,-178)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-89,-159)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-76,-153)

	if GameManager.shape_value == 2:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-73,-154)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-87,-171)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-73,-215)

	if GameManager.shape_value == 3:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-77,-213)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-90,-174)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-73,-163)

	if GameManager.shape_value == 4:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-51,-142)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-92,-175)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-73,-200)

	if GameManager.shape_value == 5:
		if haircut_1.rotation_degrees == 0:
			haircut_1.position = Vector2(-67,-200)
		if haircut_1.rotation_degrees == 90:
			haircut_1.position = Vector2(-67,-181)
		if haircut_1.rotation_degrees == 180:
			haircut_1.position = Vector2(-84,-190)

	haircut_1.modulate = color_selector.get_pick_color()

func _on_Direita_pressed():
	if haircut_1.rotation_degrees == 0:
		haircut_1.rotation_degrees = 90
	
	elif haircut_1.rotation_degrees == 90:
		haircut_1.rotation_degrees = 180
	
	elif haircut_1.rotation_degrees == 180:
		haircut_1.rotation_degrees = 0

func _on_Esquerda_pressed():
	if haircut_1.rotation_degrees == 0:
		haircut_1.rotation_degrees = 180
	
	elif haircut_1.rotation_degrees == 90:
		haircut_1.rotation_degrees = 0
	
	elif haircut_1.rotation_degrees == 180:
		haircut_1.rotation_degrees = 90

func _on_Confirm_pressed():
	color_rect_6.visible = false
	color_rect.visible = false
	color_rect_2.visible = false
	color_rect_3.visible = false
	color_rect_4.visible = false
	color_rect_5 .visible = false
	direita.visible = false
	esquerda.visible = false
	confirm.visible = false
	color_selector.visible = false
	finish_client.start()
	GameManager.last_phrase = true

func _on_Finish_client_timeout():
	GameManager.goodbye_client = true
	GameManager.can_change_robot = false
