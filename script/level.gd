extends Node2D

var grid_size = Vector2(16,16)
var grid = []
var center_scn = preload("res://scene/center.tscn")
var line_scn  =preload("res://scene/line.tscn")
onready var time_map = $TileMap

func change_player():
	var origin_scale = Vector2.ONE
	var new_s = Vector2.ONE*1.4
	$background/player2.scale = new_s
	$background/player1.scale = origin_scale
	if utils.turn == utils.p1:
		$background/player1.scale = new_s
		$background/player2.scale = origin_scale

func game_finished():
	$score.score()
	get_tree().paused = true
	$score.show()
func player_changed():
	if utils.p1_points+utils.p2_points >=utils.grid_size:
		utils.game_finished =true
		utils.emit_signal("game_finished")
	$background/player1/label.text = str(utils.p1_points)
	$background/player2/label.text = str(utils.p2_points)
func _ready():
	if utils.vs_cpu:
		$background/player2/name.text = 'com'
	utils.connect("game_finished",self,'game_finished')
	utils.connect("changed_points",self,"player_changed")
	utils.connect("player_changed",self,"change_player")
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var sizex=time_map.get_cell_size().x
	var sizey=time_map.get_cell_size().y
	var tile_set = time_map.tile_set
	var used_tiles = time_map.get_used_cells()
	for pos in used_tiles:
		var id = time_map.get_cell(pos.x,pos.y)
		var _name = tile_set.tile_get_name(int(id))
		if _name == 'center':
			var center = center_scn.instance()
			center.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey+sizey/2)
			center.z_index = 5
			add_child(center)
			var line = line_scn.instance()
			line.position = Vector2(pos.x*sizex,pos.y*sizey+sizey/2)
			add_child(line)
			var line2 = line_scn.instance()
			line2.position = Vector2(pos.x*sizex+sizex,pos.y*sizey+sizey/2)
			add_child(line2)
			var line3 = line_scn.instance()
			line3.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey)
			line3.rotation=-PI/2
			add_child(line3)
			var line4 = line_scn.instance()
			line4.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey+sizey)
			line4.rotation=PI/2
			add_child(line4)
		elif _name == 'middle':
			var center = center_scn.instance()
			center.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey+sizey/2)
			center.z_index = 5
			add_child(center)
		else:
			var center = center_scn.instance()
			center.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey+sizey/2)
			center.z_index = 5
			add_child(center)
			var rot = PI/2
			
			var line3 = line_scn.instance()
			line3.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey)
			line3.rotation=rot
			add_child(line3)
			var line4 = line_scn.instance()
			line4.position = Vector2(pos.x*sizex+(sizex/2),pos.y*sizey+sizey)
			
			add_child(line4)
			if not time_map.is_cell_x_flipped(pos.x,pos.y):
				rot = PI
				line4.position = Vector2(pos.x*sizex,pos.y*sizey+sizey/2)
				line3.position = Vector2(pos.x*sizex+sizex,pos.y*sizey+sizey/2)

			line4.rotation=rot
			line3.rotation=rot


func _on_home_pressed():
	get_tree().change_scene("res://scene/main.tscn")