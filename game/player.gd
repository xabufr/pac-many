extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var loc
var mov = Vector2(0, 0)
var velocity = 300
var tilemap
var tilesize
var half_size
var next_pos
var total_beers = 0
var beers = 0

func _ready():
	set_fixed_process(true)
	half_size = get_node("tete").get_region_rect().size / 2
	next_pos = get_pos()

func _fixed_process(delta):
	var map_pos = tilemap.world_to_map(get_pos())
	
	mov.x = 0
	mov.y = 0
	loc = get_pos()
	if Input.is_action_pressed("ui_down") and tilemap.get_cell(map_pos.x, map_pos.y + 1) == 1:
		map_pos.y += 1
	elif Input.is_action_pressed("ui_up") and tilemap.get_cell(map_pos.x, map_pos.y - 1) == 1:
		map_pos.y -= 1
	elif Input.is_action_pressed("ui_right") and tilemap.get_cell(map_pos.x + 1, map_pos.y) == 1:
		map_pos.x += 1
	elif Input.is_action_pressed("ui_left") and tilemap.get_cell(map_pos.x - 1, map_pos.y) == 1:
		map_pos.x -= 1

	next_pos = tilemap.map_to_world(map_pos) + Vector2(tilesize / 2, tilesize / 2)
	var mov = (next_pos - get_pos()).normalized() * velocity * delta
	self.move(mov)
	if (get_pos().distance_squared_to(next_pos)) <= 4:
		self.set_pos(next_pos)

