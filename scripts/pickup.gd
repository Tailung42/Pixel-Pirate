extends Area2D
signal silver_picked
signal gold_picked
signal diamond_picked

func _ready():
	var game_scene = get_node("/root/Game")
	if name.contains("gold_coin"):
			connect("gold_picked", Callable(game_scene, "_on_gold_picked"))
			print("gold signal connected")
	if name.contains("silver_coin"):
			connect("silver_picked", Callable(game_scene, "_on_silver_picked"))
			print("silver signal connected")
	if name.contains("diamond"):
			connect("diamond_picked", Callable(game_scene, "_on_diamond_picked"))
			print("diamond signal connected")


func _on_body_entered(body:Node2D):
	if body.name == "Player":
		if name.contains("silver_coin"):
			silver_picked.emit()
			print("silver signal sent")
		if name.contains("gold_coin"):
			gold_picked.emit()
			print("gold signal sent")
		if name.contains("diamond"):
			diamond_picked.emit()			
			print("diamond signal sent")

		$AudioStreamPlayer.play()
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(0.7).timeout
		queue_free()
