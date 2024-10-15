extends Node2D

@export var blockLoad: PackedScene;
@export var images: Array[Texture2D];

@onready var Utils = get_node("/root/Utils");
@onready var Settings = get_node("/root/Settings");

var settings = {
	SPEED = 20,
	POINTS = 0,
	HEALTH = 3,
	MAX_ANIMAL = 2,
	SPEED_ADDED = 10,
	SPEED_ADDED_THRESHOLD = 20,
	ANIMAL_THRESHOLD = 35,
	IMPOSSIBLE_MODE = false
}

var STOP_GAME = false;

var block;
var blockSize;
var allBlocks = [];
var pressedNodes = [];
var allSpawners: Array;
var hearthNodes;
var amountOfAnimals = [];
var recentAddedAnimals = [];

func _ready():
	settings = Settings.getDifficultyObject();
	block = blockLoad.instantiate();
	blockSize = block.getSize();
	allSpawners = [$Spawner,$Spawner2,$Spawner3,$Spawner4,$Spawner5];
	hearthNodes = {
		0: $CanvasLayer/Heart,
		1: $CanvasLayer/Heart2,
		2: $CanvasLayer/Heart3
	};
	spawnRowOfBlocks();

func _physics_process(delta):
	if !STOP_GAME:
		moveObjects(allBlocks, delta)
		if allBlocks.size() == 0:
			spawnRowOfBlocks();
	
func _on_area_2d_area_exited():
	if !STOP_GAME:
		spawnRowOfBlocks();
	
#game Over
func _on_lost_area_area_entered(area):
	if settings.HEALTH > 0:
		removeHealth();
		Utils.removeFromArray([area], allBlocks);
		Utils.removeFromArray([area], pressedNodes);
		Utils.removeAllObjectInSceneFromArray([area]);
		return;
	if settings.HEALTH == 0:
		STOP_GAME = true;
		$CanvasLayer/GameOverLayer.setPoints(settings.POINTS);
		$CanvasLayer/GameOverLayer.visible = 1;
		
func _on_game_over_layer_try_again_button_pressed():
	STOP_GAME = false;
	amountOfAnimals.clear();
	restartGame();
	$CanvasLayer/GameOverLayer.visible = 0;
	
func _on_node_remove(node):
	removeAnimalFromArrayAmount(node.animalNumber);

func spawnRowOfBlocks():
	for i in 5:
		var randBlock = createBlockWithRandomImage(Vector2(allSpawners[i].position), settings.MAX_ANIMAL);
		allBlocks.push_front(randBlock);
		self.call_deferred("add_child", randBlock);

func createBlockWithRandomImage(poss: Vector2, maxNumber: int):
	var newBlock = block.duplicate();
	if settings.IMPOSSIBLE_MODE:
		newBlock.setImpossibleDifficulty();
	var randomImageIndex = checkIfAllAnimalsHaveGroup(randi_range(0, maxNumber));
	recentAddedAnimals.append(randomImageIndex);
	addAnimalToArray(randomImageIndex);
	newBlock.setImage(images[randomImageIndex]);
	newBlock.animalNumber = randomImageIndex;
	newBlock.boxPressed.connect(handlePressingBoxes);
	newBlock.removeNode.connect(_on_node_remove);
	newBlock.position = poss;
	return newBlock;
	
func removeAnimalFromArrayAmount(indexOfAnimal: int) -> void:
	for animalAmount in amountOfAnimals:
		if animalAmount.index == indexOfAnimal:
			animalAmount.amount -= 1;
	
func addAnimalToArray(indexOfAnimal: int) -> void:
	if recentAddedAnimals.size() > 3:
		recentAddedAnimals.clear();
	var added = false;
	for animalAmount in amountOfAnimals:
		if animalAmount.index == indexOfAnimal:
			animalAmount.amount += 1;
			added = true;
	if !added:
		amountOfAnimals.append({"index": indexOfAnimal, "amount": 1});
	
func checkIfAllAnimalsHaveGroup(randomNumber: int) -> int:
	if amountOfAnimals.size() > 0:
		for animalAmount in amountOfAnimals:
			if animalAmount.amount < 3 and recentAddedAnimals.find(animalAmount.index) == -1:
				return animalAmount.index;
	return randomNumber;
	
func handlePressingBoxes(node, state):
	if !state:
		pressedNodes.remove_at(pressedNodes.find(node));
	else:
		if pressedNodes.size() > 0 and pressedNodes[0].animalNumber != node.animalNumber:
			node.setStyleBoxToNotPressed()
		else:
			pressedNodes.append(node);
	if pressedNodes.size() > 2:
		Utils.removeAllObjectInSceneFromArray(pressedNodes);
		Utils.removeFromArray(pressedNodes, allBlocks);
		pressedNodes.clear();
		addAndDisplayPoints(1);
	
func moveObjects(arrayOfObject: Array, delta: float) -> void :
	for object in arrayOfObject:
		if is_instance_valid(object):
			object.position += Vector2(0,1 * settings.SPEED * delta)

func addAndDisplayPoints(points: int) -> void:
	settings.POINTS = settings.POINTS + points;
	if settings.POINTS % settings.SPEED_ADDED_THRESHOLD == 0:
		settings.SPEED += settings.SPEED_ADDED;
	if settings.POINTS % settings.ANIMAL_THRESHOLD == 0:
		settings.MAX_ANIMAL += 1;
		if settings.MAX_ANIMAL > images.size():
			settings.MAX_ANIMAL = images.size() - 1;
	$CanvasLayer/Points.text = str(settings.POINTS);
	
func setPoints(points: int) -> void:
	settings.POINTS = points;
	$CanvasLayer/Points.text = str(settings.POINTS);
	
func removeHealth() -> void:
	settings.HEALTH = settings.HEALTH - 1;
	hearthNodes[settings.HEALTH].visible = 0
	
func setHealth(health: int) -> void:
	settings.HEALTH = health;
	for node in health - 1:
		if is_instance_valid(hearthNodes[node]):
			hearthNodes[node].visible = 1

func restartGame():
	Utils.removeAllObjectInSceneFromArray(allBlocks);
	allBlocks.clear();
	pressedNodes.clear();
	settings.MAX_ANIMAL = 2;
	settings.SPEED = 35;
	setHealth(3);
	setPoints(0);

