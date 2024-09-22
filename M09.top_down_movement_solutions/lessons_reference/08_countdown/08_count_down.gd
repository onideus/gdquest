## FIXME: in the lesson this is _not_ an extend, but I need to reference new nodes
## FIXME: that weren't in the previous one
extends "../06_finish_line/06_finish_line.gd"

#ANCHOR:load_countdown_class
const CountDown = preload("res://assets/countdown/countdown.gd")
#END:load_countdown_class

#ANCHOR:countdown_node
@onready var _countdown: CountDown = %Countdown
#END:countdown_node
#ANCHOR:runner_node
@onready var _runner: Runner = %Runner
#ANCHOR:runner_node

#ANCHOR:starting_position
@onready var _starting_position := _runner.position
#END:starting_position

func _ready() -> void:
	super()
#ANCHOR:countdown
	_countdown.finished.connect(
		func() -> void:
			_countdown.hide()
			_runner.disabled = false
	)
#END:countdown
#ANCHOR:restart_game_on_win
	_finish_line.confetti_finished.connect(start_game)
#END:restart_game_on_win
#ANCHOR:call_start_game
	start_game()
#END:call_start_game

#ANCHOR:start_game
func start_game() -> void:
	_runner.position = _starting_position
	_runner.disabled = true
	_countdown.start()
#END:start_game
