extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/difficulty_menu.tscn");
