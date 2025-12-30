extends Node2D
class_name GameManager

@onready var ship = $Ship
@onready var health_bar = $UI/ShipHealth
@onready var score_counter = $UI/ScoreCounter
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_manager = $EnemyManager
@onready var projectiles = $Projectile

@export var enemy_weights : Array[int]
@export var enemies : Array[PackedScene]
@export var can_spawn : Array[bool]

var score = 0:
	set(val):
		score = val
		score_counter.text = "Score: " + str(score)
var timer = 0:
	set(val):
		timer = val
		
		if val > 600:
			enemy_spawn_timer.wait_time = 1
			hp_mult = 5
		elif val > 30:
			enemy_spawn_timer.wait_time = 4
			can_spawn[1] = true
			
var hp_mult = 1
var spawn_enemies := true

func _process(delta: float) -> void:
	timer += delta

func _on_enemy_spawn_timer_timeout() -> void:
	if !spawn_enemies:
		return
	var xpos = randi_range(100, 1050)
	
	var new_enemy = get_random_enemy().instantiate()
	new_enemy.position = Vector2(xpos, -100)
	new_enemy.health *= hp_mult
	
	enemy_manager.add_child(new_enemy)

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
			if can_spawn[index]:
				return enemies[index]
			else:
				return enemies[0]
		
		index += 1
	
	return enemies[index]
