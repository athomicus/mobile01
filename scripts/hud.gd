extends Control


@onready var topbar = $TopBar
@onready var topbar_bckgr = $ColorRectBckgr

func _ready():
	var os_name =  OS.get_name()
	if os_name =="Android" || os_name == "iOS":
		var safe_area = DisplayServer.get_display_safe_area()
		var safe_area_top = safe_area.position.y # odleglosc w telefonie od gornej krawedzi ekranu by np. nie dac UI w camere
		topbar.position.y += safe_area_top


		if os_name == "iOS":
			var screen_scale = DisplayServer.screen_get_scale()
			safe_area_top = (safe_area_top / screen_scale)

		GameEvents.emit_signal("debug_log_signal","Safe area:" + str(safe_area))
		GameEvents.emit_signal("debug_log_signal","Safe area top:" + str(safe_area_top))

		





# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_pause_button_pressed():
	print("pause")

