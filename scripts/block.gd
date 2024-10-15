extends Area2D

signal boxPressed(node, state);
signal removeNode(node);

var animalNumber = null;
var styleNotPressed = preload("res://boxStyleNotPressed.tres");
var stylePressed = preload("res://boxStylePressed.tres");
var isPressed = false;
var isImpossible = false;
var impossiblePressed = false;

func _on_button_pressed():
	if isImpossible and impossiblePressed == false:
		impossiblePressed = true;
		$hiddenLayer.visible = false;
		return;
	if(isPressed):
		setStyleBoxToNotPressed()
	else:
		$AnimalImage/Panel.add_theme_stylebox_override("panel", stylePressed);
	isPressed = !isPressed
	boxPressed.emit(self, isPressed)
	
func getSize() -> Vector2:
	return $AnimalImage.get_rect().size;
	
func setImage(texture: Texture2D):
	$AnimalImage.set_texture(texture);
	
func setStyleBoxToNotPressed():
	$AnimalImage/Panel.add_theme_stylebox_override("panel", styleNotPressed);
	
func setImpossibleDifficulty():
	isImpossible = true;
	$hiddenLayer.visible = true;
	
func _exit_tree():
	removeNode.emit(self);
