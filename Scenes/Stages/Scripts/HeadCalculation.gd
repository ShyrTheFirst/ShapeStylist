extends Node2D

onready var collision_polygon_2d = $RobotWithHead/CollisionPolygon2D
var vectors1 : PoolVector2Array
var vectors2 : PoolVector2Array
var vectors3 : PoolVector2Array
var vectors4 : PoolVector2Array
var vectors5 : PoolVector2Array

var canClick : bool = false
var clicked : bool = false

var moving_right : bool = false
var moving_left : bool = false
onready var right = $mouse_detection/Right
onready var left = $mouse_detection/Left


 #####When we can cut the robot's head, GameManager.can_change_robot = true
func _ready():
	vectors1 = [Vector2(150,245), Vector2(847,390), Vector2(847,245)]
	vectors2 = [Vector2(150,245), Vector2(847,390), Vector2(150,390)]
	vectors3 = [Vector2(847,245), Vector2(596,146), Vector2(596,245)]
	vectors4 = [Vector2(150,145), Vector2(596,245), Vector2(596,146)]
	vectors5 = [Vector2(150,145), Vector2(596,245), Vector2(150,245)]

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
	if canClick or clicked:
		pass
	
	if Input.is_action_just_pressed("MouseClick"):
		if canClick:
			clicked = true
			print("Click") #start dragging the line
	
	if Input.is_action_just_released("MouseClick"):
		clicked = false

func _calculate_area():
	pass

func finished():
	get_parent().last_stage = true
	queue_free()

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
