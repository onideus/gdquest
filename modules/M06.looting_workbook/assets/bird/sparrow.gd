extends Node2D


func _ready() -> void:
	_repeat_with_delay()

func _repeat_with_delay() -> void:
	while true:
		_hop()
		await get_tree().create_timer(2.0).timeout

func _hop() -> void:
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0
	
	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
	var random_distance := randf_range(10.0, 25.0)
	var land_position = random_direction * random_distance
	var jump_height := randf_range(20.0, 50.0)
	var sparrow = get_node("Sparrow2D")
	var shadow = get_node("Shadow")
	
	var tween := create_tween()
	tween.set_parallel()
	
	# Handling sparrow x axis and shadow x and y axis
	tween.tween_property(sparrow, "position:x", land_position.x, FLIGHT_TIME)
	tween.tween_property(shadow, "position:x", land_position.x - 5, FLIGHT_TIME)
	tween.tween_property(shadow, "position:y", land_position.y + 20, FLIGHT_TIME)
	
	# Handling sparrow y axis for parabolic jump
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sparrow, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sparrow, "position:y", land_position.y, HALF_FLIGHT_TIME)
