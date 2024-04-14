extends Camera3D
#chcemy by kamera poruszala sie za graczem

var player: Player = null
var previousPlayerPos = 0.0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setup_camera($"../Player")
	pass # Replace with function body.


func setup_camera(_player: Player):
	if _player != null:
		player = _player

func _physics_process(delta):
	if player:
		
		global_position.y = previousPlayerPos #camera dont go down
		if player.global_position.y > previousPlayerPos:
			previousPlayerPos = player.global_position.y
