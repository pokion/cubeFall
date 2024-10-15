extends CPUParticles2D

@export var images: Array[Texture2D]

func _ready():
	self.texture = images.pick_random();


