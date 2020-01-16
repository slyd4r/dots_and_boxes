extends Node2D

var p1 = Color(1,0,0)
var p2 = Color(0,1,0)
var sides=0
onready var main = get_node('..')
var lines = []
var empty_lines =[]
func _ready():
	utils.connect("cpu_play",self,"check_colliders")
	$Sprite.modulate = p2
	$"1".connect("area_entered",self,'add_one')
	$"2".connect("area_entered",self,'add_one')
	$"3".connect("area_entered",self,'add_one')
	$"4".connect("area_entered",self,'add_one')

func calculate_best():
	if utils.game_finished:
		return
	var best_options=[]
	var best_side=utils.cpu_options[0].sides
	var worst_side = best_side
	var best_obj = utils.cpu_options[0].object
	var worst_obj = best_obj
	for side in utils.cpu_options:
		if side.object.empty_lines.size()>0:
			if side.sides==3:
				best_obj = side.object
				best_side = 3
				best_options.append(best_obj)
				break
			elif side.sides>0 and side.sides !=2 :
				best_obj = side.object
				best_side = side.sides
				best_obj = side.object
				best_options.append(best_obj)
				
			elif best_side !=3 and best_side !=2 and best_options.size()==0:
				best_side = side.sides
				best_obj = side.object
				best_options.append(best_obj)
			else:
				pass
	
	randomize()
	for side in best_options:
		if side.empty_lines.size() ==1:
			best_options=[side]
			break
		
	best_options[randi()%best_options.size()-1].get_non_collider()
	#best_obj.get_non_collider()
func get_non_collider():
	empty_lines[0].draw()
func check_colliders():
	if utils.cpu_options.size() >= utils.grid_size:
		utils.cpu_options = []
	else:
		utils.cpu_options.append({'object':self,'sides':sides})
	if utils.cpu_options.size() == utils.grid_size:
		calculate_best()
func done():
	$Sprite.show()
	if utils.turn =='p1':
		utils.p1_points+=1
		$Sprite.modulate=p1
	else:
		utils.p2_points+=1

func add_one(body):
	if body.name !='collide':
		lines.append(body.get_parent())
		empty_lines.append(body.get_parent())
		return
	else:
		empty_lines.erase(body.get_parent())
	add(body.get_parent())
func add(body):
	sides+=1
	if sides >=4:
		done()	
		body.colided(true)
	else:
		body.colided(false)
		
		