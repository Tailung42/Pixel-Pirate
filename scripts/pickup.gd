extends Area2D

func _on_body_entered(body:Node2D):
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.visible = false
	await get_tree().create_timer(0.5).timeout
	queue_free()
