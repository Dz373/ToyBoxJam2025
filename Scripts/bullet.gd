extends Node2D
class_name Projectile

var damage := 1
var speed := 500
var on_cd := false

var direction := Vector2.UP

var pierce := 0
var number := 0

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func instantiate_projectile(projectile, dir, pos):
	position = pos
	speed = projectile.speed
	
	direction = dir
	rotate(direction.angle() - PI/2)
	
	damage = projectile.damage
	pierce = projectile.pierce


func _on_area_2d_area_entered(_area: Area2D) -> void:
	pierce -= 1
	if pierce < 0:
		queue_free()
