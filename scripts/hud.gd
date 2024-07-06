extends CanvasLayer

@onready var progress_bar = $InGame/HealthBar/ProgressBar


# func _ready():
# 	_update_progress_bar_color(progress_bar.value)


func update_silver(silver):
	$InGame/Silver.text = str(silver)

func update_gold(gold):
	$InGame/Gold.text = str(gold)

func update_diamond(diamond):
	$InGame/Diamond.text = str(diamond)

func show_damage():
	progress_bar.value -=  1.0/3.1 * progress_bar.max_value 

	if progress_bar.value == 100:
		# set color to green
		pass
	elif progress_bar.value < 67:
			# set color to yellow 
			pass
	elif progress_bar.value < 34:
			# set color to red 
			pass
			
# func _update_progress_bar_color(value):
# 	var r = lerp(value / progress_bar.max_value, 1.0, 0.0) # Interpolates from 1 to 0 based on value
# 	var g = lerp(value / progress_bar.max_value, 0.0, 1.0) # Interpolates from 0 to 1 based on value
# 	var style_box = progress_bar.get("custom_styles/fg")

# 	if style_box != null:
# 			style_box.bg_color = Color(r, g, 0)
# 	else:
# 			print("StyleBox is null. Make sure 'custom_styles/fg' is properly assigned.")
