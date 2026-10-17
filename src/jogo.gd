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
var button_semicolon = null
var button_espaco = null

var mao_esquerda = null
var mao_direita = null

var text_outline_animation = 0.0;
var explosion_animation = 0.0;
var explosion_bumping = 10.0;
var button_animation = 0.0;

var start_animation = 1.0;

var line_edit = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen = get_node_or_null("ColorRect");
	timer_label = get_node_or_null("PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/Timer")
	
	line_edit = get_node_or_null("LineEdit");
	line_edit.set_keep_editing_on_text_submit(true);
	line_edit.edit();
	
	#print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
	
	#pegar cada botao dentro do vboxcontainer e gridconatainer
	for i in $PanelContainer/MarginContainer/Teclado/VBoxContainer.get_children():
		for j in i.get_children():
			if j is Button:
				#print(j.name)
				if !g.teclado_virtual && g.n:
					j.hide();
				j.pressed.connect(_on_botao_teclado_pressed.bind(j))
				
	if g.n:
		palavra_escrita = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/palavra_escrita")
	#palavra_escrita_dois = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/palavra_escrita2")
	button_shift = find_child("shift")
	button_ac = find_child("ac")
	button_til = find_child("til")
	button_semicolon = find_child("Semicolon")
	button_espaco = find_child("espaço")
	
	mao_esquerda = get_node_or_null("PanelContainer/MarginContainer/HBoxContainer3/VBoxContainer/mao_esquerda")
	mao_direita = get_node_or_null("PanelContainer/MarginContainer/HBoxContainer4/VBoxContainer/mao_direita")
	
	grupo_palavras_selecionado = g.palavras_facil
	g.qnt_erros = 0
	g.qnt_tecladas = 0
	g.time = 0;
	
	randomize()
	
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
	
	if g.randomize_no_jogo_normal || g.dificuldade == "t":
		#https://www.reddit.com/r/godot/comments/1khiih1/comment/mr786lz/
		grupo_palavras_selecionado = grupo_palavras_selecionado.duplicate();
		grupo_palavras_selecionado.shuffle();
	
	palavra_backup = grupo_palavras_selecionado[index_palavra_bruh]
	var valor_salvo = colorir()
	if g.n:
		palavra_escrita.text = valor_salvo
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var black_screen;
var timer_label;
func _process(_delta: float) -> void:
	if g.animacoes_de_menu:
		if start_animation > 0:
			start_animation -= 0.1;
			if black_screen:
				black_screen.set_color(Color(0,0,0,start_animation));
	else:
		if black_screen:
			black_screen.set_color(Color(0,0,0,0.0));
			
	#TODO, bad practive
	#if !line_edit.is_editing():
	#	line_edit.edit();
	
	g.time += _delta;
	if g.n:
		if g.tempo_no_jogo_normal:
			timer_label.text =  "%02d:%02d" % [g.time / 60, fmod(g.time, 60)]
		
		if g.outline_em_erro == true && text_outline_animation > 0:
			text_outline_animation -= 0.01;
			var animation_reverted = 1.0 - text_outline_animation;
			palavra_escrita.add_theme_color_override("default_color", Color(1.0, animation_reverted, animation_reverted, 1.0));
			palavra_escrita.add_theme_color_override("font_outline_color", Color(1,0,0,text_outline_animation));
	
	if g.shake_em_erro == true && explosion_animation > 0:
		explosion_animation -= 1;
		for element in get_all_children(get_tree().get_root()):
			if element is Button || element is AnimatedSprite2D || element is Label || element is RichTextLabel:
				#print(element.get_instance_id() % 1 );
				if element.get_instance_id() % 2 == 0:
					element.position.x -= float(element.get_instance_id() % 10) / explosion_bumping;
					element.position.y += float(element.get_instance_id() % 10) / explosion_bumping;
				else:
					element.position.x += float(element.get_instance_id() % 10) / explosion_bumping;
					element.position.y -= float(element.get_instance_id() % 10) / explosion_bumping;
	pass
	
func botao_neutro(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/neutral_button.tres"))
	button.add_theme_color_override("font_color", Color(255, 255, 255))
	
func botao_verde(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/green_button.tres"))
	button.add_theme_color_override("font_color", Color(0, 0, 0))
	
func botao_vermelho(button: Button):
	button.add_theme_stylebox_override("normal", load("res://buttons/blue_button.tres"))
	button.add_theme_color_override("font_color", Color(255, 255, 255))
	
func colorir():
	if index_palavra > 0:
		var old_button = find_child(palavra_backup[index_palavra-1])
		if old_button is Button:
			botao_neutro(old_button)
		else:
			var accent = palavra_backup[index_palavra-1]
			match accent:
				"Á","É", "Í", "Ó", "Ú":
					botao_neutro(button_ac);
				"À", "È", "Ì", "Ò", "Ù":
					botao_neutro(button_shift);
					botao_neutro(button_ac);
				"Â", "Ê", "Î", "Ô", "Ú":
					botao_neutro(button_shift);
					botao_neutro(button_til);
				"Ã", "Ñ", "Õ":
					botao_neutro(button_til);
				"Ç":
					botao_neutro(button_semicolon);
				" ":
					botao_neutro(button_espaco);
				_:
					print("acento do mal: " + accent);
					#https://github.com/godotengine/godot-proposals/issues/3250
			var regex = TextServerManager.get_primary_interface().strip_diacritics(palavra_backup)
			var regexxed = find_child(regex[index_palavra-1])
			if regexxed is Button && palavra_backup[index_palavra-1] != "Ç":
				botao_neutro(regexxed)
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
			g.tempo_passado_seg = g.time;
			g.tempo_passado_seg_total = g.tempo_passado_seg_total + g.tempo_passado_seg
			var minutos = (float)(g.time) / 60.0;
			g.lpm = (float)(g.qnt_tecladas) / (minutos)
			g.lpm_total = (float)(g.qnt_tecladas_total) / (minutos)
			g.wpm = (float)(g.qnt_tecladas / 5.0) / (minutos);
			g.wpm_total = (float)(g.qnt_tecladas_total / 5.0) / (minutos);
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
		match accent:
			"Á","É", "Í", "Ó", "Ú":
				botao_verde(button_ac);
			"À", "È", "Ì", "Ò", "Ù":
				botao_verde(button_shift);
				botao_verde(button_ac);
			"Â", "Ê", "Î", "Ô", "Ú":
				botao_verde(button_shift);
				botao_verde(button_til);
			"Ã", "Ñ", "Õ":
				botao_verde(button_til);
			"Ç":
				botao_verde(button_semicolon);
			" ":
				botao_verde(button_espaco);
			_:
				print("acento do mal: " + accent)
		#https://github.com/godotengine/godot-proposals/issues/3250
		var regex = TextServerManager.get_primary_interface().strip_diacritics(palavra_backup)
		var regexxed = find_child(regex[index_palavra])
		if regexxed is Button && palavra_backup[index_palavra] != "Ç":
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

# https://forum.godotengine.org/t/how-do-i-get-all-nodes-from-a-scene/49088/2		
func get_all_children(in_node, array := []):
	array.push_back(in_node)
	for child in in_node.get_children():
		array = get_all_children(child, array)
	return array
	
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

	if label_tester and palavra_backup[index_palavra] == tecla:
		g.qnt_tecladas = g.qnt_tecladas + 1
		g.qnt_tecladas_total = g.qnt_tecladas_total + 1
		index_palavra = index_palavra + 1
		var valor_salvo = colorir()
		if g.n:
			palavra_escrita.text = valor_salvo
		#palavra_escrita.text = palavra_escrita.text.substr(1)
		#palavra_escrita_dois.text = palavra_escrita_dois.text + tecla
	else:
		if g.shake_em_erro:
			for element in get_all_children(get_tree().get_root()):
				if element is Button || element is AnimatedSprite2D || element is Label || element is RichTextLabel:
					#print(element.get_instance_id());
					if element.get_instance_id() % 2 == 0:
						element.position.x += element.get_instance_id() % 10;
						element.position.y -= element.get_instance_id() % 10;
					else:
						element.position.x -= element.get_instance_id() % 10;
						element.position.y += element.get_instance_id() % 10;
			explosion_animation += explosion_bumping; #randi_range(-5, 20);
					
		if g.n:		
			text_outline_animation = 1.0;
			if g.outline_em_erro:
				palavra_escrita.add_theme_color_override("default_color", Color.RED);
			if g.cor_vermelha_em_erro:
				palavra_escrita.add_theme_color_override("font_outline_color", Color.RED);
			
		g.qnt_erros = g.qnt_erros + 1
		g.qnt_erros_total = g.qnt_erros_total + 1

func _input(event):
	if event is InputEventKey and event.is_pressed():
		#print(event)
		#print(event.get_key_label())
		#print(event.unicode)
		if line_edit.is_editing: #basicamente o edit saiu por algum motivo e
								 #agora precisamos gambiarrar por causa disso
			line_edit.edit();
		#print(event.as_text())
		#receber_tecla(event.as_text())
		#TODO, usar esse local para tirar o "shift" e acentos das teclas
		#verdes, porém lembrar de "readicionar" caso o usuário erre o acento.
	pass

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_niveis.tscn")
	pass # Replace with function body.

func _on_botao_teclado_pressed(botao: Button):
	#print(botao.name)
	#TODO, implementar acentos
	receber_tecla(botao.name)
	pass # Replace with function body.

func _on_line_edit_text_changed(new_text: String) -> void:
	#print(new_text.capitalize());
	receber_tecla(new_text.capitalize());
	line_edit.set_text("");
	pass # Replace with function body.
