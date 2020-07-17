extends CanvasLayer

signal fade_ended

func fade_out():
	$Tween.interpolate_property(
		$color_rect, 
		'modulate',
		Color(0, 0, 0, 0),
		Color(0, 0, 0, 1),
		2,
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT
	)
	$Tween.start()
	timeout('emit_fade_end', 2)


func emit_fade_end():
	emit_signal('fade_ended')


func timeout(callback: String, time: float):
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = time
	timer.one_shot = true
	timer.connect("timeout", self, callback)
	timer.start()
	pass
