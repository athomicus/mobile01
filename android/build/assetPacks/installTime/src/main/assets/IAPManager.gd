extends Node

var google_payment = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"): #check czy istnieje taki singleton stworzony z pluginu
		google_payment = Engine.get_singleton("GodotGooglePlayBilling")
		GameEvents.emit_signal("debug_log_signal","Android IAP support is enabled")
		
		google_payment.connected.connect(_on_connected) #signal from plugin GodotGooglePlayBilling
		google_payment.startConnection() # when we recceive signal from google function _on_connected will be fired
		google_payment.connected_error.connect(_on_connect_error)
		google_payment.disconnected.connect(_on_diconnected)
		
		
	else:
		GameEvents.emit_signal("debug_log_signal","Android IAP support is not avaliable")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_connected():
	GameEvents.emit_signal("debug_log_signal","Connected with google")
	
func _on_connect_error(reponse_id,debug_msg):
	GameEvents.emit_signal("debug_log_signal","Connect error, reponse id:" + str(reponse_id) + " debug_msg:" + debug_msg)

func _on_diconnected():
	GameEvents.emit_signal("debug_log_signal","Disconnected with google")
