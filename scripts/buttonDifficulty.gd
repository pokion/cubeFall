extends Button

signal ButtonPressed
var isPressed = false;
@export var styleNotPressed:StyleBoxFlat;
@export var stylePressed:StyleBoxFlat;

func chagneIsPressed():
	if isPressed:
		self.add_theme_stylebox_override("normal", stylePressed);
		self.add_theme_stylebox_override("hover", stylePressed);
		self.add_theme_stylebox_override("pressed", stylePressed);
		self.add_theme_stylebox_override("disabled", stylePressed);
		self.add_theme_stylebox_override("focus", stylePressed);
	else:
		self.add_theme_stylebox_override("normal", styleNotPressed);
		self.add_theme_stylebox_override("hover", styleNotPressed);
		self.add_theme_stylebox_override("pressed", styleNotPressed);
		self.add_theme_stylebox_override("disabled", styleNotPressed);
		self.add_theme_stylebox_override("focus", styleNotPressed);

func _on_pressed():
	ButtonPressed.emit()
