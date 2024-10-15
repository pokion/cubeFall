extends Control

signal TryAgainButtonPressed

func _on_try_again_button_pressed():
	TryAgainButtonPressed.emit();
	
func setPoints(points: int) -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/PointsLabel.text = str(points);
