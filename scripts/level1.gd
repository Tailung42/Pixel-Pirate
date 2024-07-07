extends Node2D

signal silver_picked
signal  gold_picked
signal diamond_picked


func _on_silver_picked():
	silver_picked.emit()

func _on_gold_picked():
	gold_picked.emit()

func _on_diamonds_picked():
	diamond_picked.emit()
