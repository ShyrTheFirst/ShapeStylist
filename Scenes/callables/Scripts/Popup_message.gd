extends Label

var set_text = LanguageSelector.frases["acerto"]

func _ready():
	text = set_text

func play_anim():
	$AnimationPlayer.play("popup")
