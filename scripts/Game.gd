extends Node

onready var camera: Camera2D = $camera 
var still_at_the_start: bool = true
var click_count: int = 0


func _on_start_screen_click():
	click_count += 1
	if (click_count == 1): fade_out_the_intro_screen()


func fade_out_the_intro_screen():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(
		$start_screen,
		'modulate',
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		0.6,
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT
	)
	tween.start()
	timeout('display_lore_1', 1)


func display_lore_1():
	$GUI.display_dialogue([
		'You\'ve been wandering for days.', 
		'Lost, hungry, tired, ...delirious?',
		'You come across an odd contraption.'
	])
	pass
	

func display_lore_2():
	$GUI.display_dialogue([
		'A mysterious voice calls you...',
		'You get it. You know what to do now.'
	])
	pass


func _on_GUI_dialogue_done(cb_arg):
	if (still_at_the_start): 
		still_at_the_start = false
		camera.position.x = 218
		timeout("display_lore_2", 1.25)
	if (cb_arg == 'game_end_dialogue'):
		$fade_to_black.fade_out()


func timeout(callback: String, time: float):
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = time
	timer.one_shot = true
	timer.connect("timeout", self, callback)
	timer.start()
	pass


func _on_game_end():
	get_tree().reload_current_scene()


func _on_game_board_game_end(winner: String):
	var player_wins = [
		'A shiver runs down your spine',
		'As if an evil force was forever dispelled.',
		'You don\'t undestand the significance of',
		'your actions. But your descendants surely will.',
		'[Pleasant ending unlocked]'
	]
	
	var ai_wins = [
		'An insurmountable sense of dread engulfs you.',
		'You press onward, but you have a nagging',
		'feeling things will not be ok.',
		'[Dire ending unlocked]'
	]
	
	var nobody_wins = [
		'You finally wake up from your',
		'fever dream, severely dehydrated.',
		'Exhausted, you rest beneath the tree.',
		'[Sober ending unlocked]'
	]
	
	if (winner == 'x'): $GUI.display_dialogue(player_wins, 'game_end_dialogue')
	if (winner == 'o'): $GUI.display_dialogue(ai_wins, 'game_end_dialogue')
	if (winner == ''): $GUI.display_dialogue(nobody_wins, 'game_end_dialogue')
