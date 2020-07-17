extends Sprite

onready var targetPositionBottom: Vector2 = Vector2(self.position.x, -5)
onready var targetPositionTop: Vector2 = Vector2(self.position.x, -10)
onready var goingDown: bool = true

func _ready():
	pass # Replace with function body.

func _process(delta):
	var speed: float = delta * 15
	var direction = 1 if goingDown else -1

	self.position.y +=  direction * speed
	
	if (self.position.y >= -5): goingDown = false
	if (self.position.y <= -8): goingDown = true
