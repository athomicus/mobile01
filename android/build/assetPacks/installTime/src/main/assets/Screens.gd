extends CanvasLayer
 
@onready var consol_log = $Debug/ConsolLog
@onready var label = $Debug/ConsolLog/ScrollContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	consol_log.visible = false
	
	GameEvents.connect("debug_log_signal",Callable(self,"debugLog"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	consol_log.visible = !consol_log.visible

func debugLog(message):
	if label:
		label.text += "\n"
		label.text += message
	
	
