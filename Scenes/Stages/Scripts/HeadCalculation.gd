extends Node2D

onready var collision_polygon_2d = $RobotWithHead/CollisionPolygon2D
var vectors : PoolVector2Array
var colors : PoolColorArray

func _ready():
	vectors = [Vector2(210, 285), Vector2(825, 400), Vector2(210,400)]

func _draw():
	draw_colored_polygon(vectors, Color.coral)


func _calculate_area():
	pass

func finished():
	get_parent().last_stage = true
	queue_free()
