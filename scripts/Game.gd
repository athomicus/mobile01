extends Node3D
@onready var camera = $Camera3D
@onready var level_generator = $LevelGenerator
var player 
var player_preload = preload("res://player.tscn" )
func _ready():
	MobileAds.initialize()
	#new_game()
	GameEvents.connect("start_new_game",Callable(self,"new_game"))
	


	
func new_game():
	
	reset_game()
	if player_preload:
		var _player = player_preload.instantiate()
		#get_tree().current_scene.add_child(_player)
		add_child(_player)
		
		_player.position.y = camera.position.y
		camera.setup_camera(_player)
		player=_player

func reset_game():
	if player!= null:
		player.queue_free()
