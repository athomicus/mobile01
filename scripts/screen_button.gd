extends TextureButton
class_name ScreenButton

signal clicked(button)

func _on_pressed():
	print("play")
	clicked.emit(self)
