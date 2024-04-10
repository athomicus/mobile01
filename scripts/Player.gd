extends CharacterBody3D


const SPEED = 1.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0 ,SPEED/100)
	move_and_slide()
