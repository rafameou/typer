extends Node2D

var next = "res://menu_niveis.tscn"

var estrelas = []

#oh boy I wonder if theres an easy way to do this!
func t(n: int, tt:bool):
	if tt:
		if (g.tuto_bump > n):
			return
		g.tuto_bump = n
	else:
		if (g.nivel_bump > n):
			return
		g.nivel_bump = n

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize() #https://docs.godotengine.org/en/stable/tutorials/math/random_number_generation.html
	
	print("qnt_erros"); print(g.qnt_erros)
	print("qnt_erros_total"); print(g.qnt_erros_total)
	print("qnt_tecladas"); print(g.qnt_tecladas)
	print("qnt_tecladas_total"); print(g.qnt_tecladas_total)
	print("tempo_passado_seg"); print(g.tempo_passado_seg)
	print("tempo_passado_seg_total"); print(g.tempo_passado_seg_total)
	print("wpm"); print(g.wpm)
	print("wpm_total"); print(g.wpm_total)
	
	# estrelas -----------------------------------------------------------------
	
	estrelas = [
		get_node("PanelContainer/MarginContainer/star1"),
		get_node("PanelContainer/MarginContainer/star2"),
		get_node("PanelContainer/MarginContainer/star3"),
		get_node("PanelContainer/MarginContainer/star4"),
		get_node("PanelContainer/MarginContainer/star5")
	]
	
	var porc_acertos = (((float)(g.qnt_tecladas) - (float)(g.qnt_erros)) / (float)(g.qnt_tecladas)) * 5
	
	for i in porc_acertos: 
		estrelas[(int)(i)].frame = 2
		estrelas[(int)(i)].rotation = randfn(-10.0, 10.0)
	
	#imagina se tivesse um modo melhor de fazer isso nao eh mesmo
	if porc_acertos - (int)(porc_acertos) >= 0.5:
		estrelas[(int)(porc_acertos)].frame = 1
		#nao rotacionar a estrela meia, ela ta sendo rotacionada msm assim #TODO
		
	# --------------------------------------------------------------------------
	# stats (em cima da tela de parabens) --------------------------------------
	
	var stats := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/STATS")
	if stats is Label:
		stats.text = "Tecladas: %d (%d), Erros: %d (%d), Tempo (s): %d (%d); LPM: %d (%d); WPM: %d (%d)." % [g.qnt_tecladas, g.qnt_tecladas_total, g.qnt_erros, g.qnt_erros_total, g.tempo_passado_seg, g.tempo_passado_seg_total, g.lpm, g.lpm_total, g.wpm, g.wpm_total]
	
	# --------------------------------------------------------------------------
	# botoes da tela de parabens -----------------------------------------------
	
	var label := get_node_or_null("PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Parabens")
	var button := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/GridContainer/continuar")
	if button is Button and label is Label:
		label.text = "PARABÉNS POR PASSAR 
O NÍVEL "
		match g.dificuldade:
			"n":
				g.dificuldade = "q"
				button.text = "QWERTY >"
				label.text = label.text + "NUMEROS!"
				next = "res://scenes/tutorial.tscn"
				g.n = false
				t(1, true)
			"q": 
				g.dificuldade = "as"
				button.text = "ASDF >"
				label.text = label.text + "QWERTY!"
				next = "res://scenes/tutorial.tscn"
				g.n = false
				t(2, true)
			"as": 
				g.dificuldade = "z"
				button.text = "ZXCV >"
				label.text = label.text + "ASDF!"
				next = "res://scenes/tutorial.tscn"
				g.n = false
				t(3, true)
			"z": 
				g.dificuldade = "e"
				button.queue_free()#button.text = "ESPAÇO >"
				label.text = label.text + "ZXCV!"
				next = "res://scenes/tutorial.tscn"
				g.n = false
				t(4, true)
			"e": 
				g.dificuldade = "f"
				button.text = "FÁCIL >"
				label.text = label.text + "ESPAÇO!"
				g.n = true
				next = "res://scenes/jogo.tscn"
			"f": 
				g.dificuldade = "m"
				button.text = "Médio >"
				label.text = label.text + "FÁCIL!"
				next = "res://scenes/jogo.tscn"
				g.n = true
				t(1, false)
			"m": 
				g.dificuldade = "d"
				button.text = "Díficil >"
				label.text = label.text + "MÉDIO!"
				next = "res://scenes/jogo.tscn"
				g.n = true
				t(2, false)
			"d": 
				g.dificuldade = "a"
				button.queue_free()#button.text = "Acentos >"
				label.text = label.text + "DÍFICIL!"
				next = "res://scenes/jogo.tscn"
				g.n = true
				t(3, false)
			"a": 
				g.dificuldade = "t"
				button.text = "Tempo >"
				label.text = label.text + "ACENTOS!"
				next = "res://scenes/jogo.tscn"
				g.n = true
				t(4, false)
			"t":
				label.text = label.text + "TEMPO!" #insrir tempo
				button.queue_free()
	# --------------------------------------------------------------------------
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_niveis.tscn")
	pass # Replace with function body.


func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file(next)
	pass # Replace with function body.
