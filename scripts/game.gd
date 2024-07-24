extends Node2D

var silver
var gold 
var diamond
var level_paths = {
	"level_1": "res://levels/level1.tscn", 
	"level_2": "res://levels/level2.tscn"
}
var current_level
@onready var level_index = 1
@onready var player = $Player
@onready var end_position = $EndPosition
@onready var start_position = $StartPosition
func _ready():
	player.hide()

func _process(delta):
	if player.position.x >= end_position.position.x:
		new_level()



func new_game():
	$Player.new_game()
	$Player.position = start_position.position
	switch_level("level_" + str(level_index))
	silver = 0
	$HUD.update_silver(silver)
	gold = 0
	$HUD.update_gold(gold)
	print("gold updated")
	diamond = 0
	$HUD.update_diamond(diamond)
	$HUD.progress_bar.value = $HUD.progress_bar.max_value
	$BgMusic.play()

func game_over():
	$Player.control = false
	$Player.hide()
	$Player/CollisionShape2D.disabled = true
	$HUD/GameOver.show()
	$HUD/InGame.hide()
	await get_tree().create_timer(0.8).timeout 
	$BgMusic.stop()


func _on_diamond_picked():
	diamond += 1
	$HUD.update_diamond(diamond)


func _on_gold_picked():
	gold += 1
	$HUD.update_gold(gold)


func _on_silver_picked():
	silver += 1
	$HUD.update_silver(silver)
	 
func _on_player_damaged():
	print("game receives damage")
	$HUD.show_damage()


func _on_player_dead():
	get_tree().create_timer(0.5).timeout
	print("dead received")
	game_over()


func _on_hud_start_game():
	new_game()


func _on_bg_music_finished():
	$BgMusic.play()


func switch_level(level_name):
	# unload current level 
	if current_level:
		current_level.queue_free()

	#load next level
	if  level_name in level_paths:
		current_level = load(level_paths[level_name]).instantiate()
		$levels.add_child(current_level)
		$StartPosition.position = current_level.get_node("StartPosition").position
		$EndPosition.position = current_level.get_node("EndPosition").position

	# connect signals
	if current_level.has_signal("silver_picked"):
		current_level.connect("silver_picked", Callable(self, "_on_silver_picked"))

	if current_level.has_signal("gold_picked"):
		current_level.connect("gold_picked", Callable(self, "_on_gold_picked"))

	if current_level.has_signal("diamond_picked"):
		current_level.connect("diamond_picked", Callable(self, "_on_diamond_picked"))

func new_level():
	if level_index < len(level_paths):
		level_index += 1
		new_game()
	else:
		level_index = 1
		game_over()