extends Projectile
class_name Explosion

@onready var blast_animation = $Blast/AnimationPlayer
var exploding = false

func _ready() -> void:
	speed = 200

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if exploding:
		return
	trigger_explosion()
	await get_tree().create_timer(0.4).timeout
	queue_free()

func trigger_explosion():
	exploding = true
	speed = 0
	blast_animation.play("ex")
