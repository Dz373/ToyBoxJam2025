extends Node2D

@export var health = 3
@export var atk_speed := 1.0

var straight_shot
var side_shot
var diagonal_shot

@onready var straight_shot_timer = $StraightTimer
@onready var side_shot_timer = $SideTimer
@onready var diagonal_shot_timer = $DiagonalTimer

var bullet_prefab

func _ready() -> void:
	straight_shot = Projectile.new()
	side_shot = Projectile.new()
	diagonal_shot = Projectile.new()
	
	side_shot.number = 0
	diagonal_shot.number = 0
	
	bullet_prefab = preload("res://Prefabs/bullet.tscn")
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position = get_global_mouse_position()

func shoot(projectile, dir:Vector2):
	var shot = bullet_prefab.instantiate()
	shot.instantiate_projectile(projectile, dir, position)
	get_parent().add_child(shot)

func _on_straight_timer_timeout() -> void:
	for i in straight_shot.number:
		shoot(straight_shot, Vector2.UP)
		await get_tree().create_timer(0.1).timeout

func  _on_side_timer_timeout() -> void:
	for i in side_shot.number:
		shoot(side_shot, Vector2.LEFT)
		shoot(side_shot, Vector2.RIGHT)
		await get_tree().create_timer(0.1).timeout

func  _on_diagonal_timer_timeout() -> void:
	for i in diagonal_shot.number:
		shoot(diagonal_shot, Vector2(1,-1).normalized())
		shoot(diagonal_shot, Vector2(-1,-1).normalized())
		await get_tree().create_timer(0.1).timeout


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().queue_free()
	health -= 1
	if health <= 0:
		print("Game Over")
