@tool
extends Area2D

const ConfettisArea = preload("res://assets/confettis/confettis_area.gd")

signal confetti_finished

@onready var _collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var _visual: ColorRect = %Visual
@onready var _confettis_area: ConfettisArea = $ConfettisArea

@export_range(128, 640, 64) var width = 128 : set = _set_width
@export_range(128, 640, 64) var height = 128 : set = _set_height


func _ready():
	_set_shape()
	if Engine.is_editor_hint():
		return
	_confettis_area.finished.connect(func() -> void:
		confetti_finished.emit()
	)


func _set_width(value : float):
	width = value
	_set_shape()


func _set_height(value : float):
	height = value
	_set_shape()


func _set_shape():
	if !is_inside_tree(): return
	var size = Vector2(width, height)
	var shape : RectangleShape2D = _collision_shape_2d.shape
	shape.size = size
	_visual.position.x = -size.x / 2.0 
	_visual.size = size
	_visual.material.set_shader_parameter("shape_ratio", Vector2(size.x / size.y, 1.0) if size.x > size.y else Vector2(1.0, size.y / size.x))


func pop_confettis() -> void:
	_confettis_area.pop_confettis()
