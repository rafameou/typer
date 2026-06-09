extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var botao_sair := get_node_or_null("PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/GridContainer/sa")
	if OS.get_name() == "Web" and botao_sair is Button:
		botao_sair.queue_free() #botao_sair.disabled = true
	var versao := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/Label")
	if versao is Label:
		versao.text = "TYPER v%s (%s) ; https://meou.boo/typer" % [ProjectSettings.get_setting("application/config/version"), OS.get_name()]
	var license := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/Label")
	if license is Label:
		license.text = ""
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_niveis.tscn")
	pass # Replace with function body.


func _on_opcoes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/opcoes.tscn")
	pass # Replace with function body.


func _on_sair_pressed() -> void:
	get_tree().quit(1)
	pass # Replace with function body.


func _on_so_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sobre.tscn")
	pass # Replace with function body.
