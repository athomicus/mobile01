extends CanvasLayer
 
@onready var consol_log = $Debug/ConsolLog
@onready var label = $Debug/ConsolLog/ScrollContainer/VBoxContainer/Label
@onready var title_screen = $TitleScreen
@onready var game_over_screen = $GameOverScreen
@onready var generated_level = $"../Game/LevelGenerator"
@onready var hud = get_parent().get_node("Game/UI/HUD")
 

var current_screen 

# Called when the node enters the scene tree for the first time.
func _ready():
	consol_log.visible = false
	GameEvents.connect("debug_log_signal",Callable(self,"debugLog"))
	GameEvents.connect("player_died",Callable(self,"_show_game_over_screen"))
	register_buttons()
	
	#STRART GAME - EVERYTHING IS NOT VISIBLE
	title_screen.appear()
	hud.visible = false
	generated_level.visible = false
	current_screen = title_screen



func _on_texture_button_pressed():
	consol_log.visible = !consol_log.visible

func debugLog(message):
	if label:
		label.text += "\n"
		label.text += message
	
	
func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons") #get asll the screen buttons in array
	if buttons.size() > 0:
		for b in buttons:
			if b is ScreenButton:
				b.clicked.connect(_on_button_pressed)
				
func _on_button_pressed(button):
	#button.disappear()
	print(button.name)
	match button.name:
		"TitleScreenButton":
			dissapear_title_and_start_new_game()
			
		"GameOverButton":
			change_screen(title_screen)
			
func dissapear_title_and_start_new_game():
	if current_screen != null:
		var disappear_tween = current_screen.disappear()
		await (disappear_tween.finished)
		hud.visible = true
		generated_level.visible = true
		GameEvents.start_new_game.emit()

	

func change_screen(new_screen):
	
	
	if current_screen != null:
		var disappear_tween = current_screen.disappear()
		await (disappear_tween.finished)

	current_screen = title_screen
	if current_screen!=null:
		var appear_tween = current_screen.appear()
		await(appear_tween.finished)
		#print( "wlaczamy przyciski")
		get_tree().call_group("buttons","set_disabled",false) #wlacz 
		
func _show_game_over_screen():
	current_screen=game_over_screen
	hud.visible = false
	var app_tween = game_over_screen.appear()
	await(app_tween.finished)
		 