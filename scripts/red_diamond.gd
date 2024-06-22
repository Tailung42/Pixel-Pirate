extends Area2D



func _on_body_entered(body:Node2D):
	print(" +1 coin ")
	queue_free() 