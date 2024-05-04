extends Camera3D
#chcemy by kamera poruszala sie za graczem


var player: Player = null
var previousPlayerPos = 0.0
@onready var destroyer = $Destroyer
@onready var collision_shape_3d = $Destroyer/CollisionShape3D

	
# Called when the node enters the scene tree for the first time.
func _ready():
	destroyer.area_entered.connect(_on_area_entered)
	#setup_camera($"../Player")
	pass # Replace with function body.


func _on_area_entered(area):
	#if area is Platform:  #w Platform dodane jest class_name Platform
	#	print("jest Platfrom")
	if area.is_in_group("PlatformGroup"):
		area.queue_free()

#
#func _process(delta):
#	var overlaping_areas = destroyer.get_overlapping_areas()
#	if overlaping_areas.size() > 0:
#		for area in overlaping_areas:
#			if area is Platform:
#				area.queue_free()


func setup_camera(_player: Player):
	if _player != null:
		player = _player

func _physics_process(delta):
	if player:
		
		global_position.y = previousPlayerPos #camera dont go down
		if player.global_position.y > previousPlayerPos:
			previousPlayerPos = player.global_position.y

