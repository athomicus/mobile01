extends Node3D
class_name LevelGenerator
var platformScene = preload("res://platform.tscn")
@onready var platformParent = $PlatformParent
@onready var camera = $"../Camera3D"


var level_size = 50
var viewPortSize
var viewportTo2D
var pos_right_down 
var pos_left_down 
var pos_left_up 
var pos_right_up
var distanceY_between_platforms  
const x_distance_from_platforms = 1.7 
const platform_amount = 8
var start_platform_position_y 
#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and event.is_pressed():
#		print(event.position)


# Called when the node enters the scene tree for the first time.
func _ready():
		GameEvents.connect("player_close_build_additional_platforms",Callable(self,"generate_level"))
		viewPortSize = get_viewport().get_visible_rect().size #okno w px np cellphone
		
		pos_right_down = camera.project_position(viewPortSize,6) # prawy dolny rog gdzie patrzy cam
		pos_left_down = camera.project_position( Vector2(0,viewPortSize.y), 6)
		pos_left_up = camera.project_position( Vector2(0,0), 6)
		pos_right_up = camera.project_position( Vector2(viewPortSize.x, 0), 6)
		distanceY_between_platforms = absf(pos_left_down.y - pos_left_up.y) / platform_amount # oblicz dyst pomiedzy bloczkami
		start_platform_position_y = pos_right_down.y + distanceY_between_platforms #pierwsza platf po y
		#print(distanceY_between_platforms)
		#create_platform( pos_left_down )
		#create_platform( pos_right_down )
		#create_platform( pos_left_up )
		#create_platform( pos_right_up )
		
		generate_ground(pos_left_down,pos_right_down)
		generate_level()
		
		
		#var max_platform_pos = viewportTo2D.x - 1.0
		#var min_platform_pos = -viewportTo2D.x + 1.0 
		#create_platform(Vector3(min_platform_pos,0,0)) 
		#create_platform(Vector3(max_platform_pos,0,0)) 
		
		#create_platform(Vector3(-3,0,0)) 
		#create_platform(Vector3(3,0,0)) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func create_platform(location: Vector3):
	
	#print(location)
	var _platform = platformScene.instantiate()
	platformParent.add_child(_platform)
	_platform.global_position = location
	return _platform
	
func generate_ground(start_point: Vector3 , end_point: Vector3):
		while(start_point.x < end_point.x + x_distance_from_platforms):
			create_platform(start_point)
			start_point.x += x_distance_from_platforms

func convert_v2_to_v3(vec2:Vector2):
	var vec3
	vec3.x = vec2.x
	vec3.y = vec2.y
	vec3.z = 0
	return vec3
	

func generate_level():
	
	var pos: Vector3
	pos.y = start_platform_position_y
	for i in range(level_size):
		pos.x = randf_range(pos_left_down.x,pos_right_down.x)
		pos.y =  pos.y + distanceY_between_platforms 
		create_platform(pos)
	start_platform_position_y = pos.y 
 
 
