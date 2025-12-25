extends Node2D

@export var speed : int

@export var type_index : int
@export var sprites : Array[Texture]


func _process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta


func _on_area_2d_area_entered(_area: Area2D) -> void:
	var ship = get_parent().ship
	match type_index:
		1:
			ship.straight_shot.number += 1
		2:
			ship.side_shot.number += 1
		3:
			ship.diagonal_shot.number += 1
	
	queue_free()
