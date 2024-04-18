extends Node3D
var platformScene = preload("res://platform.tscn")
@onready var platformParent = $PlatformParent
var start_platform_y
var level_size = 50
var distance_between_platforms = 4.1 

# Called when the node enters the scene tree for the first time.
func _ready():
		generate_level(-5.5,true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func create_platform(location: Vector3):
	var _platform = platformScene.instantiate()
	platformParent.add_child(_platform)
	_platform.global_position = location
	return _platform
	
func generate_level(start_y: float, generate_ground:bool):
	var pos: Vector3 
	
	if generate_ground:
		pos.y = start_y
		pos.z = 0
		for p in range(14):
			pos.x = -10.4 + 1.7 * p
			create_platform(pos)
	
	pos.x = 0.0
	pos.z = 0.0
	for i in range(level_size):
		pos.x = randf_range(-3.5,3.5)
		pos.y = -3 + distance_between_platforms * i 
		create_platform(pos) 
