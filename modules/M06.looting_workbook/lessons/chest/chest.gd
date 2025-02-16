extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	canvas_group.material.set_shader_parameter("line_thickness", 3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	canvas_group.material.set_shader_parameter("line_thickness", 6.0)


func _on_mouse_exited() -> void:
	canvas_group.material.set_shader_parameter("line_thickness", 3.0)
