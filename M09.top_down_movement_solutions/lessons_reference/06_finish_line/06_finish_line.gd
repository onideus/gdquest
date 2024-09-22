extends Node2D

#ANCHOR:needs_to_be_written_in_lesson
const Runner = preload("../05_new_assets/05_runner.gd")
#END:needs_to_be_written_in_lesson
#ANCHOR:load_class
const FinishLine = preload("res://assets/finish_line/finish_line.gd")
#END:load_class

#ANCHOR:finish_line
@onready var _finish_line: FinishLine = %FinishLine
#END:finish_line

#ANCHOR:ready
func _ready() -> void:
	_finish_line.body_entered.connect(func(body: Node2D) -> void:
#ANCHOR:is_discriminant
		if body is Runner:
#END:is_discriminant
#ANCHOR:casting
			var runner := body as Runner
#END:casting
			runner.disabled = true
			var target_position := _finish_line.global_position \
				+ Vector2(0, 50)
			runner.walk_to(target_position)
			runner.walked_to.connect(
				_finish_line.pop_confettis
			)
	)
#END:ready
