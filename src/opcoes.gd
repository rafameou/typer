extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
