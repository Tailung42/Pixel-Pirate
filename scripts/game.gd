extends Node2D

var silver
var gold 
var diamond

func _ready():
	$Player.hide()

func new_game():
	print("new game started")
	silver = 0
	gold = 0
	diamond = 0
	$Player.life = 3
	$Player.show()
	$Player.control = true 

func game_over():
	$HUD/Initials.show()
	await get_tree().create_timer(0.8).timeout 
	get_tree().reload_current_scene()


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
	game_over()


func _on_hud_start_game():
	new_game()
