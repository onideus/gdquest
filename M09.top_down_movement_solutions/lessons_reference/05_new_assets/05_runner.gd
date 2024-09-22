extends CharacterBody2D


#ANCHOR:character_visual
@onready var _character_visual: RunnerVisual = %CharacterVisual
#END:character_visual
#ANCHOR:dust_emitter
@onready var _dust : GPUParticles2D = %Dust
#END:dust_emitter

## The top speed that the runner can achieve
@export var max_speed := 400.0
## How much speed is added per second when the player presses a movement key
@export var acceleration := 1200.0
## How much speed is lost per second when the player releases all movement keys
@export var deceleration := 1080.0

## multiplies acceleration. By doubling it or halving it, we can make 
## acceleration faster or slower
var _speed_factor := 1.0
## multiplies deceleration. By doubling or havling it, we can make
## the deceleration faster or slower
var _friction_factor := 1.0
#ANCHOR:last_direction
## Stores the last direction of the player, to rotate the sprite accordingly.
## This is a unit vector of length 1.0
var _last_direction : Vector2 = Vector2.ZERO
#END:last_direction

## FIXME: for step 6
#ANCHOR:disabled_prop
## If this is `true`, the character will not process inputs
var disabled := false
#END:disabled_prop

## FIXME: for step 6
## Forces the character to walk to a position ignoring collisions
#ANCHOR:walk_to_function
#ANCHOR:walk_to_signature
func walk_to(target_global_position : Vector2) -> void:
#END:walk_to_signature
#ANCHOR:reduce_velocity
	velocity = Vector2.ZERO
	_last_direction = global_position.direction_to(target_global_position).normalized()
	_character_visual.angle = _last_direction.orthogonal().angle()
#END:reduce_velocity
	_character_visual.animation_name = RunnerVisual.Animations.WALK
#ANCHOR:duration
	var duration := global_position.distance_to(target_global_position) / (max_speed * 0.8)
#END:duration
	var tween := create_tween()
	tween.tween_property(self, "global_position", target_global_position, duration)
#ANCHOR:walk_to_tween
	tween.finished.connect(func():
		_character_visual.animation_name = RunnerVisual.Animations.IDLE
		_dust.emitting = false
	)
#END:walk_to_tween
#END:walk_to_function

#ANCHOR:physics_process
func _physics_process(delta: float) -> void:
## FIXME: for step 6
#ANCHOR:exit_if_disabled
	if disabled:
		return
#END:exit_if_disabled
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input_direction := direction.length() > 0.0
#ANCHOR:_last_direction
	if has_input_direction:
		_last_direction = direction
#END:_last_direction
#ANCHOR:ternary
		var animation_name := RunnerVisual.Animations.WALK if velocity.length() / max_speed < 0.8 else RunnerVisual.Animations.RUN
#END:ternary
		_character_visual.animation_name = animation_name
		velocity = velocity.move_toward(direction * max_speed, acceleration * _friction_factor * delta)
		velocity = velocity.limit_length(max_speed * _speed_factor)
	else:
		_character_visual.animation_name = RunnerVisual.Animations.IDLE
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	move_and_slide()
#ANCHOR:visual_angle
	_character_visual.angle = rotate_toward(_character_visual.angle, _last_direction.orthogonal().angle(), 8.0 * delta)
#END:visual_angle
#ANCHOR:dust
	_dust.emitting = has_input_direction
#END:dust
#END:physics_process
