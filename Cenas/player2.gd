extends Area2D

signal pontua2
signal pontua
@export var speed: float = 150.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(840, 690)

func _ready():
	screen_size = get_viewport_rect().size
	position = posicao_inicial
	modulate = Color.RED
	
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("W"):
		velocity.y -= 1
	if Input.is_action_pressed("S"):
		velocity.y += 1
	if Input.is_action_pressed("A"):
		velocity.x -= 1
	if Input.is_action_pressed("D"):
		velocity.x += 1
		
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.y = clamp (position.y, 0.0, screen_size.y)
	
	if velocity.y > 0:
		$Animacao.play("baixo")
	elif velocity.y < 0:
		$Animacao.play("cima")
	elif velocity.x > 0:
		$Animacao.play("direita")
	elif velocity.x < 0:
		$Animacao.play("esquerda")
	else:
		$Animacao.stop()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "LinhaChegada":
		emit_signal("pontua2")
	else:
		$Audio.play()
		position = posicao_inicial
