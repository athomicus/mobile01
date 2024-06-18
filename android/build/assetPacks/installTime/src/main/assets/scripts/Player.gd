extends CharacterBody3D
class_name Player
@onready var camera = $"../Camera3D"

@onready var animator = $AnimationPlayer
var jump_velocity = 25.0
var use_accelometer = false

const SPEED = 10.0
var accelometer_speed = 3
var viewport_size
var gravity = 1.0
var max_fall_velocity = -10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	#viewport_size = get_viewport().size #for Camera -  na komorce nie dziala!
	viewport_size = get_viewport().get_visible_rect().size
	# check if we are on mobile or pc - turn on/off get pos from accelerator
	var os_name = OS.get_name() # OS - Operating System
	if os_name == "Android" || os_name == "iOS":
		use_accelometer = true
		
	
	
	
func _process(delta):
	
		
	#if Input.is_key_pressed(KEY_SPACE):
	#	jump()
		
	if Input.is_action_just_pressed("Jump"):
		jump()
func _physics_process(delta):
	
	play_animation_player()
	
	velocity.y -= gravity 
	if velocity.y < max_fall_velocity:
		velocity.y = max_fall_velocity #przelatuje
		
	if use_accelometer:
		var mobile_input = Input.get_accelerometer()
		velocity.x = mobile_input.x * accelometer_speed
		#print(str(mobile_input))
	else:
		var direction = Input.get_axis("move_left","move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0 ,SPEED/10)
	move_and_slide()
	
	#global_transform.origin.x the same global_position.x
	# 
	#grab 3d object position from screen, out: positionm in screen pixel np 320x240
	#var playerScreenPos : Vector2D = camera.unproject_position(global_position)
	#
	#                         Vector2D     z
	#camera.project_position(viewport_size,6) - get viewport(edge) to world position (global_position)
	#
	
	#przerzucaj gracza lewo/prawo gdy wyleci po za ekran
	var player_pos_from_viewport = camera.project_position(viewport_size,6) 
	#player_pos_from_viewport   = 3d point gdzie patrzy camera
	#print (player_pos_from_viewport)
	global_position.x = wrapf(global_position.x, -player_pos_from_viewport.x, player_pos_from_viewport.x)

	#if global_position.x > player_pos_from_viewport.x:
	#	global_position.x = -player_pos_from_viewport.x
	#if global_position.x < -player_pos_from_viewport.x:
	#	global_position.x = player_pos_from_viewport.x
func jump():
	velocity.y = jump_velocity
	GameEvents.emit_signal("debug_log_signal","Player Jumped!")

func play_animation_player():
	if velocity.y > 0:
		if animator.current_animation != "jump":
			animator.play("jump")
	elif velocity.y < 0:
		if animator.current_animation != "stay":
			animator.play("stay")
	
