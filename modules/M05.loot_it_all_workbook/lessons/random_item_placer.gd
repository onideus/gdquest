extends Node2D


var item_scenes := [
	preload("gem.tscn"),
	preload("health_pack.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Timer").timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var random_item_scene: PackedScene = item_scenes.pick_random()
	var item_instance := random_item_scene.instantiate()
	item_instance.position = _get_random_position_on_screen()
	add_child(item_instance)
	

func _get_random_position_on_screen() -> Vector2:
	var viewport_size := get_viewport_rect().size
	var random_position := Vector2(0, 0)
	random_position.x = randf_range(0, viewport_size.x)
	random_position.y = randf_range(0, viewport_size.y)
	return random_position
	
