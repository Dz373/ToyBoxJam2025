extends Node2D
class_name GameManager

@onready var ship = $Ship
@onready var health_bar = $UI/ShipHealth

var enemy_prefab
@export var enemy_weights : Array[int]
@export var enemies : Array[PackedScene]

var score = 0

func _ready() -> void:
	enemy_prefab = preload("res://Prefabs/enemy.tscn")

func _on_enemy_spawn_timer_timeout() -> void:
	var xpos = randi_range(100, 1050)
	
	var new_enemy = enemy_prefab.instantiate()
	new_enemy.position = Vector2(xpos, -100)
	
	add_child(new_enemy)
