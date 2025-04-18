extends Area2D

signal target_reached

var max_speed := 1200.0
var velocity := Vector2(0, 0)
var steering_factor := 10.0
var target_position := Vector2(0, 0)

var coins := 0
var energy := 20.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	set_process(false)


func set_target_position(new_target_position: Vector2) -> void:
	target_position = new_target_position
	set_process(true)


func _process(delta: float) -> void:
	var desired_velocity := position.direction_to(target_position) * max_speed
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	position += velocity * delta

	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()
	
	if position.distance_to(target_position) < 10.0:
		set_process(false)
		target_reached.emit()


func _on_area_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group("coin"):
		set_coin_count(coins + 1)
	if area_that_entered.is_in_group("energy"):
		set_energy(energy + 20.0)


func set_coin_count(new_coin_count: int) -> void:
	coins = new_coin_count
	get_node("UI/CoinsCount").text = "x" + str(coins)
	

func set_energy(new_energy_level: float) -> void:
	energy = new_energy_level
	get_node("UI/EnergyBar").value = energy
