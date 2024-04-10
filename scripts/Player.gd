extends CharacterBody3D
@onready var camera = $"../Camera3D"

const SPEED = 10.0
var viewport_size


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	viewport_size = get_viewport().size
	#print(viewport_size)
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		

func _physics_process(delta):
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0 ,SPEED/10)
	move_and_slide()
	
	#global_transform.origin.x the same global_position.x
	#var playerScreenPos = camera.unproject_position(global_position) #take 3d Object position from screen
	#camera.project_position(viewport_size,6) - get viewport(edge) to world position (global_position)
	
	var player_pos_from_viewport = camera.project_position(viewport_size,6) 
	global_position.x = wrapf(global_position.x, -player_pos_from_viewport.x, player_pos_from_viewport.x)

	#if global_position.x > player_pos_from_viewport.x:
	#	global_position.x = -player_pos_from_viewport.x
	#if global_position.x < -player_pos_from_viewport.x:
	#	global_position.x = player_pos_from_viewport.x
	

