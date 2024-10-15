extends Node

func removeAllObjectInSceneFromArray(arrayOfObject: Array) -> void:
	for object in arrayOfObject:
		object.queue_free();

func removeFromArray(objectToRemove: Array, formArray: Array):
	for object in objectToRemove:
		formArray.erase(object);
