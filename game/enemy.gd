extends Node2D
signal game_over
const VELOCITY = 30

var target
var nav
var last_update
var current_nav


func _ready():
	set_fixed_process(true)
	get_node("collision").connect("body_enter", self, "_on_collision_area_enter")
	last_update = 0
	
func _fixed_process(delta):
	
	last_update -= delta
	if last_update <= 0:
		last_update = 0.1
		compute_nav()
	if current_nav.size() > 0:
		move_toward(current_nav[0], delta)
		if get_pos().distance_squared_to(current_nav[0]) <= 4:
			current_nav.remove(0)

func compute_nav():
	var target_pos = target.get_pos()
	current_nav = nav.get_simple_path(get_pos(), target_pos, false)

func move_toward(new_pos, delta):
	var pos = get_pos()
	var diff = new_pos - pos
	set_pos(pos + (diff.normalized() * delta * VELOCITY))

func _on_collision_area_enter(other):
	if other == target:
		emit_signal("game_over")
