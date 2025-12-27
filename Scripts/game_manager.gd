extends Node2D
class_name GameManager

@onready var ship = $Ship
@onready var health_bar = $UI/ShipHealth
@onready var score_counter = $UI/ScoreCounter

var enemy_prefab
@export var enemy_weights : Array[int]
@export var enemies : Array[PackedScene]

var score = 0:
	set(val):
		score = val
		score_counter.text = "Score: " + str(score)

func _on_enemy_spawn_timer_timeout() -> void:
	var xpos = randi_range(100, 1050)
	
	var new_enemy = get_random_enemy().instantiate()
	new_enemy.position = Vector2(xpos, -100)
	
	add_child(new_enemy)

func get_random_enemy()->PackedScene:
	var weight_total = 0
	for i in enemy_weights:
		weight_total += i
	
	var random_val = randi_range(1,weight_total)
	var prev_weight = 0
	var index = 0
	for i in enemy_weights:
		prev_weight += i
		
		if random_val <= prev_weight:
			return enemies[index]
		
		index += 1
	
	return enemies[index]
