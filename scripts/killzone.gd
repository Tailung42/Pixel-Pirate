extends Area2D

signal player_damaged

func _ready():
	connect("player_damaged", Callable(get_node("/root/Game/Player"), "_on_player_damaged"))
	

var in_contact = false;

func _on_body_entered(body:Node2D):
	if body.name == "Player":
		in_contact = true
		while in_contact == true:
			if get_node("/root/Game/Player").life > 0:
				player_damaged.emit()
				await get_tree().create_timer(1).timeout
			else:
				$CollisionShape2D.disabled =true 
				break


func _on_body_exited(body:Node2D):
	in_contact = false;
