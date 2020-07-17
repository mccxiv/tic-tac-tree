extends Container

onready var tic: Label = $tic
onready var tac: Label = $tac
onready var tree: Label = $tree

onready var tic_tween: Tween = $tic_tween
onready var tac_tween: Tween = $tac_tween
onready var tree_tween: Tween = $tree_tween

onready var tic_pos = tic.rect_position
onready var tac_pos = tac.rect_position
onready var tree_pos = tree.rect_position

onready var tic_start_pos = Vector2(tic_pos.x, -30)
onready var tac_start_pos = Vector2(-100, tac_pos.y)
onready var tree_start_pos = Vector2(tree_pos.x, 138)

onready var intro_finished = false

signal click

func _ready():
	tic.rect_position = tic_start_pos
	tac.rect_position = tac_start_pos
	tree.rect_position = tree_start_pos
	pass

func _on_tic_timer_timeout():
	tic_tween.interpolate_property(
		tic, 
		'rect_position',
		tic_start_pos,
		tic_pos,
		0.20,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tic_tween.start()


func _on_tac_timer_timeout():
	tac_tween.interpolate_property(
		tac, 
		'rect_position',
		tac_start_pos,
		tac_pos,
		0.15,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tac_tween.start()
	pass


func _on_tree_timer_timeout():
	tree_tween.interpolate_property(
		tree, 
		'rect_position',
		tree_start_pos,
		tree_pos,
		0.15,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tree_tween.start()
	pass


func _on_start_screen_gui_input(event):
	if (!intro_finished): return
	if (event is InputEventMouseButton && !event.is_pressed()):
		if (event.button_index == BUTTON_LEFT): 
			emit_signal('click')


func _on_intro_finished_timeout():
	intro_finished = true
