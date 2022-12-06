extends Sprite

var monster_textures = [
	preload("res://assets/sprites/monster1.png"),
	preload("res://assets/sprites/monster2.png"),
	preload("res://assets/sprites/monster3.png"),
	preload("res://assets/sprites/monster4.png")
]

func _ready():
	var rand_texture = randi() % monster_textures.size()
	texture = monster_textures[rand_texture]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
