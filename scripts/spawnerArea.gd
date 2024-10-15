extends Area2D

signal areaClear

func emitSignal(delta):
	if !has_overlapping_areas():
		areaClear.emit();
