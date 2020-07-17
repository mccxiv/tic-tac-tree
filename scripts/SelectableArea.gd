extends Area2D

export var pos: int = -1
signal clicked

onready var x_texture: Texture = preload('res://assets/x.png')
onready var o_texture: Texture = preload('res://assets/o.png')
onready var selection_indicator: Sprite = $selection_indicator
onready var x_or_o: Sprite = $x_or_o

func _ready():
	selection_indicator.hide()

func _on_position_mouse_entered():
	if (!x_or_o.texture): selection_indicator.show()

func _on_position_mouse_exited():
	selection_indicator.hide()
	
func play_x():
	if (!x_or_o.texture):
		x_or_o.set_texture(x_texture)

func play_o():
	if (!x_or_o.texture):
		x_or_o.texture = o_texture

func _on_position_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton): 
		if (event.button_index == BUTTON_LEFT): 
			selection_indicator.hide()
			# play_x()
			emit_signal('clicked')
