extends Node2D

onready var collision_polygon_2d = $RobotWithHead/CollisionPolygon2D
var vectors1 : PoolVector2Array
var vectors2 : PoolVector2Array
var vectors3 : PoolVector2Array
var vectors4 : PoolVector2Array
var vectors5 : PoolVector2Array

var canClick : bool = false
var clicked : bool = false

 #####When we can cut the robot's head, GameManager.can_change_robot = true
func _ready():
	vectors1 = [Vector2(150,255), Vector2(847,384), Vector2(847,255)]
	vectors2 = [Vector2(150,255), Vector2(847,384), Vector2(150,390)]
	vectors3 = [Vector2(847,255), Vector2(596,146), Vector2(596,255)]
	vectors4 = [Vector2(150,145), Vector2(596,255), Vector2(596,146)]
	vectors5 = [Vector2(150,145), Vector2(596,255), Vector2(150,255)]

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

func _calculate_area():
	pass

func finished():
	get_parent().last_stage = true
	queue_free()

func _on_mouse_detection_mouse_entered():
	canClick = true

func _on_mouse_detection_mouse_exited():
	canClick = false
