extends Node2D

const cena_crocodilo = preload("res://Cenas/crocodilo.tscn")
var pistas_rapidas_y = [104, 272, 488]
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600]
var score = 0
var score_p1 = 0
var score_p2 = 0

func _ready():
	$HUD/Placar01.text = str(score)
	$HUD/Placar02.text = str(score)
	$HUD/Mensagem.text = " "
	$HUD/Button.hide()
	$AudioTema.play()
	randomize()
	

func _on_timer_croc_rapidos_timeout() -> void:
	var crocodilo = cena_crocodilo.instantiate()
	add_child(crocodilo)
	var pista_y = pistas_rapidas_y [randi_range(0, pistas_rapidas_y.size() -1)]
	crocodilo.position = Vector2 (1290, pista_y) #nascimento de crocodilo lado direito
	crocodilo.linear_velocity = Vector2(randf_range(-700.0, -710.0), 0.0) # movimentação direita pra esquerda
	crocodilo.linear_damp = 0.0
	crocodilo.animacao.flip_v = true #flip de direção do sprite
	


func _on_timer_croc_lentos_timeout() -> void:
	var crocodilo = cena_crocodilo.instantiate()
	add_child(crocodilo)
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() -1)]
	crocodilo.position = Vector2(-10, pista_y)
	crocodilo.linear_velocity = Vector2(randf_range(300.0, 310.0), 0.0)
	crocodilo.linear_damp = 0.0

func pontua() -> void:
	if score_p1 <= 2 or score_p2 <= 2:
		$AudioPonto.play()
	if score_p1 == 2 or score_p2 == 2:
		$HUD/Button.show()
		$TimerCrocRapidos.stop()
		$TimerCrocLentos.stop()
		$AudioTema.stop()
		$AudioVitoria.play()
		$TimerJogo.stop()
		$Player.speed = 0
		$Player2.speed = 0
		$Player2.position = $Player2.posicao_inicial
		$Player.position = $Player.posicao_inicial
	if score_p1 == 2:
		$HUD/Mensagem.text = "O Sapo do Bem ganhou!"
	if score_p2 == 2:
		$HUD/Mensagem.text = "O Sapo das Trevas ganhou!"
	

func _on_hud_reinicia() -> void:
	score_p1 = 0
	score_p2 = 0
	$Player.speed = 150.0
	$Player2.speed = 150.0
	$HUD/Mensagem.text = " "
	$HUD/Placar01.text = str(score)
	$HUD/Placar02.text = str(score)
	$HUD/Button.hide()
	$TimerCrocRapidos.start()
	$TimerCrocLentos.start()
	$AudioTema.play()
	$TimerJogo.start()


func _on_player_pontua_1() -> void:
	$Player.position = $Player.posicao_inicial
	score_p1 += 1
	$HUD/Placar01.text = str(score_p1)
	$AudioPonto.play()
	pontua()


func _on_player_2_pontua_2() -> void:
	$Player2.position = $Player2.posicao_inicial
	score_p2 += 1 
	$HUD/Placar02.text = str(score_p2)
	$AudioPonto.play()
	pontua()


func _on_timer_jogo_timeout() -> void:
	score = 0
	$HUD/Mensagem.text = "Acabou o tempo! Você é MUITO RUIM!"
	$HUD/Button.show()
	$TimerCrocRapidos.stop()
	$TimerCrocLentos.stop()
	$AudioTema.stop()
	$AudioVitoria.play()
	$TimerJogo.stop()
	$Player.speed = 0
	$Player2.speed = 0
	$Player2.position = $Player2.posicao_inicial
	$Player.position = $Player.posicao_inicial
