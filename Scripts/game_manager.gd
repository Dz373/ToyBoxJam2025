extends Node2D
class_name GameManager

@onready var ship = $Ship
@onready var health_bar = $UI/ShipHealth
@onready var score_counter = $UI/ScoreCounter
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var wave_spawn_timer = $WaveSpawner
@onready var enemy_manager = $EnemyManager
@onready var projectiles = $Projectile
@onready var game_over_menu = $UI/GameOver

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
			wave_spawn_timer.wait_time = 15
			hp_mult = 5
			wave_num = 3
			
		elif val > 300:
			enemy_weights[0] = 1
			enemy_spawn_timer.wait_time = 2
			hp_mult = 4
		
		elif val > 180:
			hp_mult = 3
			wave_num = 2
		
		elif val > 90:
			enemy_spawn_timer.wait_time = 3
			hp_mult = 2
			can_spawn[3] = true
		
		elif val > 60:
			can_spawn[2] = true
		
		elif val > 30:
			enemy_spawn_timer.wait_time = 4
			can_spawn[1] = true
			
var hp_mult = 1
var spawn_enemies := true
var wave_num = 1

func _process(delta: float) -> void:
	timer += delta

func _on_enemy_spawn_timer_timeout() -> void:
	if !spawn_enemies:
		return
	var xpos = randi_range(100, 1050)
	
	var new_enemy = get_random_enemy().instantiate()
	new_enemy.position = Vector2(xpos, 0)
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


func _on_wave_spawner_timeout() -> void:
	var random = randi_range(0,2)
	match random:
		0:
			line_wave()
		1:
			diagonal_wave()
		2:
			huge_wave()

func line_wave():
	for k in range(wave_num):
		for i in range(17):
			var new_enemy = enemies[0].instantiate()
			new_enemy.position = Vector2(64 + 64*i, 0)
			new_enemy.health *= hp_mult
		
			enemy_manager.add_child(new_enemy)
	

func diagonal_wave():
	var enemy = enemies[0]
	for i in range(wave_num*3):
		if timer > 300:
			enemy = enemies[3]
		var new_enemy = enemy.instantiate()
		new_enemy.health *= hp_mult
		new_enemy.position = Vector2(0, 0)
		new_enemy.move_dir = Vector2(1,1).normalized()
		enemy_manager.add_child(new_enemy)
		
		new_enemy = enemy.instantiate()
		new_enemy.position = Vector2(1152, 0)
		new_enemy.move_dir = Vector2(-1,1).normalized()
		enemy_manager.add_child(new_enemy)
		
		await get_tree().create_timer(1).timeout

func huge_wave():
	for i in range(wave_num*10):
		var xpos = randi_range(100, 1050)
	
		var new_enemy = get_random_enemy().instantiate()
		new_enemy.position = Vector2(xpos, 0)
		new_enemy.health *= hp_mult
		
		enemy_manager.add_child(new_enemy)

		await get_tree().create_timer(0.5).timeout

func game_over():
	score_counter.visible = false
	game_over_menu.visible = true
	
	$UI/GameOver/Score.text = "Score: " + str(score)
	$UI/GameOver/Timer.text = "Time: " + get_time_string(timer)


func _on_retry_button_down() -> void:
	get_tree().reload_current_scene()

func get_time_string(time: int)->String:
	var minute = time / 60
	var second = time % 60
	return str(minute) + ":" + str(second)
