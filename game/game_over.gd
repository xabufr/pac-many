extends Node2D

const game = preload("res://game.tscn")

func _ready():
	get_node("Panel/try_again").connect("pressed", self, "try_again")

func try_again():
	get_tree().get_root().add_child(game.instance())
	queue_free()
