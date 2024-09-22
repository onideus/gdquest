extends Node2D

signal finished

const ConfettisScene := preload("confettis.tscn")
const Confettis := preload("confettis.gd")

## Determines how many confettis get popped
@export var how_many_confettis := 5

func pop_confettis() -> void:
	for i in how_many_confettis:
		await get_tree().create_timer(0.5).timeout
		var confettis: Confettis = ConfettisScene.instantiate()
		confettis.global_position += Vector2.from_angle(randf() * TAU) * 128.0
		add_child(confettis)
	await get_tree().create_timer(0.5).timeout
	finished.emit()
