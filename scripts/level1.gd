extends Node2D

signal silver_picked
signal  gold_picked
signal diamond_picked


func _on_silver_child_exiting_tree(node:Node):
	print("silver")
	silver_picked.emit()

func _on_gold_child_exiting_tree(node:Node):
	print("gold")
	gold_picked.emit()

func _on_diamonds_child_exiting_tree(node:Node):
	print("diamond")
	diamond_picked.emit()
