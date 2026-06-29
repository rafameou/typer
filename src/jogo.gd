extends Node2D

var palavra_escrita = null
var palavra_backup = ""
var palavra_tts = ""
var index_palavra = 0
var index_palavra_bruh = 0
var palavra_escrita_dois = null
var grupo_palavras_selecionado = null

var button_shift = null
var button_ac = null
var button_til = null

var mao_esquerda = null
var mao_direita = null

func setup_teclado():
	#pegar cada botao dentro do vboxcontainer e gridconatainer
	for i in $PanelContainer/MarginContainer/Teclado/VBoxContainer.get_children():
		for j in i.get_children():
			if j is Button:
				#print(j.name)
				j.pressed.connect(_on_botao_teclado_pressed.bind(j))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
	setup_teclado()
	if g.n:
		palavra_escrita = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/palavra_escrita")
	#palavra_escrita_dois = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/palavra_escrita2")
	button_shift = find_child("shift")
	button_ac = find_child("ac")
	button_til = find_child("til")
	
	mao_esquerda = get_node_or_null("PanelContainer/MarginContainer/HBoxContainer3/VBoxContainer/mao_esquerda")
	mao_direita = get_node_or_null("PanelContainer/MarginContainer/HBoxContainer4/VBoxContainer/mao_direita")
	
	grupo_palavras_selecionado = g.palavras_facil
	g.qnt_erros = 0
	g.qnt_tecladas = 0
	
	match g.dificuldade:
		"n":
			grupo_palavras_selecionado = g.palavras_tutorial_num
		"q": 
			grupo_palavras_selecionado = g.palavras_tutorial_qwerty
		"as": 
			grupo_palavras_selecionado = g.palavras_tutorial_asdf
		"z": 
			grupo_palavras_selecionado = g.palavras_tutorial_zxcv
		"e": 
			grupo_palavras_selecionado = g.palavras_tutorial_espaco
		"m": 
			grupo_palavras_selecionado = g.palavras_medias
		"d": 
			grupo_palavras_selecionado = g.palavras_dificeis
		"a": 
			grupo_palavras_selecionado = g.palavras_acentos
		"t": 
			grupo_palavras_selecionado = g.palavras_facil + g.palavras_medias + g.palavras_dificeis + g.palavras_acentos
			# randomize
	
	#https://stackoverflow.com/a/75349704
	g.time = Time.get_time_dict_from_system()
	
	palavra_backup = grupo_palavras_selecionado[index_palavra_bruh]
	var valor_salvo = colorir()
	if g.n:
		palavra_escrita.text = valor_salvo
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func botao_neutro(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/neutral_button.tres"))
	button.add_theme_color_override("font_color", Color(255, 255, 255))
	
func botao_verde(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/green_button.tres"))
	button.add_theme_color_override("font_color", Color(0, 0, 0))
	
func botao_vermelho(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/red_button.tres"))
	button.add_theme_color_override("font_color", Color(255, 255, 255))
	
func colorir():
	if index_palavra > 0:
		var old_button = find_child(palavra_backup[index_palavra-1])
		if old_button is Button:
			botao_neutro(old_button)
		if g.toggle_vizinhos:
			var lista_vizinhos_m = g.vizinhos.get(palavra_backup[index_palavra-1])
			if lista_vizinhos_m is Array:
				for i in lista_vizinhos_m:
					var old_button_vizinho = find_child(i)
					if old_button_vizinho is Button:
						botao_neutro(old_button_vizinho)
	
	if palavra_backup.length() <= index_palavra:
		palavra_tts = ""
		index_palavra_bruh = index_palavra_bruh + 1
		if grupo_palavras_selecionado.size() > index_palavra_bruh:
			palavra_backup = grupo_palavras_selecionado[index_palavra_bruh]
			index_palavra = 0
		else:
			var timed = Time.get_time_dict_from_system()
			#isso ta certo? kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk (edit: nao tava certo)
			g.tempo_passado_seg = ((timed.minute * 60) + timed.second) - ((g.time.minute * 60) + g.time.second)
			g.tempo_passado_seg_total = g.tempo_passado_seg_total + g.tempo_passado_seg
			#deveriamos considerar erros? tecladas-erro? (edit: nao precisa mais por causa das estrelas)
			g.lpm = (float)(g.qnt_tecladas) / ((float)(g.tempo_passado_seg) / 60.0)
			g.lpm_total = (float)(g.qnt_tecladas_total) / ((float)(g.tempo_passado_seg_total) / 60.0)
			g.wpm = (float)(grupo_palavras_selecionado.size()) / ((float)(g.tempo_passado_seg) / 60.0)
			g.qnt_palavras_total = g.qnt_palavras_total + grupo_palavras_selecionado.size();
			g.wpm_total = (float)(g.qnt_palavras_total) / ((float)(g.tempo_passado_seg_total) / 60.0)
			get_tree().change_scene_to_file("res://scenes/parabens.tscn")
			return ""
		
	mao_esquerda.set_frame(0)
	mao_direita.set_frame(0)
	if index_palavra > 0 and palavra_backup[index_palavra] == " ":
		var dedo_anterior = g.dedo_correto.get(palavra_backup[index_palavra-1])
		if dedo_anterior < 5:
			mao_esquerda.set_frame(5)
		else:
			mao_direita.set_frame(1)
	elif palavra_backup[index_palavra] == "Á" or palavra_backup[index_palavra] == "Ê" or palavra_backup[index_palavra] == "Ã":
		pass
	else:	
		var dedo = g.dedo_correto.get(palavra_backup[index_palavra])
		if dedo < 5:
			mao_esquerda.set_frame(dedo)
		else:
			mao_direita.set_frame(dedo-5)
	
	if !g.toggle_d_som and !g.toggle_v_fala:
		DisplayServer.tts_stop()
		DisplayServer.tts_speak(palavra_backup[index_palavra], g.voice_id)
		
	var button = find_child(palavra_backup[index_palavra])
	if button is Button:
		botao_verde(button)
	else: #yes baby i'm the lizard king
		var accent = palavra_backup[index_palavra]
		if accent == "Á":
			botao_verde(button_ac)
		elif accent == "Ê":
			botao_verde(button_shift)
			botao_verde(button_til)
		elif accent == "Ã":
			botao_verde(button_til)
		#https://github.com/godotengine/godot-proposals/issues/3250
		var regex = TextServerManager.get_primary_interface().strip_diacritics(palavra_backup)
		var regexxed = find_child(regex[index_palavra])
		if regexxed is Button:
			botao_verde(regexxed)
	
	if g.toggle_vizinhos:
		var lista_vizinhos = g.vizinhos.get(palavra_backup[index_palavra])
		if lista_vizinhos is Array:
			for i in lista_vizinhos:
				var button_vizinho = find_child(i)
				if button_vizinho is Button:
					botao_vermelho(button_vizinho)
	
	if g.n:
		var resultado = ""
		for i in range(palavra_backup.length()):
			if i == index_palavra:
				resultado += "[color=green]%s[/color]" % [palavra_backup[i]]
				palavra_tts += palavra_backup[i]
				if !g.toggle_d_som and g.toggle_v_fala:
					DisplayServer.tts_stop()
					DisplayServer.tts_speak(palavra_tts, g.voice_id)
			else:
				resultado += palavra_backup[i]
		return resultado
	
func receber_tecla(tecla: String):
	if palavra_backup.length() <= index_palavra:
		print("bit cosmico")
		return 
		
	var button := find_child(tecla)
	if button is Button:
		button.add_theme_stylebox_override("normal", button.get_theme_stylebox("pressed"))
		await get_tree().create_timer(0.1).timeout
		button.add_theme_stylebox_override("normal", load("res://buttons/neutral_button.tres"))
		
	var label_tester = true
	if g.n:
		label_tester = palavra_escrita is RichTextLabel

	#dirtyfix #TODO
	if palavra_backup[index_palavra] != "Ç":
		var regex = TextServerManager.get_primary_interface().strip_diacritics(palavra_backup)
		if label_tester and regex[index_palavra] == tecla:
			g.qnt_tecladas = g.qnt_tecladas + 1
			g.qnt_tecladas_total = g.qnt_tecladas_total + 1
			index_palavra = index_palavra + 1
			var valor_salvo = colorir()
			if g.n:
				palavra_escrita.text = valor_salvo
			#palavra_escrita.text = palavra_escrita.text.substr(1)
			#palavra_escrita_dois.text = palavra_escrita_dois.text + tecla
		else:
			g.qnt_erros = g.qnt_erros + 1
			g.qnt_erros_total = g.qnt_erros_total + 1

func _input(event):
	if event is InputEventKey and event.is_pressed():
		#print(event.as_text())
		receber_tecla(event.as_text())


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_niveis.tscn")
	pass # Replace with function body.


func _on_botao_teclado_pressed(botao: Button):
	#print(botao.name)
	receber_tecla(botao.name)
	pass # Replace with function body.
