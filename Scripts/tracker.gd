extends Projectile

@onready var game_manager = $"../.."

func _process(delta: float) -> void:
	var target = find_closest_enemy()
	if target:
		direction = (target.position - position).normalized()
	position += direction * speed * delta

func find_closest_enemy():
	var enemies = game_manager.enemy_manager.get_children()
	if enemies.is_empty():
		return
	var close = enemies[0]
	for enemy in enemies:
		var distance = position.distance_to(enemy.position)
		if position.distance_to(close.position) > distance:
			close = enemy
	
	return close
