extends RigidBody2D
@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D



func _ready():
	var tipos_crocodilo = animacao.sprite_frames.get_animation_names()
	var crocodilo = tipos_crocodilo[randi_range(0, tipos_crocodilo.size() - 1)]
	animacao.play("Crocodilo")
	

func _on_body_exited(body: Node) -> void:
	queue_free()
