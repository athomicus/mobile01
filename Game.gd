extends Node3D

var platformScene = preload("res://platform.tscn")
@onready var platformParent = $PlatformParent
# Called when the node enters the scene tree for the first time.
func _ready():
	create_platform(Vector3(0,5,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
func create_platform(location: Vector3):
	var _platform = platformScene.instantiate()
	_platform.global_position = location
	platformParent.add_child(_platform)
