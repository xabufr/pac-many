extends Panel

const game = preload("res://game.tscn");

func _ready():
	get_node("btn").connect("pressed", self, "restart")

func restart():
	get_tree().get_root().add_child(game.instance())
	queue_free()