extends Node

var google_payment = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"): #check czy istnieje taki singleton stworzony z pluginu
		google_payment = Engine.get_singleton("GodotGooglePlayBilling")
		GameEvents.emit_signal("debug_log_signal","Android IAP support is enabled")
	else:
		GameEvents.emit_signal("debug_log_signal","Android IAP support is not avaliable")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
