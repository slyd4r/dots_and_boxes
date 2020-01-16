extends Node

var turn = 'p1' setget change_players
var game_type = 'p_vs_cpu' #'p_vs_p'
var p1 = 'p1'
var p2
var p1_points = 0 setget p1_points
var p2_points = 0 setget p2_points
var grid_size = 5*7
var cpu_options = []
var allow_touch = true
signal player_changed
signal changed_points
signal cpu_play
signal game_finished
var game_finished
var vs_cpu = false
func change_players(_player):
	turn = _player
	emit_signal("player_changed")
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			allow_touch = false
		else:
			allow_touch = true
func p1_points(_point):
	p1_points +=1
	emit_signal("changed_points")
func p2_points(_point):
	p2_points +=1
	emit_signal("changed_points")
	if vs_cpu:
		play_cpu()
func pvp():
	game_type = 'p_vs_p'
	p2 = 'p2'
func pvc():
	vs_cpu = true
	p2 = 'cpu'
func game_finished():
	emit_signal("game_finished")
func play_cpu():
	cpu_options = []
	yield(get_tree().create_timer(0.5),"timeout")
	if not game_finished:
		emit_signal("cpu_play")
func change_player():
	if turn == p1:
		change_players(p2)
		if vs_cpu:
			play_cpu()
	else:
		change_players(p1)
		
func reset():
	pass
