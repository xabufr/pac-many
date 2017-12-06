extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player

func _ready():
	player.total_beers += 1
	self.connect("body_enter", self, "_on_body_enter")

func _on_body_enter(other):
	if other == player:
		player.beers += 1
		queue_free()
