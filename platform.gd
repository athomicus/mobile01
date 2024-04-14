extends Area3D

@onready var area_platform:Area3D = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	area_platform.body_entered.connect(_on_body_entered)

 
func _on_body_entered(body):
	
	if body.is_in_group("PlayerGroup"):
		body.jump()
		#print("Player Gruop")
	'''
	if body is Player:
		print("Player from class_name")
		#print(body.velocity.y)
		#if body.velocity.y < 0: # it means falling
   '''
		
