extends Label

func _ready():
	self.modulate = Color(1, 1, 1, 0)

func _on_start_timer_timeout():
	# self.modulate = Color(1, 1, 1, 1)
	pass

func _on_pulse_timer_timeout():
	$Tween.interpolate_property(
		self,
		'modulate',
		Color(1, 1, 1, 0),
		Color(1, 1, 1, 1),
		0.05,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()
