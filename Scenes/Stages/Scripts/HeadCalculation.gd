extends Node2D

onready var collision_polygon_2d = $RobotWithHead/CollisionPolygon2D
var vectors : PoolVector2Array
var colors : PoolColorArray

func _ready():
	vectors = [Vector2(210, 285), Vector2(825, 400), Vector2(210,400)]
	colors = [Color.aqua, Color.black, Color.wheat]

func _draw():
	draw_polygon(vectors, colors)
	draw_colored_polygon(vectors, Color.coral)


func _calculate_area():
	pass
