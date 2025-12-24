extends Node2D
class_name Enemy

@export var health := 3
@export var speed := 50
@export var score := 50

var destroyed = false

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
			get_parent().score += score
			
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
