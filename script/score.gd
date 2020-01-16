extends Node2D

var winner
func score():
	show()
	if utils.p1_points>=utils.p2_points:
		winner = 'p1'
	elif utils.vs_cpu:
		winner = 'computer'
	else:
		winner = 'p2'
	
	$test/you.text = winner+' win'
		

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_home_pressed():
	get_tree().change_scene("res://scene/main.tscn")