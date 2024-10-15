extends Node

var difficulty = {
	"easy": {
		SPEED = 20,
		POINTS = 0,
		HEALTH = 3,
		MAX_ANIMAL = 2,
		SPEED_ADDED = 10,
		SPEED_ADDED_THRESHOLD = 20,
		ANIMAL_THRESHOLD = 35,
		IMPOSSIBLE_MODE = false
	},
	"medium": {
		SPEED = 35,
		POINTS = 0,
		HEALTH = 3,
		MAX_ANIMAL = 2,
		SPEED_ADDED = 15,
		SPEED_ADDED_THRESHOLD = 15,
		ANIMAL_THRESHOLD = 25,
		IMPOSSIBLE_MODE = false
	},
	"hard": {
		SPEED = 50,
		POINTS = 0,
		HEALTH = 1,
		MAX_ANIMAL = 2,
		SPEED_ADDED = 20,
		SPEED_ADDED_THRESHOLD = 10,
		ANIMAL_THRESHOLD = 20,
		IMPOSSIBLE_MODE = false
	},
	"impossible": {
		SPEED = 35,
		POINTS = 0,
		HEALTH = 3,
		MAX_ANIMAL = 2,
		SPEED_ADDED = 10,
		SPEED_ADDED_THRESHOLD = 10,
		ANIMAL_THRESHOLD = 20,
		IMPOSSIBLE_MODE = true
	},
};
var currentDifficulty = "easy";

func setDifficulty(difficulty: String):
	currentDifficulty = difficulty;
	
func getDifficultyObject():
	return difficulty[currentDifficulty];

func getCurrentDifficulty():
	return currentDifficulty;

