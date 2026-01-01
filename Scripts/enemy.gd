extends Node2D
class_name Enemy

@export var health := 3
@export var speed := 50
@export var score := 50
@export var up_percent := 0.1

var destroyed = false

@onready var game_manager = $"../.."

func _process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if destroyed:
		return
	
	var bullet = area.get_parent()
	if bullet is Projectile:
		health -= bullet.damage
		
		if health <= 0:
			destroyed = true
			game_manager.score += score
			call_deferred("drop_powerup")
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func drop_powerup():
	var power = preload("res://Prefabs/powerup.tscn").instantiate()
	var val = randi_range(1,10)
	
	if val < 10*up_percent:
		power.position = position
		game_manager.add_child(power)
