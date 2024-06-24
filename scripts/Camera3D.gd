extends Camera3D
#chcemy by kamera poruszala sie za graczem
var count_of_platform_destroyed = 0
var score  = 0

########################################################################
#
#		TAKE PATH
#
########################################################################
@onready var hud = $"../UI/HUD" #OK
#@onready var hud = get_parent().get_node("UI/HUD")   #OK
#@onready var hud = get_node("/root/Main/Game/UI/HUD") #OK

########################################################################


var player: Player = null
var previousPlayerPos = 0.0
@onready var destroyer = $Destroyer
@onready var collision_shape_3d = $Destroyer/CollisionShape3D

	
# Called when the node enters the scene tree for the first time.
func _ready():
	destroyer.area_entered.connect(_on_area_entered)
	 
	#setup_camera($"../Player")
	hud.set_score(0)


func _on_area_entered(area):
	#if area is Platform:  #w Platform dodane jest class_name Platform
	#	print("jest Platfrom")
	if area.is_in_group("PlatformGroup"):
		count_of_platform_destroyed += 1
		score +=1
		hud.set_score(score)
		
		
		if count_of_platform_destroyed > 40:
			count_of_platform_destroyed = 0
			GameEvents.emit_signal("player_close_build_additional_platforms")
			#print("signal emmited" )
			
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

