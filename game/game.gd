extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const game_over = preload("res://game_over.tscn")
const win_screen = preload("res://win.tscn")
const beer = preload("res://beer.tscn")
onready var player = get_node("player")

func _ready():
	set_process(true)
	var enemy = get_node("enemy")
	enemy.target = get_node("player")
	enemy.nav = get_node("nav")
	var map = get_node("nav/map")
	player.tilemap = map
	player.tilesize = 32
	
	enemy.connect("game_over", self, "_game_over")
	
	var x = 0
	var y = 0
	var used_rect = map.get_used_rect()
	print(map.get_cell_size() / 2)
	for x in range(used_rect.pos.x, used_rect.size.x):
		for y in range(used_rect.pos.y, used_rect.size.y):
			if map.get_cell(x, y) == 0:
				continue
			var new_beer = beer.instance()
			new_beer.set_pos(map.map_to_world(Vector2(x, y)) + (map.get_cell_size() / 2))
			new_beer.player = player
			get_node("beers").add_child(new_beer)

func _process(delta):
	get_node("collected").set_text("Collected: %d/%d" % [player.beers, player.total_beers])
	if (player.beers == player.total_beers):
		get_tree().get_root().add_child(win_screen.instance())
		queue_free()

func _game_over():
	get_tree().get_root().add_child(game_over.instance())
	queue_free()

