extends Shooter

func _process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta

func _on_timer_timeout() -> void:
	var proj = bullet_prefab.instantiate()
	
	proj.instantiate_projectile(bullet, Vector2.DOWN, position)
	
	game_manager.add_child(proj)
