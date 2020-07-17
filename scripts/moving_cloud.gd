extends Sprite

export var speed: int = 0

func _process(delta):
	if (self.position.x < -100):
		self.position.x = 300
	else: self.position.x -= delta * speed
