extends Area2D

func _on_body_entered(body:Node2D):
	$AudioStreamPlayer.play()
	print("picked")
	$AnimatedSprite2D.visible = false
	await get_tree().create_timer(1).timeout
	queue_free()
