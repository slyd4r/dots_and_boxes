extends Node2D

#this demo was created by UnReal mohamed --@unrealmohamed --@slyd4r
func _on_play_with_com_pressed():
	utils.pvc()
	get_tree().change_scene("res://scene/level.tscn")

func _on_pvp_pressed():
	utils.pvp()
	get_tree().change_scene("res://scene/level.tscn")
