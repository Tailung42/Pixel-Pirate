extends Area2D


func _on_body_entered(body:Node2D):
	if body.name == "Player":
		# get_node("Game/Player").player_damaged()
		get_node("/root/Game/Player").player_damaged()



# func _on_timer_timeout():
# 	get_tree().reload_current_scene(
