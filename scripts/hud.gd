extends CanvasLayer

@onready  var progress_bar = $InGame/HealthBar/ProgressBar

signal start_game

func _ready():
	# _update_progress_bar_color(progress_bar.value)
	$InGame.hide()
	$Initials/StartButton.hide()
	await get_tree().create_timer(0.5).timeout
	$Initials/StartButton.show()

	
func update_silver(silver):
	$InGame/Silver.text = str(silver)

func update_gold(gold):
	$InGame/Gold.text = str(gold)

func update_diamond(diamond):
	$InGame/Diamond.text = str(diamond)

func show_damage():
	progress_bar.value -=  1.0/3 * progress_bar.max_value


func _on_start_button_pressed():
	await get_tree().create_timer(0.5).timeout
	start_game.emit()
	$Initials.hide()
	$GameOver.hide()
	$InGame.show()
