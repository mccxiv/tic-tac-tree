extends Node

signal game_end

onready var ai_timer: Timer = $ai_timer
onready var winning_combinations = {
	'r1': [0, 1, 2],
	'r2': [3, 4, 5],
	'r3': [6, 7, 8],
	'c1': [0, 3, 6],
	'c2': [1, 4, 7],
	'c3': [2, 5, 8],
	'd1': [0, 4, 8],
	'd2': [2, 4, 6],
}
onready var areas = [$pos0, $pos1, $pos2, $pos3, $pos4, $pos5, $pos6, $pos7, $pos8]

var state: Array = [] # current value in each pos
var is_player_turn = true
var won: bool = false

func _ready():
	initialize_state()
	pass # Replace with function body.


func initialize_state(): 
	for i in range(0,9):
		state.append(null)


func is_game_over() -> bool:
	return (get_winner() || no_moves_available())


func no_moves_available() -> bool:
	for i in range(0,9):
		if (state[i] == null): return false
	return true


func win():
	won = true
	$click_blocker.mouse_filter = $click_blocker.MOUSE_FILTER_STOP
	emit_signal("game_end", get_winner())


func check_win():
	if (is_game_over()): win()


func get_winner() -> String:
	for pos in winning_combinations.values():
		var values = [state[pos[0]], state[pos[1]], state[pos[2]]]
		if (values[0] && values[1] && values[2]):
			if (values[0] == values[1] && values[0] == values[2]):
				return values[0]
	return ''


func empty_positions() -> Array: 
	var available_positions = []
	for i in range(0, state.size()):
		if (!state[i]): available_positions.append(i)
	return available_positions
	pass


func random_empty_position() -> int: 
	var shuffled = empty_positions()
	if (shuffled.size() == 0): return -1
	shuffled.shuffle()
	return shuffled[0]


func player_clicked(pos: int):
	if (is_player_turn): 
		state[pos] = 'x'
		areas[pos].play_x()
		is_player_turn = false
		check_win()
		if (!won): ai_timer.start()


func _on_ai_timer_timeout():
	ai_timer.stop()
	
	# TODO
	# AI algo: 
	# - find winning rows without enemy
	# - find row with most of mine
	# - fill empty
	
	var pos = random_empty_position()
	if (pos > -1):
		areas[pos].play_o()
		state[pos] = 'o'
		is_player_turn = true
		check_win()


func _on_pos0_clicked():
	player_clicked(0)

func _on_pos1_clicked():
	player_clicked(1)

func _on_pos2_clicked():
	player_clicked(2)
	
func _on_pos3_clicked():
	player_clicked(3)
	
func _on_pos4_clicked():
	player_clicked(4)
	
func _on_pos5_clicked():
	player_clicked(5)
	
func _on_pos6_clicked():
	player_clicked(6)
	
func _on_pos7_clicked():
	player_clicked(7)
	
func _on_pos8_clicked():
	player_clicked(8)
