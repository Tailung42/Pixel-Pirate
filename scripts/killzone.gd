extends Area2D

signal player_damaged

func _ready():
	connect("player_damaged", Callable(get_node("/root/Game/Player"), "_on_player_damaged"))
	


func _on_body_entered(body:Node2D):
	if body.name == "Player":
		if get_node("/root/Game/Player").life > 0:
			player_damaged.emit()
			