extends Control

@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3

func update_hearts(hp: int):
	match hp:
		0:
			heart1.visible = false
			heart2.visible = false
			heart3.visible = false
		1:
			heart1.visible = true
			heart2.visible = false
			heart3.visible = false
		2:
			heart1.visible = true
			heart2.visible = true
			heart3.visible = false
		3:
			heart1.visible = true
			heart2.visible = true
			heart3.visible = true
