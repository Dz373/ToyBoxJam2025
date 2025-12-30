extends Node2D

@export var speed : int
@export var type_index : int
@export var sprites : Array[Node2D]

var ship

func _ready() -> void:
	ship = get_parent().ship
	type_index = randi_range(0, sprites.size()-1)
	sprites[type_index].visible = true
	

func _process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta


func _on_area_2d_area_entered(_area: Area2D) -> void:
	match type_index:
		0:
			ship.straight_shot.number += 1
		1:
			ship.side_shot.number += 1
		2:
			ship.diagonal_shot.number += 1
		
	queue_free()
