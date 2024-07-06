extends Node2D

var silver = 0
var gold = 0
var diamond = 0


func _on_level_1_diamond_picked():
	diamond += 1
	$HUD.update_diamond(diamond)


func _on_level_1_gold_picked():
	gold += 1
	$HUD.update_gold(gold)


func _on_level_1_silver_picked():
	silver += 1
	$HUD.update_silver(silver)


func _on_player_damaged():
	print("player damaged!!")
	$HUD.show_damage()

func _on_player_dead():
	await get_tree().create_timer(0.8).timeout 
	get_tree().reload_current_scene()