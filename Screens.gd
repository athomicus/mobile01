extends CanvasLayer
 
@onready var consol_log = $Debug/ConsolLog

# Called when the node enters the scene tree for the first time.
func _ready():
	consol_log.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	consol_log.visible = !consol_log.visible
