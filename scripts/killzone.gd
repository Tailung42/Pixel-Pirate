extends Area2D

var in_contact = false;

func _on_body_entered(body:Node2D):
	if body.name == "Player":
		in_contact = true
		while in_contact == true:
			get_node("/root/Game/Player").player_damaged()
			await get_tree().create_timer(1).timeout



# func _on_timer_timeout():
# 	get_tree().reload_current_scene(


func _on_body_exited(body:Node2D):
	in_contact = false;
