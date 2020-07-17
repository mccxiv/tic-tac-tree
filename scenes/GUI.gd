extends CanvasLayer

signal dialogue_done

var text_array = []
var callback_param = null
var printing: bool = false
onready var label: Label = $dialogue_box/TextureRect/text

func _ready():
	$dialogue_box.hide()


func display_dialogue(arr: Array, cb_param = null):
	text_array = arr
	callback_param = cb_param
	if has_more(): display_line()


func display_line():
	printing = true
	$dialogue_box.show()
	label.text = text_array.pop_front()
	label.visible_characters = 0
	$letter_timer.start()


func has_more():
	return text_array.size() > 0


func _on_dialogue_box_gui_input(event):
	if (event is InputEventMouseButton):
		if (!event.is_pressed() && !printing && event.button_index == BUTTON_LEFT): 
			if has_more(): display_line()
			else:
				text_array = []
				$dialogue_box/TextureRect/text.text = ''
				$dialogue_box.hide()
				emit_signal("dialogue_done", callback_param)
				callback_param = null
				


func _on_display_next_letter():
	label.visible_characters += 1
	if (label.visible_characters == label.text.length()):
		$letter_timer.stop()
		printing = false
