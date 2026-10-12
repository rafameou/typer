extends Node2D

var black_screen;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen = get_node_or_null("ColorRect");
	#TODO, null check
	if g.tuto_bump >= 1:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer/1f").disabled = false
	if g.tuto_bump >= 2:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer/2f").disabled = false
	if g.tuto_bump >= 3:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer/3f").disabled = false
	if g.tuto_bump >= 4:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer/esp").disabled = false
	
	if g.nivel_bump >= 1:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer2/me").disabled = false
	if g.nivel_bump >= 2:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer2/di").disabled = false
	if g.nivel_bump >= 3:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer2/ac").disabled = false
	if g.nivel_bump >= 4:
			get_node("PanelContainer/MarginContainer/VBoxContainer2/HBoxContainer/GridContainer/GridContainer2/tem").disabled = false
	pass # Replace with function body.

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
			get_tree().change_scene_to_file(switcheroo);
	pass

func _on_button_pressed() -> void:
	switcheroo ="res://scenes/menu_iniciar.tscn";
	pass # Replace with function body.


func _on_nm_pressed() -> void:
	g.dificuldade = "n";
	g.n = false
	switcheroo ="res://scenes/tutorial.tscn";
	pass # Replace with function body.


func _on_fa_pressed() -> void:
	g.dificuldade = "f";
	g.n = true
	switcheroo ="res://scenes/jogo.tscn";
	pass # Replace with function body.


func _on_me_pressed() -> void:
	g.dificuldade = "m"
	g.n = true
	switcheroo ="res://scenes/jogo.tscn";
	pass # Replace with function body.


func _on_di_pressed() -> void:
	g.dificuldade = "d"
	g.n = true
	switcheroo ="res://scenes/jogo.tscn";
	pass # Replace with function body.


func _on_ac_pressed() -> void:
	g.dificuldade = "a"
	g.n = true
	switcheroo ="res://scenes/jogo.tscn";
	pass # Replace with function body.


func _on_tem_pressed() -> void:
	g.dificuldade = "t"
	g.n = true
	switcheroo ="res://scenes/jogo.tscn";
	pass # Replace with function body.


func _on_f_pressed() -> void:
	g.dificuldade = "q"
	g.n = false
	switcheroo ="res://scenes/tutorial.tscn";
	pass # Replace with function body.


func _on_df_pressed() -> void:
	g.dificuldade = "az"
	g.n = false
	switcheroo ="res://scenes/tutorial.tscn";
	pass # Replace with function body.


func _on_tf_pressed() -> void:
	g.dificuldade = "z"
	g.n = false
	switcheroo ="res://scenes/tutorial.tscn";
	pass # Replace with function body.


func _on_esp_pressed() -> void:
	g.dificuldade = "e"
	g.n = false
	switcheroo ="res://scenes/tutorial.tscn";
	pass # Replace with function body.
