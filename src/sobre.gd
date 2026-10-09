extends Node2D


# Called when the node enters the scene tree for the first time.
var black_screen;
func _ready() -> void:
	black_screen = get_node_or_null("ColorRect");
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var start_animation = 1.0;
var left_animation = 0;
func _process(_delta: float) -> void:
	if g.animacoes_de_menu:
		if start_animation > 0:
			start_animation -= 0.1;
			if black_screen:
				black_screen.set_color(Color(0,0,0,start_animation));
	else:
		if black_screen:
			black_screen.set_color(Color(0,0,0,0.0));
	pass
	
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_iniciar.tscn")
	pass # Replace with function body.
