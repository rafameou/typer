extends Node2D
var black_screen;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen = get_node_or_null("ColorRect");
	var botao_sair := get_node_or_null("PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer/sa")
	if OS.get_name() == "Web" and botao_sair is Button:
		botao_sair.queue_free() #botao_sair.disabled = true
	var versao := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/Label")
	if versao is Label:
		versao.text = "TYPER v%s (%s) ; https://meou.boo/typer" % [ProjectSettings.get_setting("application/config/version"), OS.get_name()]
	var license := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/Label")
	if license is Label:
		license.text = ""
		
	#@PMRL-BAMPMRL-BAM Apr 27
	#If you want to test the Godot TTS through the Steam client and are on linux (particularly Arch based aka, what I have),
	#make sure to force Steam to use a specific compatibility tool, like Legacy runtime 1.0
	#https://docs.godotengine.org/en/stable/tutorials/audio/text_to_speech.html
	g.voices = DisplayServer.tts_get_voices_for_language("pt")
	if g.voices:
		g.voice_id = g.voices[0]
	else:
		print("sem suporte pra tts pt, mudando pra en")
		g.voices = DisplayServer.tts_get_voices_for_language("en")
		if g.voices:
			g.voice_id = g.voices[0]
		else:
			print("sem suporte pra tts en")
			versao.text = versao.text + " (sem suporte pra TTS)"
			g.toggle_d_som = true
	
	if !g.toggle_d_som:	
		DisplayServer.tts_stop()
		DisplayServer.tts_speak("Bem-vindo ao taipher!", g.voice_id)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var start_animation = 1.0;
var left_animation = 0;
var switcheroo = "";
func _process(_delta: float) -> void:
	if g.animacoes_de_menu:
		if start_animation > 0:
			start_animation -= 0.1;
			if black_screen:
				black_screen.set_color(Color(0,0,0,start_animation));
	else:
		if black_screen:
			black_screen.set_color(Color(0,0,0,0.0));
	
	if switcheroo != "":
		if left_animation < 1.0:
			left_animation += 0.1;
			if black_screen:
				black_screen.set_color(Color(0,0,0,left_animation));
		if left_animation >= 1.0 || !g.animacoes_de_menu:
			if switcheroo != "quit":
				get_tree().change_scene_to_file(switcheroo);
			else:
				get_tree().quit(1)
	pass

func _on_iniciar_pressed() -> void:
	#while left_animation != 1.0: pass
	switcheroo = "res://scenes/menu_niveis.tscn";
	pass # Replace with function body.

func _on_opcoes_pressed() -> void:
	switcheroo = "res://scenes/opcoes.tscn";
	pass # Replace with function body.

func _on_sair_pressed() -> void:
	switcheroo = "quit"
	pass # Replace with function body.


func _on_so_pressed() -> void:
	switcheroo = "res://scenes/sobre.tscn";
	pass # Replace with function body.
