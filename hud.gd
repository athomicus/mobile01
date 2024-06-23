extends Control


@onready var topbar = $TopBar
@onready var topbar_bckgr = $ColorRectBckgr

func _ready():
	var os_name =  OS.get_name()
	if os_name =="Android" || os_name == "iOS":
		var safe_area = DisplayServer.get_display_safe_area()
		var safe_area_top = safe_area.position.y # odleglosc w telefonie od gornej krawedzi ekranu by np. nie dac UI w camere
		topbar.position.y += safe_area_top
		var margin = 10
		topbar_bckgr += safe_area_top + margin

		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_button_pressed():
	print("pause")
	pass # Replace with function body.
