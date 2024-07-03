extends Area2D



func _on_body_entered(body:Node2D):
	queue_free()

func _on_body_exited(body:Node2D):
	pass # Replace with function body.
