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
