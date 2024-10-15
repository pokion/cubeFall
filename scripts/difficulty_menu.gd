extends Control

var buttons;
@onready var Settings = get_node("/root/Settings");

func _ready():
	buttons = [$CenterContainer/VBoxContainer/impossible,$CenterContainer/VBoxContainer/hard,$CenterContainer/VBoxContainer/medium,$CenterContainer/VBoxContainer/easy];
	for button in buttons:
		if button.name == Settings.getCurrentDifficulty():
			button.isPressed = true;
			#button.chagneIsPressed();
		else:
			button.isPressed = false


func _on_button_pressed(name):
	Settings.setDifficulty(name);
	for button in buttons:
		if button.name != Settings.getCurrentDifficulty():
			button.isPressed = false
			#button.chagneIsPressed();
		else:
			button.isPressed = true



func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/gameScene.tscn");
