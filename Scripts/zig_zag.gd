extends Enemy

var directions = [Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
var index = 0

func _process(delta: float) -> void:
	position += move_dir * speed * delta

func _on_move_timer_timeout() -> void:
	index += 1
	if index > 5:
		index = 0
	move_dir = directions[index]
