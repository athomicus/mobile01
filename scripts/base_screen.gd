extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	modulate.a = 0.0
	get_tree().call_group("buttons","set_disabled",true)
	#pass


func appear():
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a",1.0,0.5)
	return tween
	

func disappear():
	get_tree().call_group("buttons","set_disabled",true) #wylaczmy dostep do buttonow
	#visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a",0.0,0.5)
	return tween

