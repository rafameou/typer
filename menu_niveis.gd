extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_iniciar.tscn")
	pass # Replace with function body.


func _on_nm_pressed() -> void:
	g.dificuldade = "n";
	get_tree().change_scene_to_file("res://tutorial.tscn")
	pass # Replace with function body.


func _on_fa_pressed() -> void:
	g.dificuldade = "f";
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_me_pressed() -> void:
	g.dificuldade = "m"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_di_pressed() -> void:
	g.dificuldade = "d"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_ac_pressed() -> void:
	g.dificuldade = "a"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_tem_pressed() -> void:
	g.dificuldade = "t"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_f_pressed() -> void:
	g.dificuldade = "t"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_df_pressed() -> void:
	g.dificuldade = "t"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_tf_pressed() -> void:
	g.dificuldade = "t"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.


func _on_esp_pressed() -> void:
	g.dificuldade = "t"
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.
