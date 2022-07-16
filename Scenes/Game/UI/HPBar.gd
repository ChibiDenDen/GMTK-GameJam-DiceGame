extends ProgressBar


func _on_player_health_changed(new_hp):
	value = new_hp


func _on_player_max_health_set(max_hp, set_full=false):
	max_value = max_hp
	if set_full:
		value = max_hp
