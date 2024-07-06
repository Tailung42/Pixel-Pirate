extends Node2D

var silver
var gold 
var diamond

func _ready():
	$Player.hide()

func new_game():
	print("new game started")
	silver = 0
	$HUD.update_silver(silver)
	gold = 0
	$HUD.update_gold(gold)
	diamond = 0
	$HUD.update_diamond()
	$Player/CollisionShape2D.disabled = false
	$Player.life = 3
	$Player.show()
	$Player.control = true
	$BgMusic.play()

func game_over():
	$Player.control = false
	$Player.hide()
	$Player/CollisionShape2D.disabled = true
	# $HUD/gameover.show()
	$HUD/Initials.show()
	$HUD/InGame.hide()
	await get_tree().create_timer(0.8).timeout 
	$BgMusic.stop()


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


func _on_bg_music_finished():
	$BgMusic.play()
