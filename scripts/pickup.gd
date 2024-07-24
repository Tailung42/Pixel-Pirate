extends Area2D
signal silver_picked
signal gold_picked
signal diamond_picked

func _ready():
	var game_scene = get_node("/root/Game")
	if name.contains("gold_coin"):
			connect("gold_picked", Callable(game_scene, "_on_gold_picked"))
	if name.contains("silver_coin"):
			connect("silver_picked", Callable(game_scene, "_on_silver_picked"))
	if name.contains("diamond"):
			connect("diamond_picked", Callable(game_scene, "_on_diamond_picked"))


func _on_body_entered(body:Node2D):
	if body.name == "Player":
		if name.contains("silver_coin"):
			silver_picked.emit()
		if name.contains("gold_coin"):
			gold_picked.emit()
		if name.contains("diamond"):
			diamond_picked.emit()			

		$AudioStreamPlayer.play()
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(0.8).timeout
		queue_free()
