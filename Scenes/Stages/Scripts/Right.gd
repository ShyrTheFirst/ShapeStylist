extends Line2D

func _process(_delta):
	if get_parent().get_parent().moving_right:
		material.set_shader_param("shine_color", Color(1.0,1.0,1.0,1.0))
	else:
		material.set_shader_param("shine_color", Color(1.0,1.0,1.0,0.0))
