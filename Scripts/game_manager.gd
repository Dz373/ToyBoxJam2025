extends Node2D

var enemy_prefab

func _ready() -> void:
	enemy_prefab = preload("res://Prefabs/enemy.tscn")

func _on_enemy_spawn_timer_timeout() -> void:
	var xpos = randi() % 1050 + 100
	var new_enemy = enemy_prefab.instantiate()
	new_enemy.position = Vector2(xpos, -100)
	add_child(new_enemy)
