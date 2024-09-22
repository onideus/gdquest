extends Control

@onready var label: Label = %Label

var steps := PackedStringArray(["3", "2", "1", "Go!"])
var _tween : Tween

signal finished

func start():
	# Ensure the countdown is not invisible
	show()
	# If there was a previous countdown before, kill it
	if _tween && _tween.is_valid(): 
		_tween.kill()
	
	_tween = create_tween()\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	
	# Cue all the tweens one after the other, one for each letter
	for text in steps:
		# Grow the label to its full size from its half size
		_tween.tween_property(label, "scale", Vector2.ONE, 0.5)\
			.from(Vector2.ONE * 0.5)
		
		# After the tween is over, set the text and move the 
		_tween.tween_callback(func():
			label.text = text
			# for proper scaling from the center, we ensure the pivot
			# is in the middle. Because letters have different sizes,
			# we recalculate this after each step
			label.pivot_offset = label.get_combined_minimum_size() / 2.0
		)
	
	# Once there's one tween per sep, we finally scale back to a smaller size
	_tween.tween_property(label, "scale", Vector2.ONE * 0.4, 0.2)\
		.set_ease(Tween.EASE_IN)\
		.set_delay(0.25)
	# ... and dispatch a signal
	_tween.tween_callback(func():
		label.text = ""
		finished.emit()
	)
