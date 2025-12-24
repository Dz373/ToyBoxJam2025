extends Node2D

@export var health := 1
@export var speed := 100

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
			queue_free()
			destroyed = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
