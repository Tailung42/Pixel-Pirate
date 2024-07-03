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