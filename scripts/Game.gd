extends Node3D
@onready var camera = $Camera3D
@onready var level_generator = $LevelGenerator

var player_preload = preload("res://player.tscn" )
func _ready():
	MobileAds.initialize()
	new_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_B):
		level_generator.generate_level()
	
	
func new_game():
	
	if player_preload:
		var _player = player_preload.instantiate()
		#get_tree().current_scene.add_child(_player)
		add_child(_player)
		camera.setup_camera(_player)

