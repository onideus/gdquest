extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_energy_pack_pickup)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_energy_pack_pickup(area_that_entered: Area2D) -> void:
	queue_free()
