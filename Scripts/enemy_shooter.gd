extends Enemy
class_name Shooter

var bullet
var bullet_prefab

func _ready() -> void:
	bullet = Projectile.new()
	bullet.speed = 300
	
	bullet_prefab = preload("res://Prefabs/enemy_projectile.tscn")

func _process(delta: float) -> void:
	if position.y >= 64:
		return
	position += Vector2.DOWN * speed * delta

func _on_timer_timeout() -> void:
	var ship = game_manager.ship
	var proj = bullet_prefab.instantiate()
	
	var dir = (ship.position - position).normalized()
	proj.instantiate_projectile(bullet, dir, position)
	
	get_parent().add_child(proj)
