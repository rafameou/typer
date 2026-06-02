extends Node2D

var next = "res://menu_niveis.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var label := get_node_or_null("PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Label")
	var button := get_node_or_null("PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer/continuar")
	if button is Button and label is Label:
		if g.dificuldade == "n":
			g.dificuldade = "q"
			button.text = "QWERTY →"
			label.text = label.text + "NUMEROS!"
			next = "res://tutorial.tscn"
		elif g.dificuldade == "q": 
			g.dificuldade = "a"
			button.text = "ASDF →"
			label.text = label.text + "QWERTY!"
			next = "res://tutorial.tscn"
		elif g.dificuldade == "a": 
			g.dificuldade = "z"
			button.text = "ZXCV →"
			label.text = label.text + "ASDF!"
			next = "res://tutorial.tscn"
		elif g.dificuldade == "z": 
			g.dificuldade = "e"
			button.text = "ESPAÇO →"
			label.text = label.text + "ZXCV!"
			next = "res://tutorial.tscn"
		elif g.dificuldade == "e": 
			g.dificuldade = "f"
			button.text = "FÁCIL →"
			label.text = label.text + "ESPAÇO!"
			next = "res://jogo.tscn"
		elif g.dificuldade == "f": 
			g.dificuldade = "m"
			button.text = "Médio →"
			label.text = label.text + "FÁCIL!"
			next = "res://jogo.tscn"
		elif g.dificuldade == "m": 
			g.dificuldade = "d"
			button.text = "Díficil →"
			label.text = label.text + "MÉDIO!"
			next = "res://jogo.tscn"
		elif g.dificuldade == "d": 
			g.dificuldade = "a"
			button.text = "Acentos →"
			label.text = label.text + "DÍFICIL!"
			next = "res://jogo.tscn"
		elif g.dificuldade == "a": 
			g.dificuldade = "t"
			button.text = "Tempo →"
			label.text = label.text + "ACENTOS!"
			next = "res://jogo.tscn"
		else:
			label.text = label.text + "TEMPO!" #insrir tempo
			button.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_niveis.tscn")
	pass # Replace with function body.


func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.
