extends CanvasLayer

signal reinicia

@onready var timer_jogo: Timer = $"../TimerJogo"
@export var texto: Label

func _on_button_pressed() -> void:
	emit_signal("reinicia")

func _process(delta: float) -> void:
	texto.text = ("TEMPO: " + str(int(timer_jogo.time_left)))
