extends Node2D

var p1 = Color(1,1,0)
var p2 = Color(0,1,1)

onready var main = get_node('..')
var is_drawn = false
var colliders = 0
var done = false
func colided(_done):
	if _done == true:
		done = true
	colliders-=1
	if colliders <=0 && done:
		print('player done square ')
	elif colliders <=0:
		utils.change_player()
func _ready():
	$line.connect("area_entered",self,"collider_counts")
func collider_counts(body):
	var sides = ['1','2','3','4']
	for side in sides:
		if side == body.name:
			colliders+=1
func draw():
	is_drawn = true
	if utils.turn == utils.p1:
		$sprite_short.modulate = p1
	else:
		$sprite_short.modulate = p2
	$sprite_long.hide()
	$sprite_short.show()
	$collide.position.y=0
	
	#_on_Area2D_input_event()
func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and not is_drawn and not utils.allow_touch:
		if event.pressed:
			if not utils.vs_cpu:
				draw()
			elif utils.turn==utils.p1:
				draw()

func _on_Area2D_mouse_entered():
	if not is_drawn:
		$sprite_long.show()

func _on_Area2D_mouse_exited():
	$sprite_long.hide()
