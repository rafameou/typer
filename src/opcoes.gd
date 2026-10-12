extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button1 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton")
	var button2 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton2")
	var button3 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton3")
	var button4 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton4")
	var button5 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton5")
	var button6 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton6")
	var button7 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton7")
	var button8 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton8")
	var button9 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton9")
	var button10 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton10")
	var button11 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/CheckButton11")
	
	if !button1 || !button2 || !button3 || !button4 || !button5 || !button6 || !button7 || !button8 || !button9 || !button10 || !button11:
		pass #print("wtf")
		
	button1.button_pressed = g.toggle_vizinhos;
	button2.button_pressed = true if g.nivel_bump == 4 else false;
	button3.button_pressed = g.toggle_d_som;
	button4.button_pressed = g.toggle_v_fala;
	button5.button_pressed = g.animacoes_de_menu;
	button6.button_pressed = g.teclado_virtual;
	button7.button_pressed = g.cor_vermelha_em_erro;
	button8.button_pressed = g.outline_em_erro;
	button9.button_pressed = g.shake_em_erro;
	button10.button_pressed = g.tempo_no_jogo_normal;
	button11.button_pressed = g.randomize_no_jogo_normal;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_iniciar.tscn")
	pass # Replace with function body.

func _on_check_button_toggled(toggled_on: bool) -> void:
	g.toggle_vizinhos = toggled_on
	pass # Replace with function body.

func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on:
		g.tuto_bump = 4
		g.nivel_bump = 4
	else:
		g.tuto_bump = 0
		g.nivel_bump = 0
	pass # Replace with function body.

func _on_check_button_3_toggled(toggled_on: bool) -> void:
	g.toggle_d_som = toggled_on
	if !g.voices:
		g.toggle_d_som = true
	pass # Replace with function body.

func _on_check_button_4_toggled(toggled_on: bool) -> void:
	g.toggle_v_fala = toggled_on
	pass # Replace with function body.


func _on_check_button_5_toggled(toggled_on: bool) -> void:
	g.animacoes_de_menu = toggled_on
	pass # Replace with function body.


func _on_check_button_6_toggled(toggled_on: bool) -> void:
	g.teclado_virtual = toggled_on
	pass # Replace with function body.


func _on_check_button_7_toggled(toggled_on: bool) -> void:
	g.cor_vermelha_em_erro = toggled_on
	pass # Replace with function body.


func _on_check_button_8_toggled(toggled_on: bool) -> void:
	g.outline_em_erro = toggled_on
	pass # Replace with function body.


func _on_check_button_9_toggled(toggled_on: bool) -> void:
	g.shake_em_erro = toggled_on
	pass # Replace with function body.


func _on_check_button_10_toggled(toggled_on: bool) -> void:
	g.tempo_no_jogo_normal = toggled_on
	pass # Replace with function body.


func _on_check_button_11_toggled(toggled_on: bool) -> void:
	g.randomize_no_jogo_normal = toggled_on;
	pass # Replace with function body.
